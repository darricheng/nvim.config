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
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',

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

  {
    'windwp/nvim-ts-autotag',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'html', 'markdown' },
  },
}
