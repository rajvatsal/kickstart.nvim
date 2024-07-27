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
      winblend = 10,
    },
  },
}
