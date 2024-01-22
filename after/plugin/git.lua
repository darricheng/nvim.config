vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })

require('telescope').load_extension 'git_worktree'
