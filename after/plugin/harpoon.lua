local hm = require 'harpoon.mark'
local hu = require 'harpoon.ui'

local map = function(keys, func, desc)
  if desc then
    desc = 'Harpoon: ' .. desc
  end
  vim.keymap.set('n', keys, func, { desc = desc })
end
map('<leader>ha', hm.add_file, 'Mark file of current buffer')
map('<leader>hh', hu.toggle_quick_menu, 'Open list of marked files')
