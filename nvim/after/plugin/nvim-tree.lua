if vim.fn.is_module_available('nvim-tree') then
    vim.keymap.set('n', '<leader>nd', '<CMD>NvimTreeToggle .<CR>', {})
    vim.keymap.set('n', '<leader>nf', '<Cmd>NvimTreeFindFileToggle .<cr>', {})
    require("nvim-tree").setup {
        view = {
            signcolumn = "no"
        },
        renderer = {
            highlight_bookmarks = "name",
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
