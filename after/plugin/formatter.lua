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
      -- require('formatter.filetypes.svelte').prettier,
      function()
        return {
          exe = 'prettierd',
          args = { util.escape_path(util.get_current_buffer_file_path()) },
          stdin = true,
        }
      end,
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
    go = {
      require('formatter.filetypes.go').goimports,
    },
    markdown = {
      require('formatter.filetypes.markdown').prettierd,
    },
    toml = {
      require('formatter.filetypes.toml').taplo,
    },
    python = {
      require('formatter.filetypes.python').black,
    },
    php = {
      require('formatter.filetypes.php').php_cs_fixer,
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
vim.keymap.set('n', '<leader>ff', '<cmd>:Format<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>fw', '<cmd>:FormatWrite<cr>', { silent = true, noremap = true })

-- Format on save using LSP for languages that don't have a dedicated formatter
-- NOTE: keymap for manually formatting with lsp defined in lsp.lua
local lsp = require 'lsp-zero'
lsp.format_on_save {
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['prismals'] = { 'prisma' },
  },
}
