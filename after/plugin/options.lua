vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.relativenumber = true
vim.cmd.colorscheme 'rose-pine-main' -- Set custom colorscheme [[ NOTE: Never set it to "onedark" cuz it breaks the editor ]]
if vim.fn.has('win32') or vim.fn.has('win64') or vim.fn.has('win16') then
  vim.opt.shell = 'powershell'
else
  vim.opt.shell = 'bash'
end
