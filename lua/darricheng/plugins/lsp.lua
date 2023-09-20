return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        config = true,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  },
  { 'simrat39/rust-tools.nvim' },
  -- Useful status updates for LSP
  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {},
  },
  -- Additional lua configuration, makes nvim stuff amazing!
  { 'folke/neodev.nvim' },
}
