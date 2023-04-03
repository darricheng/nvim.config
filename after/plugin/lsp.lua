local lsp = require('lsp-zero')
local lsp_config = require('lspconfig')

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    'lua_ls',
    'gopls',
    'svelte',
})

lsp_config.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' }
            },
            workspace = {
                checkThirdParty = false,
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
        },
    }
})

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    -- Format on save
    lsp.buffer_autoformat()

    local map = function(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    map('n', '<leader>lr', vim.lsp.buf.rename, '[R]ename')
    map('n', '<leader>lc', vim.lsp.buf.code_action, '[C]ode Action')

    map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('n', '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
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

lsp.skip_server_setup({ 'rust_analyzer' })

lsp.setup()


local rust_tools = require('rust-tools')

rust_tools.setup({
    server = {
        on_attach = function(_, bufnr)
            local map = function(mode, keys, func, desc)
                if desc then
                    desc = 'Rust Tools: ' .. desc
                end
                vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
            end
            map('n', '<leader>rh', rust_tools.hover_actions.hover_actions, '[H]over Actions')
        end
    }
})
