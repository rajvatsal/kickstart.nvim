return {
  'nvim-telescope/telescope-ui-select.nvim',
  keys = { { '<leader>ca', desc = '[C]ode [A]ction' } },
  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {
          }
        }
      }
    })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
    require('telescope').load_extension('ui-select')
  end,
}
