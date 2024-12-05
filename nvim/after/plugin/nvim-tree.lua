if vim.fn.is_module_available('nvim-tree') then
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
