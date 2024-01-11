local rmv_lns = '<cmd>lua vim.opt.number=false<CR><cmd>lua vim.opt.relativenumber=false<CR>'
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true }) -- Set keymap to exit terminal using 'exit'
vim.keymap.set('n', '<leader>p', ':bprev<CR>', { noremap = true, silent = true, desc = 'Open previous buffer' })
vim.keymap.set('n', '<leader>n', ':bnext<CR>', { noremap = true, silent = true, desc = 'Open next buffer' })
vim.keymap.set('n', '<leader>m', ':cd %:p:h<CR>', { noremap = true, silent = true, desc = 'Move to current buffer' })
vim.keymap.set('x', 'p', [["_dp]]) -- Don't update register when you paste over a word
vim.keymap.set('n', '`', '<cmd>botright split +term | resize 10<CR>' .. rmv_lns, { noremap = true, silent = true })
vim.keymap.set('t', '`', '<cmd>:q<CR>', { noremap = true, silent = true })
