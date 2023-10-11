require('mason-tool-installer').setup {
  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  -- NOTE: LSPs are handled separately in lsp.lua
  ensure_installed = {
    -- go
    'delve',
    -- javascript / typescript
    'prettierd',
    'js-debug-adapter',
    -- lua
    'stylua',
    'luacheck',
    -- bash
    'shellcheck', -- linter
    'shfmt', -- formatter
    -- spelling linter
    'misspell',
    -- python
    'black',
  },
  auto_update = true,
}
