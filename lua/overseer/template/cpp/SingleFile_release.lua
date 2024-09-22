return {
  name = 'C++SingleFile (Release)',
  builder = function()
    return {
      cmd = 'g++',
      args = {
        '-std=c++23',
        '-DNDEBUG',
        '-O2',
        vim.fn.expand '%:p',
        '-o',
        vim.fn.expand '%:p:r',
      },
      components = { { 'on_output_quickfix', open = true }, 'default' },
    }
  end,
  condition = {
    filetype = { 'cpp' },
  },
}
