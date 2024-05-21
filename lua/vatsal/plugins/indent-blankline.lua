return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  dependencies = { 'HiPhish/rainbow-delimiters.nvim' },
  event = { 'BufReadPre', 'BufNewFile' },
  main = 'ibl',
  opts = {
    scope = { highlight = { 'MoreMsg' }, char = '▎', show_start = false, show_end = false },
    exclude = {
      buftypes = { 'dashboard', 'alpha', 'help', 'lazy', 'mason' },
    },
  },
}