return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = '<C-t>',
  cmd = 'TermExec',
  opts = {
    size = 12,
    open_mapping = '<C-t>',
    direction = 'float',
    auto_scroll = true,
    float_opts = {
      border = 'curved',
    },
    highlights = {
      NormalFloat = {
        guibg = '#1e222a',
      },
      FloatBorder = {
        guibg = '#1e222a', --'#191d24',
        guifg = '#191d24',
      },
    },
    autochdir = true,
    shade_terminals = false,
    shell = 'tmux',
  },
}
