return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  keys = {
    { '<leader>tm', '<cmd>MarkdownPreviewToggle<CR>', desc = 'toggle markdown preview' },
  },
  build = function()
    require('lazy').load { plugins = { 'markdown-preview.nvim' } }
    vim.fn['mkdp#util#install']()
  end,
}
