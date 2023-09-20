require 'plugins'
require 'options'
require 'keymap'
require 'autocmd'

vim.cmd 'colorscheme gruvbox'
vim.cmd 'cabbrev mkae make'

local extra_func = require 'extra-function'
vim.api.nvim_create_user_command('Run', extra_func.run_cmd, {bang = true, bar = true, nargs = '?', complete = 'file'})

vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd(string.format("b %s", vim.api.nvim_create_buf(true, true)))
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd(string.format("b %s", vim.api.nvim_create_buf(true, true)))
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Dtrailing', extra_func.delete_trailing, {bang = true, bar = true})

vim.api.nvim_create_user_command('Qfix', function()
    vim.cmd "vsplit | vertical resize 55 | copen | set nowrap | wincmd k | close"
end, {bang = true, bar = true})

if vim.g.neovide then
    require 'gui-options'
end
