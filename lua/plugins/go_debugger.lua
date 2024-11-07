return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    -- Configure the Go adapter using Delve
    dap.adapters.go = {
      type = "server",
      host = "127.0.0.1",
      port = 38697, -- Default port for Delve
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:38697" }, -- DAP connection via Delve
      },
    }

    -- Go debugging configuration
    dap.configurations.go = {
      {
        type = "go",
        name = "Debug current file",
        request = "launch",
        program = "${file}", -- Launch the current file for debugging
      },
      {
        type = "go",
        name = "Debug package",
        request = "launch",
        program = "${workspaceFolder}", -- Debug the entire package within the workspace
      },
      {
        type = "go",
        name = "Attach to process",
        request = "attach",
        processId = require("dap.utils").pick_process, -- Pick the process to attach to
      },
    }

    -- Optionally, set up automatic Delve start/stop
    dap.listeners.after.event_initialized["delve_start"] = function()
      print("Delve DAP Adapter started for Go")
    end
    dap.listeners.before.event_terminated["delve_stop"] = function()
      print("Delve DAP Adapter terminated")
    end
  end,
}
