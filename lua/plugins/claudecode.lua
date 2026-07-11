-- Claude Code integration (uses the same protocol as the official VS Code extension).
-- <leader>aa or Ctrl+, calls up the agent in a side terminal.
--
-- Interface-first workflow: write a function signature + doc comment, visually
-- select it, hit <leader>ai. Claude gets a prompt to implement exactly that
-- function. The prompt is left UNSUBMITTED in Claude's input so you can review,
-- edit, and press Enter yourself.

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

-- Visual mode: treat the selection as a function interface and ask Claude
-- to implement its body, and nothing else.
local function implement_interface()
  local vpos, cpos = vim.fn.getpos("v"), vim.fn.getpos(".")
  local lstart, lend = vpos[2], cpos[2]
  if lstart > lend then
    lstart, lend = lend, lstart
  end
  local selection = table.concat(vim.api.nvim_buf_get_lines(0, lstart - 1, lend, false), "\n")
  local file = vim.fn.expand("%:.")
  local ft = vim.bo.filetype

  -- leave visual mode before the input prompt pops up
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

  vim.ui.input({ prompt = "Notes for Claude (optional): " }, function(notes)
    if notes == nil then
      return -- cancelled
    end
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
    { "<leader>ai", implement_interface, mode = "v", desc = "Implement selected interface" },
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
