-- Setup neodev before lsp-config
require('neodev').setup {}

local lsp_zero = require 'lsp-zero'
local lsp = vim.lsp
local tele = require 'telescope.builtin'

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
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
}

-- Plugin for outline with lsp
require('aerial').setup {}

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
  map('n', 'K', lsp.buf.hover, 'Hover info about symbol')

  -- Goto keymaps
  map('n', 'gd', tele.lsp_definitions, '[G]oto [D]efinition')
  map('n', 'go', tele.lsp_type_definitions, '[G]oto Type Definition')
  map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', 'gI', tele.lsp_implementations, '[G]oto [I]mplementation')
  map('n', 'gr', tele.lsp_references, '[G]oto [R]eferences')
  map('n', 'gs', vim.lsp.buf.signature_help, '[G]oto [S]ignature')

  -- Useful lsp actions
  map('n', '<leader>rn', lsp.buf.rename, '[R]e[N]ame')
  map('n', '<leader>ca', lsp.buf.code_action, '[C]ode [A]ction')

  -- File navigation
  map('n', '<leader>o', '<cmd>AerialToggle!<cr>', '[O]utline')

  -- Diagnostics
  map('n', 'gl', vim.diagnostic.open_float, 'Open diagnostic float')
  map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
  map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

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

local function select_next()
  if cmp.visible() then
    cmp.select_next_item { behavior = 'select' }
  else
    cmp.complete()
  end
end
local function select_prev()
  if cmp.visible() then
    cmp.select_prev_item { behavior = 'select' }
  else
    cmp.complete()
  end
end

cmp.setup {
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping(select_next),
    ['<C-j>'] = cmp.mapping(select_next),
    ['<C-p>'] = cmp.mapping(select_prev),
    ['<C-k>'] = cmp.mapping(select_prev),
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
