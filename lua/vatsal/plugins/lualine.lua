-- See `:help lualine.txt`
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  opts = {
    options = {
      theme = 'dracula',
      disabled_filetypes = {
        'NvimTree',
      },
    }
  },
}
