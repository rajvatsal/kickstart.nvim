return {
  'stevearc/overseer.nvim',
  cmd = 'OverseerRun',
  keys = {
    { '<leader>po', '<cmd>OverseerRun<CR>', desc = '[P]ackage using [O]verseer' },
  },
  opts = {
    templates = { 'builtin', 'cpp.SingleFile_debug', 'cpp.SingleFile_release' },
    strategy = 'toggleterm',
  },
}
