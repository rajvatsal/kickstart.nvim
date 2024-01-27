return {
  'nvimtools/none-ls.nvim',
  ft = { 'lua', 'javascript', 'typescript', 'c', 'python', 'rust', 'go', 'zig', 'html', 'css', 'markdown', 'jsx' },
  opts = function(_, opts)
    local null_ls = require 'null-ls'
    opts.sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier.with {
        disabled_filetypes = { 'javascript', 'typescript', 'json' }, -- Use biome
      },
      null_ls.builtins.formatting.biome,
      -- null_ls.builtins.diagnostics.biome,
    }
  end,
}
