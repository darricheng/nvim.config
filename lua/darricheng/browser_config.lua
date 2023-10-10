-- This file contains all the configurations for FireNvim only

vim.g.firenvim_config = {
  localSettings = {
    ['.*'] = {
      -- Never take over any text areas automatically
      -- Instead, map <C-z> to activate FireNvim in the extension settings
      takeover = 'never',
    },
  },
}
