_G.Lualine_Clrs = {
  green = '#66ff00', -- '#6eb93b',
  red = '#EB212E', -- '#d73a49',
  darkgrey = '#a2a2a3',
  darkgrey_700 = '#545454 ',
  darkyellow = '#f2bb22',
  purple = '#ff007f', -- '#f542a7',
  white = '#f7f7f7',
}

local function getFileName(f_name)
  local isNotCreated = f_name:find 'No Name'
  if isNotCreated == nil then
    return f_name
  else
    return '*new*'
  end
end

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
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      globalstatus = true,
      always_show_tabline = false,
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
          fmt = getFileName,
          color = { fg = Lualine_Clrs.white, gui = 'bold' },
        },
        { 'hostname' },
        { 'branch' },
      },
      lualine_c = {},
      lualine_x = { { 'diagnostics', count = false, color = { bg = 'NONE' } } },
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
        { 'progress', color = { bg = 'NONE', gui = 'bold' }, separator = '' },
        { 'location', color = { bg = 'NONE', gui = 'bold' } },
      },
    },
    tabline = {
      lualine_a = {
        {
          'tabs',
          mode = 2,
          max_length = vim.o.columns,
          tabs_color = {
            active = 'TabLineSel',
            inactive = 'lualine_a_normal',
          },
          fmt = getFileName,
        },
      },
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
    vim.opt.cmdheight = 1
    vim.cmd.hi 'StatusLine guibg=NONE'
    vim.cmd.hi(string.format('lualine_a_insert guifg=%s guibg=NONE', Lualine_Clrs.green))
    vim.cmd.hi(string.format('lualine_a_normal guifg=%s guibg=NONE', Lualine_Clrs.red))
    vim.cmd.hi(string.format('lualine_a_visual guifg=%s guibg=NONE', Lualine_Clrs.purple))
    vim.cmd.hi(string.format('lualine_a_command guifg=%s guibg=NONE', Lualine_Clrs.white))

    vim.cmd.hi(string.format('lualine_b_normal guifg=%s', Lualine_Clrs.darkgrey))
    vim.cmd.hi(string.format('lualine_b_visual guifg=%s', Lualine_Clrs.purple))
    vim.cmd.hi(string.format('lualine_b_filename_command guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_b_command guifg=%s', Lualine_Clrs.darkgrey_700))

    vim.cmd.hi 'lualine_c_normal guibg=NONE'
    vim.cmd.hi 'lualine_c_insert guibg=NONE'
    vim.cmd.hi 'lualine_c_visual guibg=NONE'
    vim.cmd.hi 'lualine_c_command guibg=NONE'

    vim.cmd.hi(string.format('lualine_x_diagnostics_error_command guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_hint_command guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_info_command guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_warn_command guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_error_visual guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_hint_visual guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_info_visual guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_warn_visual guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_error_insert guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_hint_insert guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_info_insert guifg=%s', Lualine_Clrs.darkgrey_700))
    vim.cmd.hi(string.format('lualine_x_diagnostics_warn_insert guifg=%s', Lualine_Clrs.darkgrey_700))

    vim.cmd.hi(string.format('lualine_y_diff_added_normal guibg=NONE guifg=%s', Lualine_Clrs.green))
    vim.cmd.hi(string.format('lualine_y_diff_removed guifg=%s', Lualine_Clrs.red))
    vim.cmd.hi(string.format('lualine_y_diff_modified guifg=%s', Lualine_Clrs.darkyellow))

    vim.cmd.hi(string.format('lualine_z_progress_normal guifg=%s', Lualine_Clrs.white))
    vim.cmd.hi(string.format('lualine_z_location_normal guifg=%s', Lualine_Clrs.white))
    vim.cmd.hi(string.format('lualine_z_progress_insert guifg=%s', Lualine_Clrs.green))
    vim.cmd.hi(string.format('lualine_z_location_insert guifg=%s', Lualine_Clrs.green))
    vim.cmd.hi(string.format('lualine_z_progress_visual guifg=%s', Lualine_Clrs.purple))
    vim.cmd.hi(string.format('lualine_z_location_visual guifg=%s', Lualine_Clrs.purple))
    vim.cmd.hi 'lualine_z_progress_command guibg=white guifg=black'
    vim.cmd.hi 'lualine_z_location_command guibg=white guifg=black'
  end,
}
