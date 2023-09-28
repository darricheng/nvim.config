-- Plugins that are related to browser
-- They have nothing to do with the terminal editing experience

return {
  {
    'glacambre/firenvim',

    -- Only load firenvim when neovim is used in the browser
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn['firenvim#install'](0)
    end,
  },
}
