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
        -- guibg = '#000000',
      },
      FloatBorder = {
        -- guibg = '#000000',
        guifg = '#494949',
      },
    },
    autochdir = true,
    shade_terminals = true,

    shell = 'tmux',
  },
}
