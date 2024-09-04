if vim.g.neovide then
    vim.o.guifont = "Source Code Pro:h12"
    vim.g.neovide_scale_factor = 1.0
    vim.keymap.set('n', '<C-+>', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
    end, {})
    vim.keymap.set('n', '<C-->', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
    end, {})
    vim.keymap.set('n', '<C-_>', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
    end, {})
    vim.g.neovide_floating_blur_amount_x = 1.0
    vim.g.neovide_floating_blur_amount_y = 1.0
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_no_idle = false
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_fullscreen = false
    vim.g.neovide_cursor_animation_length = 0.08
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_antialiasing = false
    vim.g.neovide_cursor_animate_in_insert_mode = true

    vim.fn.setenv('VIMDIR', '/home/dvtuong/dotfiles/nvim')
end
