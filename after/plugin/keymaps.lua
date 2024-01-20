local rmv_lines =
'<cmd>lua vim.opt.number=false<CR><cmd>lua vim.opt.relativenumber=false<CR><cmd>set nocursorline<CR><cmd>lua require(\'lualine\').hide({})<CR>'
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true }) -- Set keymap to exit terminal using 'exit'
vim.keymap.set('n', '<C-h>', ':bprev<CR>', { noremap = true, silent = true, desc = 'Open previous buffer' })
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Open next buffer' })
vim.keymap.set('n', '<leader>m', ':cd %:p:h<CR>', { noremap = true, silent = true, desc = 'Move to current buffer' })
vim.keymap.set('x', 'p', [["_dp]]) -- Don't update register when you paste over a word
vim.keymap.set('n', '`', '<cmd>ToggleTerm .| resize 10<CR>' .. rmv_lines, { noremap = true, silent = true })
vim.keymap.set('t', '`', '<cmd>:q<CR>', { noremap = true, silent = true })
