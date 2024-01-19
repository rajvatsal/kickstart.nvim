return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  opts = function(_, opts)
    opts.options = {
      theme = 'material',
      disabled_filetypes = {
        'NvimTree',
      },
    }
  end,
}
