-- Set the default colorscheme for my editor
vim.cmd.colorscheme 'catppuccin-frappe'

-- no-neck-pain configs
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

-- undotree configs
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
