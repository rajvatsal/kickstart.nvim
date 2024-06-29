local _ascii_arts = require 'vatsal.misc.ascii-arts'

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
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Set header
    dashboard.section.header.val = _ascii_arts['f_society']

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
    vim.api.nvim_set_hl(0, 'footer.clr', { fg = '#ffff00' })
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
        dashboard.section.footer.val = '⚡Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
