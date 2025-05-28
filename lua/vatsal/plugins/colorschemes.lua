local primary_clr = '#f2e202'
local string_clr = '#529624'
local active_scheme = 'komau'

local function setDefaults()
  vim.cmd.hi 'Whitespace cterm=NONE guifg=#343434'
  vim.cmd.hi 'CursorLine guibg=transparent'
  vim.cmd.hi 'NormalFloat guibg=NONE'
  vim.cmd.hi(string.format('Keyword guifg=%s', primary_clr))
  vim.cmd.hi(string.format('Cursor cterm=NONE guifg=black guibg=%s', primary_clr))
  vim.cmd.hi(string.format('CursorLineNr guifg=%s guibg=NONE', primary_clr))
  vim.cmd.hi(string.format('String cterm=NONE guifg=%s gui=NONE', string_clr))
end

local function getConfig(colorscheme_name)
  return function()
    vim.cmd.colorscheme(colorscheme_name)
    setDefaults()
  end
end

local colorschemes = {
  'ntk148v/komau.vim',
  {
    'kvrohit/rasmus.nvim',
    config = function()
      vim.g.rasmus_italic_functions = true
      vim.g.rasmus_bold_functions = true
      vim.g.rasmus_variant = 'monochrome'
    end,
  },
  {
    'Alligator/accent.vim',
    config = function()
      vim.g.accent_colour = 'red'
      vim.g.accent_darken = true
    end,
  },
  'kdheepak/monochrome.nvim',
  'ellisonleao/gruvbox.nvim',
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  'lunarvim/colorschemes',
  'rebelot/kanagawa.nvim',
  'catppuccin/nvim',
  'EdenEast/nightfox.nvim',
  'Mofiqul/dracula.nvim',
  'sainnhe/edge',
  'sainnhe/sonokai',
  'sainnhe/everforest',
  'ku1ik/vim-monokai',
  'nyoom-engineering/oxocarbon.nvim',
  'projekt0n/github-nvim-theme',
  {
    'rose-pine/neovim',
    name = 'rosepine',
    config = function()
      vim.opt.cursorline = true
      vim.cmd.colorscheme 'rose-pine-dawn'
    end,
  },
  {
    'marko-cerovac/material.nvim',
    opts = { lualine_style = 'stealth' },
    config = function(_, opts)
      require('material').setup(opts)
      vim.g.material_style = 'deep ocean'
      vim.cmd.colorscheme 'material-deep-ocean'
    end,
  },
  { 'fcancelinha/nordern.nvim', branch = 'master' },
  -- {
  --   'navarasu/onedarknvim',
  --   opts = {
  --     style = 'darker',
  --     lualine = {
  --       transparent = false,
  --     },
  --   },
  --   config = function(_, opts)
  --     require('onedark').setup(opts)
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },
  {
    'AlexvZyl/nordic.nvim',
    config = function()
      require('nordic').load()
    end,
  },
}

for i, v in ipairs(colorschemes) do
  local val = type(v) == 'string' and v or (v.name or v[1]) -- get name of current colorscheme
  local is_active_colorscheme = string.find(val:gsub('-', ''), active_scheme:gsub('-', ''))

  if not (is_active_colorscheme == nil) then
    local clrscheme_opts

    if type(v) == 'string' then
      clrscheme_opts = {
        v,
        lazy = false,
        priority = 1000,
        config = getConfig(active_scheme),
      }
    else
      clrscheme_opts = v
      clrscheme_opts.priority = 1000
      clrscheme_opts.lazy = false

      clrscheme_opts.config = clrscheme_opts.config or getConfig(v.name or active_scheme)
    end

    colorschemes[i] = clrscheme_opts
  end
end

setDefaults()

return colorschemes
