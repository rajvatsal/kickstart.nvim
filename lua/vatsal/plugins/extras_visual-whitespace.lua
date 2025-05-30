return {
  'mcauley-penney/visual-whitespace.nvim',
  config = true,
  event = 'ModeChanged *:[vV\22]', -- optionally, lazy load on entering visual mode
  opts = {
    enabled = true,
    match_types = {
      space = true,
      tab = false,
      nbsp = false,
    },
    list_chars = {
      space = '',
    },
    fileformat_chars = {
      unix = '',
      mac = '',
      dos = '',
    },
  },
}
