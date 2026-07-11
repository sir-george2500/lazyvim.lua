-- Claude Code integration (uses the same protocol as the official VS Code extension).
-- <leader>aa or Ctrl+, calls up the agent in a side terminal.
--
-- AI pair-programming loop — you own design and review, Claude fills in the middle:
--   <leader>ai (visual)  implement the selected signature + doc comment
--   <leader>at (visual)  write tests for the selected code
--   <leader>ad (normal)  fix the diagnostic on the current line
--   <leader>aR (normal)  review your uncommitted changes before you commit
-- Every prompt is prefilled but UNSUBMITTED in Claude's input, so you review,
-- edit, and press Enter yourself. Claude's edits come back as diffs you
-- accept (<leader>ay) or reject (<leader>an).

-- Send a prompt into Claude's input box (opens the terminal first if needed).
local function send_prompt(prompt)
  local terminal = require("claudecode.terminal")
  if terminal.get_active_terminal_bufnr() then
    terminal.send_to_terminal(prompt, { submit = false, focus = true })
    return
  end
  terminal.open()
  -- give the claude CLI a moment to boot before pasting into its prompt
  vim.defer_fn(function()
    terminal.send_to_terminal(prompt, { submit = false, focus = true })
  end, 1200)
end

-- Capture the visual selection as whole lines, then leave visual mode.
-- Returns start line, end line, and the selected text.
local function get_visual_selection()
  local vpos, cpos = vim.fn.getpos("v"), vim.fn.getpos(".")
  local lstart, lend = vpos[2], cpos[2]
  if lstart > lend then
    lstart, lend = lend, lstart
  end
  local text = table.concat(vim.api.nvim_buf_get_lines(0, lstart - 1, lend, false), "\n")
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  return lstart, lend, text
end

-- Ask for optional extra notes; calls cb(notes) with "" if skipped,
-- and not at all if cancelled with Esc.
local function ask_notes(cb)
  vim.ui.input({ prompt = "Notes for Claude (optional): " }, function(notes)
    if notes ~= nil then
      cb(notes)
    end
  end)
end

-- Visual mode: treat the selection as a function interface and ask Claude
-- to implement its body, and nothing else.
local function implement_interface()
  local lstart, lend, selection = get_visual_selection()
  local file = vim.fn.expand("%:.")
  local ft = vim.bo.filetype
  ask_notes(function(notes)
    local parts = {
      string.format("I wrote a function interface in %s (lines %d-%d):", file, lstart, lend),
      "",
      "```" .. ft,
      selection,
      "```",
      "",
      "Implement the full body of this function in that file.",
      "- Keep my signature, name, and doc comments exactly as written",
      "- Follow the existing style and conventions of the file",
      "- Do not change any other code",
    }
    if notes ~= "" then
      parts[#parts + 1] = "- " .. notes
    end
    send_prompt(table.concat(parts, "\n"))
  end)
end

-- Visual mode: ask Claude to write tests for the selected code,
-- without touching the implementation.
local function write_tests()
  local lstart, lend, selection = get_visual_selection()
  local file = vim.fn.expand("%:.")
  local ft = vim.bo.filetype
  ask_notes(function(notes)
    local parts = {
      string.format("Write tests for this code from %s (lines %d-%d):", file, lstart, lend),
      "",
      "```" .. ft,
      selection,
      "```",
      "",
      "- Put them in the appropriate test file for this project's conventions (create it if it doesn't exist)",
      "- Follow the style of the existing tests in this repo",
      "- Cover normal cases, edge cases, and error paths",
      "- Do NOT modify the implementation; if you spot a bug while writing tests, report it instead of fixing it",
    }
    if notes ~= "" then
      parts[#parts + 1] = "- " .. notes
    end
    send_prompt(table.concat(parts, "\n"))
  end)
end

-- Normal mode: send the diagnostic(s) on the current line to Claude
-- with instructions to fix exactly that and nothing more.
local function fix_diagnostic()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local diags = vim.diagnostic.get(0, { lnum = lnum - 1 })
  if #diags == 0 then
    vim.notify("No diagnostic on the current line", vim.log.levels.WARN)
    return
  end
  local file = vim.fn.expand("%:.")
  local parts = {
    string.format("Fix the following diagnostic(s) in %s at line %d:", file, lnum),
    "",
    "The line reads:",
    "    " .. vim.api.nvim_get_current_line(),
    "",
  }
  for _, d in ipairs(diags) do
    local label = vim.diagnostic.severity[d.severity] or "INFO"
    local source = d.source and string.format(" [%s%s]", d.source, d.code and (": " .. d.code) or "") or ""
    parts[#parts + 1] = string.format("- %s%s: %s", label, source, d.message)
  end
  vim.list_extend(parts, {
    "",
    "Make the minimal change that fixes this correctly (no suppressions or",
    "ignore-comments unless that is genuinely the right fix). Do not refactor",
    "unrelated code.",
  })
  send_prompt(table.concat(parts, "\n"))
end

-- Normal mode: have Claude review your uncommitted work before you commit.
local function review_changes()
  send_prompt(table.concat({
    "Review my uncommitted changes in this repository:",
    "- Run `git status` and `git diff` (both staged and unstaged) to see them",
    "- Look for bugs, edge cases, missing error handling, and inconsistencies with the surrounding code",
    "- Rank findings by severity, each with a file:line reference",
    "- This is a review only: do not change any code unless I ask afterwards",
  }, "\n"))
end

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal = {
      split_side = "right",
      split_width_percentage = 0.35,
    },
  },
  keys = {
    { "<leader>a", nil, desc = "+ai (Claude Code)", mode = { "n", "v" } },
    { "<leader>aa", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<C-,>", "<cmd>ClaudeCode<cr>", mode = { "n", "t" }, desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude session" },
    { "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last session" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to Claude" },
    -- pair-programming loop
    { "<leader>ai", implement_interface, mode = "v", desc = "Implement selected interface" },
    { "<leader>at", write_tests, mode = "v", desc = "Write tests for selection" },
    { "<leader>ad", fix_diagnostic, desc = "Fix diagnostic on line" },
    { "<leader>aR", review_changes, desc = "Review uncommitted changes" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file to Claude",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },
    -- accept/reject the diffs Claude proposes
    { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
    { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
  },
}
