-- Map Esc to exit terminal mode into normal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
-- Leaving the below as a reminder
-- The delayed space for the leader key is too distracting
-- Any terminal program that requires Esc, I just won't use in Neovim
-- I have tmux, so I can easily open another terminal if needed
-- vim.keymap.set('t', '<leader><Esc>', '<Esc>')

local map = function(keys, func, desc)
  if desc then
    desc = 'Terminal: ' .. desc
  end
  if keys then
    keys = '<leader>t' .. keys
  end
  vim.keymap.set('n', keys, func, { desc = desc })
end

-- Must call gotoTerminal in an anonymous function.
-- Otherwise it will be called and immediately opens the terminal when I open neovim.
-- Also results in an error.
local gtt = require('harpoon.term').gotoTerminal
map('t', function()
  gtt(0)
end, 'Go to the main terminal')
map('1', function()
  gtt(1)
end, 'Go to terminal 1')
map('2', function()
  gtt(2)
end, 'Go to terminal 2')
map('3', function()
  gtt(3)
end, 'Go to terminal 3')
