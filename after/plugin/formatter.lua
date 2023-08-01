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
    javascript = {
      require('formatter.filetypes.javascript').prettierd,
    },
    javascriptreact = {
      require('formatter.filetypes.javascriptreact').prettierd,
    },
    typescript = {
      require('formatter.filetypes.typescript').prettierd,
    },
    typescriptreact = {
      require('formatter.filetypes.typescriptreact').prettierd,
    },
    svelte = {
      require('formatter.filetypes.svelte').prettier,
    },
    html = {
      require('formatter.filetypes.html').prettierd,
    },
    css = {
      require('formatter.filetypes.css').prettierd,
    },
    json = {
      require('formatter.filetypes.json').prettierd,
    },
    rust = {
      require('formatter.filetypes.rust').rustfmt,
    },
    markdown = {
      require('formatter.filetypes.markdown').prettierd,
    },
  },
}

-- Format on save
local format_on_save_group = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = format_on_save_group,
  pattern = '*',
  command = 'FormatWrite',
})

-- Keymaps
vim.keymap.set('n', '<leader>f', '<cmd>:Format<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>F', '<cmd>:FormatWrite<cr>', { silent = true, noremap = true })
