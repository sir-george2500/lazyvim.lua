default_notebook_URL = "localhost:8890/tree"

return {
  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    config = function()
      local jupynium = require("jupynium")
      jupynium.setup({
        python_host = "python3",
        use_default_keybindings = true,
        auto_download_ipynb = true,
        auto_start_sync = { enable = false },
        jupyter_attach_behaviour = "ask",
        notebook_dir = "~/notebooks",
        jupyter_command = "jupyter",
        jupyter_args = { "--no-browser", "--port=8890" }, -- Ensure it matches the port
        auto_quit_server = false,
        firefox_profiles = { "default" },
        browser_timeout = 120,
        debug = true,
      })
      jupynium.set_default_keymaps()
    end,
  },
  "rcarriga/nvim-notify",
  "stevearc/dressing.nvim",
}
