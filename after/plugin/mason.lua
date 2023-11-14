require('mason-tool-installer').setup {
  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  -- NOTE: LSPs are handled separately in lsp.lua, DAPs in dap.lua
  -- TODO: Consolidate all the tool installation into this file?
  ensure_installed = {
    -- javascript / typescript
    'prettierd',
    -- lua
    'stylua',
    'luacheck',
    -- go
    'goimports',
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
