local biome = { filetypes = { 'javascript', 'json', 'grpahql' } }
local prettierd = { filetypes = { 'javascriptreact', 'typescriptreact', 'jsx', 'scss', 'sass', 'css', 'tsx' } }
local clang = { filetypes = { 'c' } }

return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  config = function(_, opts)
    local nls = require 'null-ls.builtins'

    opts.sources = {
      nls.diagnostics.stylelint,
      nls.formatting.stylua,
      nls.formatting.biome.with(biome),
      nls.formatting.prettierd.with(prettierd),
      nls.formatting.clang_format.with(clang),
    }

    if vim.fn.has 'win32' == 1 then
      table.insert(opts.sources, nls.formatting.prettierd)
      table.insert(opts.source, nls.diagonstics.eslint_d)
    end

    require('null-ls').setup(opts)
  end,
}
