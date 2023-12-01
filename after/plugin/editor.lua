-- Set the default colorscheme for my editor
vim.cmd.colorscheme 'catppuccin-frappe'

require('no-neck-pain').setup {
  width = 110,
  mappings = {
    -- enables key mappings for no-neck-pain
    enabled = true,
    -- toggle the plugin
    toggle = '<leader>np',
    -- increase the width (+5) of the main window.
    widthUp = '<leader>n+',
    -- decrease the width (-5) of the main window.
    widthDown = '<leader>n-',
    -- toggle the scratchpad feature.
    scratchPad = '<leader>ns',
  },
}
-- NoNeckPain can be a bit buggy when more than one window is open,
-- so this keymap resets the state of the windows by toggling the plugin twice
vim.keymap.set('n', '<leader>nr', ':NoNeckPain<cr>:NoNeckPain<cr>', { desc = '[N]oNeckPain: Reset (double toggle)' })

-- blankline indentation configs
require('ibl').setup {
  -- Setup config for indent_blankline goes here
  -- See :h ibl.setup for more info
  scope = {
    show_start = false,
    show_end = false,
  },
}

-- open undotree on the right and diff below
vim.g.undotree_WindowLayout = 2
-- width of the undotree window
vim.g.undotree_SplitWidth = 40
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndoTree' })

vim.keymap.set('n', '<leader>z', ':ZenMode<cr>', { desc = '[Z]enMode' })
require('zen-mode').setup {
  plugins = {
    tmux = {
      enabled = true,
    },
  },
}

require('notify').setup {
  max_width = 60,
  max_height = 16,
}
-- open the message history in telescope
vim.keymap.set('n', '<leader>ms', function()
  require('telescope').extensions.notify.notify()
end, { desc = '[M]essage [S]earch' })

require('noice').setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  views = {
    cmdline_popup = {
      position = {
        row = 20,
        col = '50%',
      },
    },
    cmdline_popupmenu = {
      position = {
        row = 23,
        col = '50%',
      },
    },
  },
}
