local configs = require 'vatsal.misc.alpha-settings'

return {
  'goolord/alpha-nvim',
  enabled = false,
  event = 'VimEnter',
  cmd = 'Alpha',
  config = configs['alpha_startify_config'],
}
