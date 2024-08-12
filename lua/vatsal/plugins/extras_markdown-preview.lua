return {
  'iamcco/markdown-preview.nvim',
  keys = {
    { '<leader>tm', '<cmd>MarkdownPreviewToggle<CR>', desc = 'toggle markdown preview' },
  },
  build = function()
    require('lazy').load { plugins = { 'markdown-preview.nvim' } }
    vim.fn['mkdp#util#install']()
  end,
}
