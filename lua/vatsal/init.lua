-- Load settings
require 'vatsal.settings'

-- Load plugins
require('lazy').setup('vatsal.plugins', {
  defaults = { lazy = true },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- 'gzip',
        -- 'matchit',
        -- 'matchparen',
        -- 'netrwPlugin',
        -- 'tarPlugin',
        -- 'tohtml',
        'tutor',
        -- 'zipPlugin',
      },
    },
  },
})
