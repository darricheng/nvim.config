return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
  },
  -- LSP
  'neovim/nvim-lspconfig',
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'stevearc/aerial.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
  },

  -- Autocompletion
  { 'hrsh7th/nvim-cmp', event = 'VeryLazy' },
  { 'hrsh7th/cmp-buffer', event = 'VeryLazy' },
  { 'hrsh7th/cmp-path', event = 'VeryLazy' },
  { 'saadparwaiz1/cmp_luasnip', event = 'VeryLazy' },
  { 'hrsh7th/cmp-nvim-lsp', event = 'VeryLazy' },
  { 'hrsh7th/cmp-nvim-lua', event = 'VeryLazy' },

  -- Snippets
  {
    'L3MON4D3/LuaSnip',
    event = 'VeryLazy',
  },
  'rafamadriz/friendly-snippets',
  { 'simrat39/rust-tools.nvim', ft = 'rust' },

  -- Useful status updates for LSP
  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  {
    'j-hui/fidget.nvim',
    opts = {},
  },

  -- Additional lua configuration, makes nvim stuff amazing!
  'folke/neodev.nvim',
}
