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
  config = function(_, opts)
    -- You can set custom hilight like this
    -- vim.api.nvim_set_hl(0, 'indent-line', { bg = 'none', fg = '#891919' })
    opts.scope.highlight = { 'RainbowDelimiterRed' }

    require('ibl').setup(opts)
  end,
}
