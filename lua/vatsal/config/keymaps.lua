-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[Mine]]
local rmv_lines = '<cmd>lua vim.wo.number=false<CR><cmd>lua vim.wo.relativenumber=false<CR>'
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true }) -- Set keymap to exit terminal using 'exit'
vim.keymap.set('n', '<C-h>', ':bprev<CR>', { noremap = true, silent = true, desc = 'Open previous buffer' })
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Open next buffer' })
vim.keymap.set('n', '<leader>m', ':cd %:p:h<CR>', { noremap = true, silent = true, desc = 'Move to current buffer' })
vim.keymap.set('x', 'p', [["_dp]]) -- Don't update register when you paste over a word
vim.keymap.set('n', '`', '<cmd>ToggleTerm .| resize 10<CR>' .. rmv_lines, { noremap = true, silent = true })
vim.keymap.set('t', '`', '<cmd>:q<CR>', { noremap = true, silent = true })
