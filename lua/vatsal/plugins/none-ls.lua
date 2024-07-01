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
    }
    if vim.fn.has 'win32' == 1 then
      table.insert(opts.sources, null_ls.formatting.prettierd)
    else
      table.insert(
        opts.sources,
        null_ls.formatting.prettierd.with {
          disabled_filetypes = { 'javascript', 'typescript', 'typescriptreact', 'jsx', 'tsx' },
        }
      )
      table.insert(opts.sources, null_ls.formatting.biome)
    end
  end,
}
