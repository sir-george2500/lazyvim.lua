return {
  "dlants/magenta.nvim",
  lazy = false,
  build = "npm install --frozen-lockfile",
  opts = {
    profiles = {
      {
        name = "copilot-claude",
        provider = "copilot",
        model = "claude-sonnet-4", -- Corrected Claude 4 Sonnet model string
        fastModel = "claude-3-5-haiku-latest",
        -- No apiKeyEnvVar needed - uses existing Copilot auth
      },
      {
        name = "copilot-gpt",
        provider = "copilot",
        model = "gpt-5", -- Available through Copilot
        fastModel = "gpt-5-mini",
        -- No apiKeyEnvVar needed
      },
    },
    sidebarPosition = "right",
    picker = "telescope", -- Works with LazyVim
    defaultKeymaps = false, -- Disable default keymaps to use custom ones
    chimeVolume = 0.3,
  },
  keys = {
    -- Toggle sidebar
    { "<leader>mt", "<cmd>MagentaToggleSidebar<cr>", desc = "Toggle Magenta sidebar" },

    -- Chat operations
    { "<leader>mc", "<cmd>MagentaNewChat<cr>", desc = "New Magenta chat" },
    { "<leader>ma", "<cmd>MagentaAddSelection<cr>", desc = "Add selection to chat", mode = "v" },
    { "<leader>ms", "<cmd>MagentaSendMessage<cr>", desc = "Send message to Magenta" },

    -- Quick actions
    { "<leader>me", "<cmd>MagentaExplain<cr>", desc = "Explain selection", mode = "v" },
    { "<leader>mf", "<cmd>MagentaFix<cr>", desc = "Fix code issues", mode = "v" },
    { "<leader>mr", "<cmd>MagentaRefactor<cr>", desc = "Refactor selection", mode = "v" },

    -- Profile switching
    { "<leader>mp", "<cmd>MagentaSelectProfile<cr>", desc = "Select Magenta profile" },

    -- Clear and reset
    { "<leader>mx", "<cmd>MagentaClearChat<cr>", desc = "Clear current chat" },
  },
}
