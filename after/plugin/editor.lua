-- Set the default colorscheme for my editor
vim.cmd.colorscheme 'catppuccin-frappe'

-- no-neck-pain configs
require('no-neck-pain').setup {
  width = 110,
  mappings = {
    -- enables key mappings for no-neck-pain
    enabled = true,
    -- toggle the plugin
    toggle = '<Leader>np',
    -- increase the width (+5) of the main window.
    widthUp = '<Leader>n+',
    -- decrease the width (-5) of the main window.
    widthDown = '<Leader>n-',
    -- toggle the scratchpad feature.
    scratchPad = '<Leader>ns',
  },
}

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
