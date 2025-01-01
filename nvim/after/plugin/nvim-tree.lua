if vim.fn.is_module_available('nvim-tree') then
    vim.keymap.set('n', '<leader>nd', '<CMD>NvimTreeToggle .<CR>', {})
    vim.keymap.set('n', '<leader>nf', '<Cmd>NvimTreeFindFileToggle .<cr>', {})
    vim.cmd("hi! link NvimTreeWinSeparator WinSeperator");
    require("nvim-tree").setup {
        view = {
            signcolumn = "no"
        },
        renderer = {
            icons = {
                show = {
                    file = false,
                    folder = false,
                    git = false,
                    modified = false,
                }
            },
        }
    }
end
