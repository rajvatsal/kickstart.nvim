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
      null_ls.formatting.prettierd.with {
        disabled_filetypes = { 'javascript', 'typescript', 'typescriptreact', 'jsx', 'tsx' },
      },
      null_ls.formatting.biome,
      -- eslint_d deosn't work in windows
      -- require 'none-ls.code_actions.eslint_d',
      -- require 'none-ls.diagnostics.eslint_d',
      --   root_dir = require('lspconfig').util.root_pattern 'eslint.config.mjs',
      -- },
    }
  end,
}
