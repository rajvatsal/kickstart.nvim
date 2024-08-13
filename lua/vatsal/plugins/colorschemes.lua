return {
  --Gruvbox colorscheme
  { 'ellisonleao/gruvbox.nvim', priority = 1000 },

  --tokyonight colorscheme
  { 'folke/tokyonight.nvim', priority = 1000 },

  -- lunar-vim colorschemes
  { 'lunarvim/colorschemes', priority = 1000 },

  -- kanagawa
  { 'rebelot/kanagawa.nvim', priority = 1000 },

  -- latte, frappe, macchiato, mocha
  { 'catppuccin/nvim', priority = 1000 },

  -- Theme inspired by Atom
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      style = 'darker',
      lualine = {
        transparent = false,
      },
    },
    config = function(_, opts)
      require('onedark').setup(opts)
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- Nightfox
  { 'EdenEast/nightfox.nvim', priority = 1000 },

  --Rosepine (Primeagen)
  { 'rose-pine/neovim', priority = 1000, name = 'rose-pine' },

  -- Dracula
  { 'Mofiqul/dracula.nvim', priority = 1000 },

  -- Edge
  { 'sainnhe/edge', priority = 1000 },

  -- Sonokai
  { 'sainnhe/sonokai', priority = 1000 },

  -- Everforest
  { 'sainnhe/everforest', priority = 1000 },

  -- Monokai
  { 'ku1ik/vim-monokai', priority = 1000 },

  -- Material
  {
    'marko-cerovac/material.nvim',
    priority = 1000,
    opts = { lualine_style = 'stealth' },
    config = function(_, opts)
      require('material').setup(opts)
      vim.g.material_style = 'deep ocean'
      vim.cmd.colorscheme 'material-deep-ocean'
    end,
  },

  { 'nyoom-engineering/oxocarbon.nvim', priority = 1000 },
  { 'projekt0n/github-nvim-theme', priority = 1000 },
}
