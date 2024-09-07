local ascii_art = require 'vatsal.misc.ascii-arts'
local alpha_config = {}

alpha_config['alpha_dashboard_config'] = function()
  local ascii = require 'ascii'
  local alpha = require 'alpha'
  local dashboard = require 'alpha.themes.dashboard'

  -- Set header
  dashboard.section.header.val = ascii.art.misc.krakens.krakedking

  -- Set menu
  dashboard.section.buttons.val = {
    dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
    dashboard.button('r', '  Recently used files', ':Telescope oldfiles<CR>'),
    dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
    dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
    dashboard.button('q', '  Quit NVIM', ':qa<CR>'),
  }

  -- Set footer
  -- dashboard.section.footer.val = require('alpha.fortune')()

  -- Colors

  dashboard.section.header.opts.hl = 'String'
  dashboard.section.buttons.opts.hl = 'Debug'
  dashboard.section.footer.opts.hl = 'white'
  dashboard.config.opts.noautocmd = true

  vim.cmd [[autocmd User AlphaReady echo 'ready']]

  alpha.setup(dashboard.opts)

  -- Plugins loaded footer
  vim.api.nvim_create_autocmd('User', {
    once = true,
    pattern = 'LazyVimStarted',
    callback = function()
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = '⚡Neovim loaded ' ..
      stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

alpha_config['alpha_startify_config'] = function()
  local fortune = require 'alpha.fortune'
  local alpha = require 'alpha'
  local startify = require 'alpha.themes.startify'

  startify.section.header.val = ascii_art.afo_bold

  startify.config.layout[1].val = 2
  startify.config.layout[3].val = 2

  startify.section.top_buttons.val = {
    startify.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
    startify.button('r', '  Recently used files', ':Telescope oldfiles<CR>'),
    startify.button('t', '󰈞  Find text', ':Telescope live_grep <CR>'),
  }

  -- disable MRU
  startify.section.mru.val = { { type = 'padding', val = 0 } }
  -- disable MRU cwd
  startify.section.mru_cwd.val = { { type = 'padding', val = 0 } }
  -- disable nvim_web_devicons
  startify.nvim_web_devicons.enabled = false
  -- startify.nvim_web_devicons.highlight = false
  -- startify.nvim_web_devicons.highlight = 'Keyword'

  startify.section.bottom_buttons.val = {
    startify.button('q', '󰅚  Quit NVIM', ':qa<CR>'),
    { type = 'padding', val = 2 },
  }

  vim.api.nvim_set_hl(0, 'FooterStartify', { fg = '#8A94BC' })
  startify.section.footer.val = { { type = 'text', val = fortune(), opts = { hl = 'FooterStartify', margin = 30 } } }

  -- ignore filetypes in MRU
  startify.mru_opts.ignore = function(path, ext)
    return (string.find(path, 'COMMIT_EDITMSG')) or (vim.tbl_contains(default_mru_ignore, ext))
  end
  alpha.setup(startify.config)
end

return alpha_config
