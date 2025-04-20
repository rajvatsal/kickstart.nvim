local prettierd = { filetypes = { 'javascriptreact', 'typescriptreact', 'jsx', 'scss', 'sass', 'css', 'tsx', 'typescript' } }
local clang = { filetypes = { 'c' } }

return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  config = function()
    local nls = require 'null-ls.builtins'

    require('null-ls').setup {
      sources = {
        nls.diagnostics.stylelint,
        nls.formatting.stylua,
        nls.formatting.prettierd.with(prettierd),
        nls.formatting.clang_format.with(clang),
        require 'none-ls.diagnostics.eslint_d',
      },
    }
  end,
}
