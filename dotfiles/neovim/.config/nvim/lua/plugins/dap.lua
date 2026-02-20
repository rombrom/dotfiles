return {
  'mfussenegger/nvim-dap',

  config = function()
    local dap = require('dap')

    dap.adapters.ruby = function(callback, config)
      callback {
        type = 'server',
        host = '127.0.0.1',
        port = config.port,
        executable = {
          command = 'bundle',
          args = {
            'exec', 'rdbg', '--nonstop', '--open', '--port', config.port, '--command', '--',
            'bundle', 'exec', config.command, config.script
          }
        }
      }
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "Debug File :12345",
        request = "attach",
        localfs = true,
        command = "ruby",
        port = '12345',
        script = "${file}",
      },
      {
        type = "ruby",
        name = "Debug Spec File :12345",
        request = "attach",
        localfs = true,
        command = "rspec",
        port = '12345',
        script = "${file}",
      },
      {
        type = "ruby",
        name = "Debug Spec File :12346",
        request = "attach",
        localfs = true,
        command = "rspec",
        port = '12345',
        script = "${file}",
      },
    }

    -- Signs:
    -- `DapBreakpoint` for breakpoints (default: `B`)
    -- `DapBreakpointCondition` for conditional breakpoints (default: `C`)
    -- `DapLogPoint` for log points (default: `L`)
    -- `DapStopped` to indicate where the debugee is stopped (default: `→`)
    -- `DapBreakpointRejected` to indicate breakpoints rejected by the debug adapter (default: `R`)
    vim.fn.sign_define('DapBreakpoint', { text = "⏺", texthl = "TextBlueLight", numhl = "", linehl = "" })
    vim.fn.sign_define('DapBreakpointCondition', { text = "◈", texthl = "TextMagentaLight", numhl = "", linehl = "" })
    vim.fn.sign_define('DapBreakpointRejected', { text = "■", texthl = "TextRed", numhl = "", linehl = "" })
    vim.fn.sign_define('DapLogPoint', { text = "›", texthl = "TextGreyLight", numhl = "", linehl = "" })
    vim.fn.sign_define('DapStopped', { text = "⏵", texthl = "TextYellowLight", numhl = "", linehl = "" })
  end,

  keys = function()
    local dap = require('dap')
    local dap_ui = require('dap.ui.widgets')
    return {
      { '<Leader>bb', function() dap.toggle_breakpoint() end },
      { '<Leader>bc', function() dap.continue() end },
      { '<Leader>be', function() dap.repl.execute(vim.fn.expand('<cWORD>')) end },
      { '<Leader>bk', function() dap_ui.hover() end,                            { mode = { 'n', 'v' } } },
      { '<Leader>bl', function() dap.list_breakpoints() end },
      { '<Leader>bq', function()
        dap.clear_breakpoints()
        dap.disconnect()
        dap.repl.close()
      end },
      { '<Leader>br', function() dap.repl.toggle() end },
      { '<Down>',     function() dap.step_over() end },
      { '<Left>',     function() dap.step_out() end },
      { '<Right>',    function() dap.step_into() end },
      { '<Up>',       function() dap.restart_frame() end },
    }
  end,
}
