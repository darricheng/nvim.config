local formatter = require 'formatter'

-- Utilities for creating configurations
local util = require 'formatter.util'

formatter.setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = {
      require('formatter.filetypes.lua').stylua,
    },
    js = {
      require('formatter.filetypes.javascript').prettier,
    },
    jsx = {
      require('formatter.filetypes.javascriptreact').prettier,
    },
    ts = {
      require('formatter.filetypes.typescript').prettier,
    },
    tsx = {
      require('formatter.filetypes.typescriptreact').prettier,
    },
    svelte = {
      require('formatter.filetypes.svelte').prettier,
    },
    html = {
      require('formatter.filetypes.html').prettier,
    },
    css = {
      require('formatter.filetypes.css').prettier,
    },
    json = {
      require('formatter.filetypes.json').prettier,
    },
    rust = {
      require('formatter.filetypes.rust').rustfmt,
    },
    markdown = {
      require('formatter.filetypes.markdown').prettier,
    },
  },
}

-- Format on save
local format_on_save_group = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = format_on_save_group,
  pattern = '*',
  -- command = 'FormatWrite', -- Use Format as FormatWrite can't save when there's errors
})

-- Keymaps
vim.keymap.set('n', '<leader>f', '<cmd>:Format<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>F', '<cmd>:FormatWrite<cr>', { silent = true, noremap = true })
