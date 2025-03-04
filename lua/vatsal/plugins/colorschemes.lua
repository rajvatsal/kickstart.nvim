local active_colorscheme_name = 'tokyonight'

local colorschemes = {
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
  local val = type(v) == 'string' and v or (v.name or v[1])
  local isActive = string.find(string.gsub(val, '-', ''), string.gsub(active_colorscheme_name, '-', ''))

  if not (isActive == nil) then
    local active_colorscheme

    if type(v) == 'string' then
      active_colorscheme = {
        v,
        lazy = false,
        priority = 1000,
        config = function()
          local ok = pcall(vim.cmd.colorscheme, active_colorscheme_name)

          if not ok then
            error "Couldn't apply colorscheme"
          end

          vim.cmd.colorscheme(active_colorscheme_name)
        end,
      }
    else
      active_colorscheme = v
      active_colorscheme.priority = 1000
      active_colorscheme.lazy = false

      active_colorscheme.config = active_colorscheme.config or function()
        vim.cmd.colorscheme(v.name or active_colorscheme_name)
      end
    end

    colorschemes[i] = active_colorscheme
  end
end

return colorschemes
