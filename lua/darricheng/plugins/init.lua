return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<leader>gd', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[G]it [D]iff' })
      end,
    },
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  -- Seems to be a dependency for many plugins
  'nvim-lua/plenary.nvim',

  -- Add indentation guides on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  -- Treesitter
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/playground',

  -- autopairs
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },

  -- pick out errors easily
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },

  -- For easier access of those few frequently accessed files
  'ThePrimeagen/harpoon',
  -- Plain text table creating and formatting, mainly for markdown files
  'dhruvasagar/vim-table-mode',
  -- Formatting and (maybe) linting
  'mhartington/formatter.nvim',
  -- more expressive undos
  'mbbill/undotree',

  {
    -- Center the editor so that I don't have to constantly be looking to the left of my screen
    'shortcuts/no-neck-pain.nvim',
    version = '*',
  },

  -- Highlight TODO comments and stuff
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  -- deal with surrounds, such as brackets, quotes, etc
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      -- empty config to use defaults
      require('nvim-surround').setup {}
    end,
  },

  -- neovim terminal management
  { 'akinsho/toggleterm.nvim', version = '*' },

  -- preview markdown directly in neovim
  -- install `glow` with `brew install glow` to use this
  { 'ellisonleao/glow.nvim', config = true, cmd = 'Glow' },
}
