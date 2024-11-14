return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    -- open dap ui on attach event
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    -- open dap ui on launch event
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    -- close dap ui on event termination
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end

    -- close dap ui on event exit
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
