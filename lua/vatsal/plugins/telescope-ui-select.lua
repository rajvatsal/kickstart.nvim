return {
  'nvim-telescope/telescope-ui-select.nvim',
  keys = { { '<leader>ca', vim.lsp.buf.code_action, desc = '[C]ode [A]ction' } },
  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {
          }
        }
      }
    })
    require('telescope').load_extension('ui-select')
  end,
}
