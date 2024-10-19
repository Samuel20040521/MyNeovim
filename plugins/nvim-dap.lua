return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local ui = require("dapui")

    -- 在debugging 的時候自動打開dapui
    ui.setup()
    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
    -------



    -- setting up the keymap
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
    keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start of continue the debugger" })
    -- keymap.set('n', '<F5>', function() require('dap').continue() end)
    -- keymap.set('n', '<F10>', function() require('dap').step_over() end)
    -- keymap.set('n', '<F11>', function() require('dap').step_into() end)
    -- keymap.set('n', '<F12>', function() require('dap').step_out() end)
    -- keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    -- keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
    -- keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    -- keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    -- keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    -- keymap.set({'n', 'v'}, '<Leader>dh', function()
    --   require('dap.ui.widgets').hover()
    -- end)
    -- keymap.set({'n', 'v'}, '<Leader>dp', function()
    --   require('dap.ui.widgets').preview()
    -- end)
    -- keymap.set('n', '<Leader>df', function()
    --   local widgets = require('dap.ui.widgets')
    --   widgets.centered_float(widgets.frames)
    -- end)
    -- keymap.set('n', '<Leader>ds', function()
    --   local widgets = require('dap.ui.widgets')
    --   widgets.centered_float(widgets.scopes)
    -- end)

    -- where to find debugger
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = '/home/Polarbear/.local/share/nvim/mason/bin/codelldb',
        args = { "--port", "${port}" },

        -- On windows you may have to uncomment this:
        -- detached = false,
      }
    }
    -- how to debug in cpp
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    -- let c and rust use the same debugger
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
    -- require("nvim-dap-virtual-text").setup()
  end,
}
