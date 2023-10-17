local dap = require 'dap'
local dapui = require 'dapui'
local utils = require 'dap.utils'

require('mason-nvim-dap').setup {
  -- Makes a best effort to setup the various debuggers with
  -- reasonable debug configurations
  automatic_setup = true,

  -- You can provide additional configuration to the handlers,
  -- see mason-nvim-dap README for more information
  -- NOTE: I think nil here is important so that I don't work with the defaults from mason-nvim-dap, which would make my debugging process harder
  handlers = nil,

  -- You'll need to check that you have the required things installed
  -- online, please don't ask me how to install them :)
  ensure_installed = {
    -- Update this to ensure that you have the debuggers for the langs you want
    'delve',
    'js',
    'codelldb',
  },
  automatic_installation = true,
}

-- set logging levels to debug why adapters are not working
-- logs are saved in ~.cache/nvim/dap.log
dap.set_log_level 'TRACE'

-- Maybe set this up with mason-nvim-dap handlers?
dap.adapters = {
  ['pwa-node'] = {
    type = 'server',
    host = '::1',
    port = '${port}',
    executable = {
      command = 'js-debug-adapter',
      args = {
        '${port}',
      },
    },
  },
  ['codelldb'] = {
    type = 'server',
    port = '${port}',
    executable = {
      -- command = 'codelldb',
      command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
      args = { '--port', '${port}' },
    },
  },
}

for _, language in ipairs { 'typescript', 'javascript' } do
  -- js-debug-adapter options:
  -- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to process ID',
      processId = utils.pick_process,
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Local NestJS (port 9229)',
      address = 'localhost',
      port = 9229,
      cwd = '${workspaceFolder}',
      restart = true,
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'ZTO - Dockerised NestJS (port 9229)',
      address = 'localhost',
      port = 9229,
      localRoot = '${workspaceFolder}',
      remoteRoot = 'usr/src/app',
      -- resolveSourceMapLocations = { '${workspaceFolder}/dist', '!**/node_modules/**' },
      restart = true,
    },
  }
end

dap.configurations.rust = {
  {
    type = 'codelldb',
    request = 'launch',
    name = 'Launch file',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
dapui.setup {
  -- Set icons to characters that are more likely to work in every terminal.
  --    Feel free to remove or use ones that you like more! :)
  --    Don't feel like these are good choices.
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

local map = function(keys, func, desc)
  if desc then
    desc = 'De[B]ugger: ' .. desc
  end
  if keys then
    keys = '<leader>b' .. keys
  end
  vim.keymap.set('n', keys, func, { desc = desc })
end

-- Basic debugging keymaps, feel free to change to your liking!
map('s', dap.continue, '[S]tart/Continue')
map('i', dap.step_into, 'Step [I]nto')
map('v', dap.step_over, 'Step O[V]er')
map('o', dap.step_out, 'Step [O]ut')
map('b', dap.toggle_breakpoint, 'Toggle [B]reakpoint')
map('B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, 'Set [B]reakpoint')

-- dap-ui
map('u', dapui.toggle, 'Toggle [U]I')
