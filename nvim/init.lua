require 'plugins'
require 'options'
require 'keymap'
require 'autocmd'

vim.cmd 'colorscheme gruvbox'

vim.cmd 'cabbrev mkae make'
local extra_func = require 'extra-function'
vim.api.nvim_create_user_command('Run', extra_func.run_cmd, {bang = true, bar = true, nargs = '?', complete = 'file'})
vim.api.nvim_create_user_command('Scratch', function() vim.cmd(string.format("b %s", vim.api.nvim_create_buf(true, true))) end, {bang = true, bar = true})
vim.api.nvim_create_user_command('Qfix',
function()
    vim.cmd "vsplit | vertical resize 40 | copen | set nowrap | wincmd k | close"
end, {bang = true, bar = true})

if vim.g.neovide then
    vim.o.guifont = "Iosevka Term:h12"
    vim.opt.linespace = 1
    vim.g.neovide_scale_factor = 1
    vim.g.neovide_floating_blur_amount_x = 1.0
    vim.g.neovide_floating_blur_amount_y = 1.0
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_theme = 'auto'
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 1
    vim.g.neovide_no_idle = false
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_fullscreen = false
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_antialiasing = false
    vim.g.neovide_cursor_animate_in_insert_mode = false
end
