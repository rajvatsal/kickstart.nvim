return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  ft = { 'lua', 'javascript', 'typescript', 'c', 'python', 'rust', 'go', 'zig', 'html', 'css', 'markdown', 'jsx' },
  opts = function(_, opts)
    local null_ls = require 'null-ls.builtins'
    opts.sources = {
      null_ls.formatting.stylua,
      null_ls.formatting.prettier.with {
        disabled_filetypes = { 'javascript', 'typescript', 'typescriptreact' },
      },
      null_ls.formatting.biome,
      -- require 'none-ls.code_actions.eslint_d',
      -- require('none-ls.diagnostics.eslint_d').with {
      --   root_dir = require('lspconfig').util.root_pattern '.eslintrc.json',
      -- },
      -- require('none-ls.formatting.eslint_d').with {
      --   filetypes = { 'javascript', 'typescript', 'typescriptreact' },
      --   root_dir = require('lspconfig').util.root_pattern('.eslintrc.json', '.git'),
      -- },
    }
  end,
}
