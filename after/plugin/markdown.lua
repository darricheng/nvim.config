-- The leader key prefix for the table mode plugin is changed in the main remap.lua file.
-- This should be due to how the Lazy plugin manager works with global vim variables, as it seems similar to why the leader key is set before plugins are required.

-- see `:h obsidian` for more config options
require('obsidian').setup {
  workspaces = {
    { name = 'second brain', path = '~/Obsidian/darric_second_brain' },
  },
  daily_notes = {
    folder = 'Areas/Journaling/Daily Notes',
  },
  finder = 'telescope.nvim',
  use_advanced_uri = true,
}
