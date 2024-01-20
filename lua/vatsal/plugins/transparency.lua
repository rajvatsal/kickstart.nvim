return {
	'xiyaowong/transparent.nvim',
	cmd = {
		'TransparentEnable',
		'TransparentToggle',
	},
	init = function() vim.cmd('TransparentEnable') end,
}
