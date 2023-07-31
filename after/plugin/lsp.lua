local lsp = require 'lsp-zero'
local lsp_config = require 'lspconfig'

lsp.preset {
  float_border = 'rounded',
  call_servers = 'local',
  configure_diagnostics = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = {
    preserve_mappings = false,
    omit = {},
  },
  manage_nvim_cmp = {
    set_sources = 'lsp',
    set_basic_mappings = true,
    set_extra_mappings = false,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
  },
}

lsp.ensure_installed {
  'tsserver',
  'rust_analyzer',
  'lua_ls',
  'gopls',
  'svelte',
  'clangd',
}

lsp_config.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false,
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps { buffer = bufnr }

  local map = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  map('n', '<leader>Sd', require('telescope.builtin').lsp_document_symbols, '[S]ymbols: [D]ocument')
  map('n', '<leader>Sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]ymbols: [W]orkspace')

  -- Lesser used LSP functionality
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end)

local cmp = require 'cmp'

-- Load FriendlySnippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup {
  sources = {
    { name = 'copilot' },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
}

lsp.skip_server_setup { 'rust_analyzer' }

lsp.setup()

local rust_tools = require 'rust-tools'

rust_tools.setup {
  server = {
    on_attach = function(_, bufnr)
      local map = function(mode, keys, func, desc)
        if desc then
          desc = 'Rust Tools: ' .. desc
        end
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
      end
      map('n', '<leader>rh', rust_tools.hover_actions.hover_actions, '[H]over Actions')
    end,
  },
}
