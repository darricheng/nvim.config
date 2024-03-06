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
  disable_frontmatter = true,
}
