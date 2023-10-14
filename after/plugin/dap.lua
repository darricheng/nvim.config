local dap = require 'dap'
local dapui = require 'dapui'

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
  },
  automatic_installation = true,
}

-- TODO: Set this up with mason-nvim-dap
-- From video on setting up Neovim for NodeJS
-- https://www.youtube.com/watch?v=CVCBHHFXWNE
dap.adapters['pwa-node'] = {
  type = 'server',
  host = '::1',
  port = '${port}',
  executable = {
    command = 'js-debug-adapter',
    args = {
      '${port}',
    },
  },
}

-- NOTE: Temporarily do away with plugin as I try to understand how this all works
-- require('dap-vscode-js').setup {
--   debugger_cmd = { 'js-debug-adapter' },
--   adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
-- }

for _, language in ipairs { 'typescript', 'javascript' } do
  require('dap').configurations[language] = {
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
      name = 'Attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
  }
end

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
