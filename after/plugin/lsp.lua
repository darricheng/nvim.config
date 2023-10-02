local lsp_zero = require 'lsp-zero'

-- setup and install language servers
require('mason').setup {}
require('mason-lspconfig').setup {
  ensure_installed = {
    'tsserver',
    'rust_analyzer',
    'lua_ls',
    'gopls',
    'svelte',
    'clangd',
    'pyright',
  },
  handlers = {
    lsp_zero.default_setup,
    -- use rust tools to setup rust analyzer instead
    rust_analyzer = function()
      local rt = require 'rust-tools'
      rt.setup {
        server = {
          on_attach = function(_, bufnr)
            local map = function(mode, keys, func, desc)
              if desc then
                desc = '[R]ust Tools: ' .. desc
              end
              vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
            end
            map('n', '<leader>rh', rt.hover_actions.hover_actions, '[H]over Actions')
            map('n', '<leader>rc', rt.code_action_group.code_action_group, '[C]ode Action Group')
          end,
        },
      }
    end,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
}

-- lsp functionality keymaps
lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps { buffer = bufnr }

  -- function to reduce boilerplate for setting keymaps
  local map = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  map('n', '<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename')
  map('n', '<leader>lc', vim.lsp.buf.code_action, '[L]SP [C]ode Action')

  -- search symbols
  map('n', '<leader>Sd', require('telescope.builtin').lsp_document_symbols, '[S]ymbols: [D]ocument')
  map('n', '<leader>Sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]ymbols: [W]orkspace')

  -- Lesser used LSP functionality
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end)

-- Load FriendlySnippets
require('luasnip.loaders.from_vscode').lazy_load()

-- autocompletion
local cmp = require 'cmp'

cmp.setup {
  sources = {
    { name = 'copilot' },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-y>'] = cmp.mapping.confirm {
      -- selects the first item if none are selected
      select = true,
    },
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  },
  -- makes the windows bordered so that they clearly float on top of the editor
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- show the source that created the completion item
  formatting = lsp_zero.cmp_format(),
}
