return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  opts = function(_, opts)
    require('material')
    opts.options = {
      theme = 'material',
      disabled_filetypes = {
        'NvimTree',
      },
    }
  end,
}
