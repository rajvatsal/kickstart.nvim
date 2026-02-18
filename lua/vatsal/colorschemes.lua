return {
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
