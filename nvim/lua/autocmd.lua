vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(_)
        vim.g.root_dir = vim.fn.getcwd()
        if vim.g.root_dir ~= vim.fn.expand('%:p:h') then
            vim.g.alter_dir = vim.fn.expand('%:p:h')
        end
    end
})
vim.api.nvim_create_autocmd('BufEnter', {
    pattern =  "*.py",
    callback = function(_)
        vim.cmd "compiler pyunit"
    end
})
-- remove trailing space (end of line) and newline (end of file)
-- this break undo (make it too annoying to use)
-- vim.api.nvim_create_autocmd('BufWritePre', {
--     pattern = '*',
--     callback = function()
--         local view = vim.fn.winsaveview()
--         vim.cmd "%s/ *$// | %s/\\n*\\%$//"
--         vim.fn.winrestview(view)
--     end
-- })
vim.api.nvim_create_augroup('NetrwGroup', {clear = true})
-- vim.api.nvim_create_autocmd('VimEnter', {
--     pattern = "*",
--     callback = function()
--         if vim.fn.argc() == 0 then
--             vim.cmd "Explore"
--         end
--     end,
--     group = 'NetrwGroup'
-- })
function netrw_split_open(file)
    local last_window = vim.fn.winnr('$') == vim.fn.winnr()
    if vim.fn.isdirectory(file) == 1  or not last_window then
        vim.call('netrw#LocalBrowseCheck', vim.call('netrw#Call', 'NetrwBrowseChgDir', 1, file))
    else
        vim.cmd "vsplit | vertical resize +35"
        vim.call('netrw#LocalBrowseCheck', vim.call('netrw#Call', 'NetrwBrowseChgDir', 1, file))
    end
end
vim.api.nvim_create_autocmd('FileType', {
    pattern = "netrw",
    callback = function()
        local map = vim.keymap.set
        -- vim.cmd 'nnoremap <buffer> cd  :execute "cd ".b:netrw_curdir<cr>:pwd<cr>'
        map("n", "<C-n>", function()
            local file = vim.fn.input({
                prompt = "File: ",
                completion = "file",
                cancelreturn = nil,
            })
            if file ~= "" then netrw_split_open(file) end
        end, {silent = true, buffer = true})
        map("n", "<CR>", function()
            local file = vim.call('netrw#Call', 'NetrwGetWord')
            netrw_split_open(file)
        end, {silent = true, buffer = true, nowait = true})
    end,
    group = 'NetrwGroup'
})
local aug = vim.api.nvim_create_augroup("buf_large", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
    callback = function()
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
        if ok and stats and (stats.size > 1000000) then
            vim.b.large_buf = true
            vim.cmd("syntax clear")
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.spell = false
        else
            vim.b.large_buf = false
        end
    end,
    group = aug,
    pattern = "*",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        if vim.b.large_buf then
            vim.cmd "syntax clear"
        end
    end,
    group = aug,
    pattern = "*",
})
