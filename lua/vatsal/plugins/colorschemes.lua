return {
	--Gruvbox colorscheme
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ..., },

	--tokyonight colorscheme
	{ "folke/tokyonight.nvim",    priority = 1000, },

	-- lunar-vim colorschemes
	{ "lunarvim/colorschemes",    priority = 1000, },

	-- kanagawa
	{ "rebelot/kanagawa.nvim",    priority = 1000, },

	-- latte, frappe, macchiato, mocha
	{
		"catppuccin/nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd('colorscheme catppuccin')
		end,
	},

	-- Theme inspired by Atom
	{ 'navarasu/onedark.nvim',  priority = 1000, },

	-- Nightfox
	{ 'EdenEast/nightfox.nvim', priority = 1000 },

	--Rosepine (Primeagen)
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		priority = 1000,
	},

	-- Dracula
	{ 'Mofiqul/dracula.nvim', priority = 1000, }
}
