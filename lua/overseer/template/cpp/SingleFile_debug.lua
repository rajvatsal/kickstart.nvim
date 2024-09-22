return {
  name = 'C++SingleFile (Debug)',
  builder = function()
    return {
      cmd = 'g++',
      args = {
        '-Wall',
        '-Weffc++',
        '-Wextra',
        '-Wconversion',
        '-Wsign-conversion',
        '-std=c++23',
        '-DDEBUG',
        '-O0',
        '-pedantic-errors',
        vim.fn.expand '%:p',
        '-ggdb2',
        '-o',
        vim.fn.expand '%:p:r',
        '&&',
        vim.fn.expand '%:p:r',
      },
    }
  end,
  condition = {
    filetype = { 'cpp' },
  },
}
