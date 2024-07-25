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
vim.keymap.set('n', '<C-h>', ':bprev<CR>', { noremap = true, silent = true, desc = 'Open previous buffer' })
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Open next buffer' })
vim.keymap.set(
  'n',
  '<leader>mb',
  ':cd %:p:h<CR>:echo "Move to Current [B]uffer"<CR>',
  { noremap = true, silent = true, desc = "[M]ove to current [B]uffer's path" }
)
vim.keymap.set('x', 'p', [["_dp]]) -- Don't update register when you paste over a word
vim.keymap.set('t', '`', '<cmd>:q<CR>', { noremap = true, silent = true })

-- move to the root of file sytem in js projects typically where package.json exists
local function gotoroot()
  local path = vim.api.nvim_buf_get_name(0)
  local gitPath
  while path and path ~= vim.fn.fnamemodify(path, ':p:h:h') do
    if vim.fn.has 'win32' == 1 then
      gitPath = path .. '\\.git'
    else
      gitPath = path .. '/.git'
    end

    if vim.fn.isdirectory(gitPath) == 1 then
      vim.cmd('cd ' .. path)
      print('Moved to: ' .. path)
      return
    end
    path = vim.fn.fnamemodify(path, ':h')
  end

  print 'No git directory found'
end

vim.keymap.set('n', '<leader>mG', gotoroot, { silent = true, noremap = true, desc = '[Move] to [G]it Root' })
