-- Extend the LazyVim copilot extra: keep inline ghost-text suggestions
-- with custom keymaps (vim.g.ai_cmp = false in options.lua enables this).
return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<C-l>", -- Accept suggestion
        next = "<C-j>", -- Next suggestion
        prev = "<C-k>", -- Previous suggestion
        dismiss = "<C-h>", -- Dismiss suggestion
      },
    },
    panel = { enabled = true },
  },
}
