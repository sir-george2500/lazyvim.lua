return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
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
    })
  end,
}
