require('copilot').setup {
  -- disable copilot.lua's suggestion and panel modules, as they can interfere with completions properly appearing in copilot-cmp
  suggestion = { enabled = false },
  panel = { enabled = false },
}
require('copilot_cmp').setup()
