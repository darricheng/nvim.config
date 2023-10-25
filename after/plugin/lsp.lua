-- Setup neodev before lsp-config
require('neodev').setup {}

local lsp_zero = require 'lsp-zero'
require('lspsaga').setup {
  finder = {
    keys = {
      vsplit = 'v',
    },
  },
  rename = {
    keys = {
      quit = '<C-c>',
    },
  },
  lightbulb = {
    virtual_text = false,
  },
}

-- setup and install language servers
require('mason').setup {}
require('mason-lspconfig').setup {
  ensure_installed = {
    'clangd',
    'eslint',
    'gopls',
    'jsonls',
    'lua_ls',
    'marksman',
    'prismals',
    'pyright',
    'rust_analyzer',
    'svelte',
    'taplo',
    'tsserver',
    'yamlls',
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
            -- NOTE: maybe can change the keymaps to override lsp_zero defaults
            -- E.g. '<leader>ca' for code action, 'K' for hover, etc.
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
  -- function to reduce boilerplate for setting keymaps
  local map = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  -- More info about symbol
  map('n', 'K', ':Lspsaga hover_doc<cr>', 'Hover info about symbol')
  map('n', 'gpd', ':Lspsaga peek_definition<cr>', '[P]eek [D]efinition')
  map('n', 'gpo', ':Lspsaga peek_type_definition<cr>', '[P]eek Type Definition')

  -- Goto keymaps
  map('n', 'gd', ':Lspsaga goto_definition<cr>', '[G]oto [D]efinition')
  map('n', 'go', ':Lspsaga goto_type_definition<cr>', '[G]oto Type Definition')
  map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', 'gI', ':Lspsaga finder imp<cr>', '[G]oto [I]mplementation')
  map('n', 'gr', ':Lspsaga finder<cr>', '[G]oto [R]eferences')
  map('n', 'gs', vim.lsp.buf.signature_help, '[G]oto [S]ignature')

  -- Useful lsp actions
  map('n', '<leader>rn', ':Lspsaga rename<cr>', '[R]e[N]ame')
  map('n', '<leader>ca', ':Lspsaga code_action<cr>', '[C]ode [A]ction')

  -- File navigation
  map('n', '<leader>o', ':Lspsaga outline<cr>', '[]')

  -- Diagnostics
  map('n', 'gl', vim.diagnostic.open_float, 'Open diagnostic float')
  map('n', '[d', ':Lspsaga diagnostic_jump_prev<cr>', 'Previous diagnostic')
  map('n', ']d', ':Lspsaga diagnostic_jump_next<cr>', 'Next diagnostic')

  -- formatting
  map('n', '<leader>fl', vim.lsp.buf.format, '[F]ormat with [L]SP')

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
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item { behavior = 'select' }
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item { behavior = 'select' }
      else
        cmp.complete()
      end
    end),
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
