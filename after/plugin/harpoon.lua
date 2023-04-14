local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local map = function(keys, func, desc)
    if desc then
        desc = 'Harpoon: ' .. desc
    end
    vim.keymap.set("n", keys, func, { desc = desc })
end
map("<leader>ha", mark.add_file, "Mark file of current buffer")
map("<leader>hh", ui.toggle_quick_menu, "Open list of marked files")
