return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true, auto_trigger = true },
        panel = { enabled = true },
        filetypes = {
          ["*"] = true, -- Enable Copilot for all filetypes
        },
      })
    end,
  },
}
