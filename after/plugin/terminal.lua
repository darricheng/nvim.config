-- Map Esc to exit terminal mode into normal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
-- NOTE: Leaving the below as a reminder
-- The delayed space for the leader key is too distracting
-- Any terminal program that requires Esc, I just won't use in Neovim
-- I have tmux, so I can easily open another terminal if needed
-- vim.keymap.set('t', '<leader><Esc>', '<Esc>')

require('toggleterm').setup {
  open_mapping = [[<c-\>]],
  hide_numbers = false,
  insert_mappings = false,
}

-- I plan for <leader>t to be the prefix for terminal shortcuts
-- For example, see https://github.com/akinsho/toggleterm.nvim#custom-terminals
local map = function(keys, func, desc)
  if desc then
    desc = '[T]erminal: ' .. desc
  end
  if keys then
    keys = '<leader>t' .. keys
  end
  vim.keymap.set('n', keys, func, { desc = desc })
end
