-- See `:help lualine.txt`
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', opt = true
  },
  event = 'VeryLazy',
  opts = {
    options = {
      disabled_filetypes = {
        'NvimTree',
      },
    }
  },
}
