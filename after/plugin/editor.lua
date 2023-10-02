-- Set the default colorscheme for my editor
vim.cmd.colorscheme 'tokyonight'

-- no-neck-pain configs
require('no-neck-pain').setup {
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
