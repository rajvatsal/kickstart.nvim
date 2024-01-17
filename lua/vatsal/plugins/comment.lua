return {
  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'InsertEnter' },
  config = true
}
