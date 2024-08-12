return {
  'stevearc/oil.nvim',
  keys = { { '<leader>to', '<cmd>Oil --float<CR>', desc = 'toggle oil' } },
  opts = {
    float = {
      max_height = 20,
      max_width = 80,
    },
  },
}
