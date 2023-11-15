local hm = require 'harpoon.mark'
local hu = require 'harpoon.ui'

-- NOTE: This can actually be done with marks
-- so can consider doing away with harpoon altogether
-- But then again, there are reasons to use harpoon (see the repo README)

local map = function(keys, func, desc)
  if desc then
    desc = 'Harpoon: ' .. desc
  end
  vim.keymap.set('n', keys, func, { desc = desc })
end
map('<leader>ha', hm.add_file, 'Mark file of current buffer')
map('<leader>hh', hu.toggle_quick_menu, 'Open list of marked files')
