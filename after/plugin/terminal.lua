-- Map Esc to exit terminal mode into normal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
-- Leaving the below as a reminder
-- The delayed space for the leader key is too distracting
-- Any terminal program that requires Esc, I just won't use in Neovim
-- I have tmux, so I can easily open another terminal if needed
-- vim.keymap.set('t', '<leader><Esc>', '<Esc>')

local map = function(keys, func, desc)
  if desc then
    desc = '[T]erminal: ' .. desc
  end
  if keys then
    keys = '<leader>' .. keys
  end
  vim.keymap.set('n', keys, func, { desc = desc })
end

-- TODO: Close the floating terminal with the Esc key
-- Thinking of mapping the term_toggle command to Esc when the float is open,
-- then unmap it when the float is closed.
map('t', '<cmd>Lspsaga term_toggle<cr>', 'Open [F]loat')

-- Must call gotoTerminal in an anonymous function.
-- Otherwise it will be called and immediately opens the terminal when I open neovim.
-- Also results in an error.
local gtt = require('harpoon.term').gotoTerminal
map('T1', function()
  gtt(1)
end, 'Go to terminal 1')
map('T2', function()
  gtt(2)
end, 'Go to terminal 2')
map('T3', function()
  gtt(3)
end, 'Go to terminal 3')
