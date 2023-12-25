return {
  {
    -- Center the editor so that I don't have to constantly be looking to the left of my screen
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    event = 'VeryLazy',
  },
  {
    'folke/zen-mode.nvim',
    event = 'VeryLazy',
  },
  -- Add indentation guides on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
    event = 'VeryLazy',
  },
  -- autopairs
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },
  -- auto html tag closing
  {
    'windwp/nvim-ts-autotag',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'html', 'markdown' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  -- more expressive undos
  {
    'mbbill/undotree',
    event = 'VeryLazy',
  },
  -- Highlight TODO comments and stuff
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
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
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
}
