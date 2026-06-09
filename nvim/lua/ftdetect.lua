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

vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    pattern = {"*.jsx", "*.tsx", "*.dart"},
    callback = function()
        vim.cmd "setlocal shiftwidth=2"
    end,
    group = "filetypedetect"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.odin"},
    callback = function()
        vim.opt_local.efm = '%f(%l:%c) %m'
        vim.opt_local.filetype = 'odin'
        vim.opt_local.commentstring = '// %s'
    end,
    group = "filetypedetect"
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
    pattern = {"*.c3"},
    callback = function()
        vim.opt.efm = '(%f:%l:%c)\\ %m'
    end,
    group = "filetypedetect"
})
