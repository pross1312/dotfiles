vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(_)
        local buf_name = vim.fn.bufname(0)
        if vim.fn.isdirectory(buf_name) == 1 then
            vim.cmd("cd "..buf_name)
        end
        vim.g.root_dir = vim.fn.getcwd()
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
function netrw_split_open(file)
    local last_window = vim.fn.winnr('$') == vim.fn.winnr()
    if vim.fn.isdirectory(file) == 1  or not last_window then
        vim.call('netrw#LocalBrowseCheck', vim.call('netrw#Call', 'NetrwBrowseChgDir', 1, file))
    else
        vim.cmd "vsplit | vertical resize 90"
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
        end, {buffer = true})
        map("n", "<CR>", function()
            local file = vim.call('netrw#Call', 'NetrwGetCurdir', 1) .. '/' .. vim.call('netrw#Call', 'NetrwGetWord')
            netrw_split_open(file)
        end, {buffer = true, nowait = true})
        map("n", ".", ":<C-U> <C-R>=netrw#Call('NetrwGetCurdir', 1)..'/'..netrw#Call('NetrwGetWord')<CR><Home>", {buffer = true})
        map('n', '<C-p>', '<CMD>Lexplore<CR>', {buffer = true})
    end,
    group = 'NetrwGroup'
})
-- local aug = vim.api.nvim_create_augroup("buf_large", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufReadPre" }, {
--     callback = function()
--         local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
--         if ok and stats and (stats.size > 1000000) then
--             vim.b.large_buf = true
--             vim.cmd("syntax clear")
--             vim.opt_local.foldmethod = "manual"
--             vim.opt_local.spell = false
--         else
--             vim.b.large_buf = false
--         end
--     end,
--     group = aug,
--     pattern = "*",
-- })
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"go"},
    callback = function()
        -- ./main.go:109:40: undefined: group
        vim.opt.errorformat = '%f:%l:%c: %m'
        vim.opt.makeprg = "go build"
    end,
})
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"rust"},
    callback = function()
        vim.opt.errorformat = '%Eerror: %m,%Eerror[E%n]: %m,%Wwarning: %m,%Inote: %m,%C %#--> %f:%l:%c,%Z'
        if vim.fn.filereadable('./Cargo.toml') == 1 then
            vim.opt.makeprg = 'cargo build'
        else
            vim.opt.makeprg = "rustc %"
        end
    end,
})
vim.api.nvim_create_autocmd({"CmdWinEnter"}, {
    callback = function()
        vim.keymap.set('n', '<C-O>', '<C-C>', {buffer = true})
        -- vim.keymap.del('', '<C-C>', {})
    end,
})
vim.api.nvim_create_autocmd({"CmdWinLeave"}, {
    callback = function()
        vim.keymap.set('', '<C-C>', '<Esc>', {})
    end,
})
