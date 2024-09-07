local configs = require 'vatsal.misc.alpha-settings'

return {
  'goolord/alpha-nvim',
  cond = function()
    if vim.fn.argv(0) == '' then
      return true
    else
      return false
    end
  end,
  event = 'VimEnter',
  cmd = 'Alpha',
  config = configs['alpha_startify_config'],
}
