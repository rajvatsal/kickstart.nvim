local CLR = {
  primary = '#f5f500',
  string = '#529624',
  comment = '#d69045',
  diagnostic_unused = '#545454',
}

local CLR_SCHEME = 'komau'
local M

--------------------------------------------------------------------------------
-- Helper functions
--------------------------------------------------------------------------------

local function setColors()
  vim.cmd.hi 'Whitespace cterm=NONE guifg=#343434'
  vim.cmd.hi 'CursorLine guibg=transparent'
  vim.cmd.hi 'NormalFloat guibg=NONE' -- for which key
  vim.cmd.hi '@comment.todo gui=bold,inverse,underdouble'
  vim.cmd.hi(string.format('Keyword guifg=%s', CLR.primary))
  vim.cmd.hi(string.format('Cursor cterm=NONE guifg=black guibg=%s', CLR.primary))
  vim.cmd.hi(string.format('CursorLineNr guifg=%s guibg=NONE', CLR.primary))
  vim.cmd.hi(string.format('String cterm=NONE guifg=%s gui=NONE', CLR.string))
  vim.cmd.hi(string.format('@comment guifg=%s gui=NONE', CLR.comment))
end

local function getConfig(colorscheme_name)
  return function()
    vim.cmd.colorscheme(colorscheme_name)
    setColors()
  end
end

--------------------------------------------------------------------------------
-- Add colorschemes
--------------------------------------------------------------------------------

M = {
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

--------------------------------------------------------------------------------
-- Set colorscheme
--------------------------------------------------------------------------------

for i, v in ipairs(M) do
  local name = type(v) == 'string' and v or (v.name or v[1])
  local is_active_colorscheme = string.find(name:gsub('-', ''), CLR_SCHEME:gsub('-', ''))

  if not (is_active_colorscheme == nil) then
    local opts

    if type(v) == 'string' then
      opts = {
        v,
        lazy = false,
        priority = 1000,
        config = getConfig(CLR_SCHEME),
      }
    else
      opts = v
      opts.priority = 1000
      opts.lazy = false

      opts.config = opts.config or getConfig(v.name or CLR_SCHEME)
    end

    M[i] = opts
  end
end

setColors() -- Useful when I experiment with colors

return M
