return {
	'stevearc/oil.nvim',
	keys = {
		{ '<leader>o', '<cmd>Oil --float<CR>', desc = '[O]il' },
	},
	opts = {
		float = {
			max_height = 20,
			max_width = 80,
		}
	},
}
