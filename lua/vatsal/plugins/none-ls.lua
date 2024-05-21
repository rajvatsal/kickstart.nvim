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
      null_ls.formatting.prettier,
      require 'none-ls.code_actions.eslint_d',
      require 'none-ls.diagnostics.eslint_d',
    }
  end,
}
