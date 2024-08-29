vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    pattern = "*.c3",
    callback = function()
        vim.cmd "set ft=c3"
    end,
    group = "filetypedetect"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    pattern = {"*.vs", "*.fs"},
    callback = function()
        vim.cmd "set ft=glsl"
    end,
    group = "filetypedetect"
})
