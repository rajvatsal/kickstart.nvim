local clr_green = '#6eb93b'
local clr_red = '#d73a49'
local clr_darkgrey = '#a2a2a3'
local clr_darkyellow = '#f2bb22'
local clr_purple = '#f542a7'

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  enabled = true,
  opts = {
    options = {
      disabled_filetypes = { 'NvimTree' },
      -- section_separators = '',
      section_separators = { left = '', right = '|' },
      component_separators = { left = '󰧞', right = '󰧞' },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function()
            return ''
          end,
        },
      },
      lualine_b = {
        {
          'filename',
          fmt = function(f_name)
            local isCreated = f_name:find 'No Name'
            if isCreated == nil then
              return f_name
            else
              return '*new*'
            end
          end,
          color = function(data)
            return { fg = 'white', gui = 'bold' }
          end,
        },
        { 'branch' },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        {
          'diff',
          colored = true, -- Displays a colored diff status if set to true
          diff_color = {
            removed = 'red',
            add = 'green',
            modified = 'orange',
          },
          symbols = { added = '', modified = '', removed = '-' },
        },
      },
      lualine_z = {
        { 'progress', separator = '' },
        { 'location' },
      },
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
    vim.opt.cmdheight = 1
    vim.cmd.hi 'StatusLine guibg=NONE'
    vim.cmd.hi(string.format('lualine_a_insert guifg=%s guibg=NONE', clr_green))
    vim.cmd.hi(string.format('lualine_a_normal guifg=%s guibg=NONE', clr_red))
    vim.cmd.hi(string.format('lualine_a_visual guifg=%s guibg=NONE', clr_purple))
    vim.cmd.hi('lualine_b_normal guifg=' .. clr_darkgrey)
    vim.cmd.hi('lualine_b_visual guifg=' .. clr_purple)
    vim.cmd.hi('lualine_b_command guifg=' .. clr_darkgrey)
    vim.cmd.hi 'lualine_c_normal guibg=NONE'
    vim.cmd.hi 'lualine_c_insert guibg=NONE'
    vim.cmd.hi 'lualine_c_visual guibg=NONE'
    vim.cmd.hi('lualine_y_diff_added_normal  guifg=' .. clr_green)
    vim.cmd.hi('lualine_y_diff_removed  guifg=' .. clr_red)
    vim.cmd.hi('lualine_y_diff_modified  guifg=' .. clr_darkyellow)
  end,
}
