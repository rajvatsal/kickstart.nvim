return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ '<S-m>', desc = 'Add file to harpoon' },
		{ '<TAB>', desc = 'Toggle harpoon' },
	},
	config = function()
		-- Set telescope as UI for harpoon
		local harpoon = require('harpoon')
		harpoon:setup({})

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }

		keymap("n", "<S-m>", "<cmd>lua require('vatsal.plugins.extras_harpoon').mark_file()<cr>", opts)
		keymap("n", "<TAB>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)
	end,
	mark_file = function()
		(function() require('harpoon'):list():append() end)()
		vim.notify " 󱡅  marked file"
	end,
}
