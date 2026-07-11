return {
  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    opts = {
      python_host = "python3",
      use_default_keybindings = true,
      auto_download_ipynb = true,
      auto_start_sync = { enable = false },
      jupyter_attach_behaviour = "ask",
      notebook_dir = "~/notebooks",
      jupyter_command = "jupyter",
      jupyter_args = { "--no-browser", "--port=8890" },
      auto_quit_server = false,
      firefox_profiles = { "default" },
      browser_timeout = 120,
    },
  },
}
