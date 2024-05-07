local term_root_dir = vim.fn.stdpath("cache") .. "/term_cache"
local term_dir = term_root_dir .. "/0"
local term_view_file = nil -- NOTE: setup later in setup_term function when VimEnter
local main_view_file = nil --
local prev_term_mode = 't'
local term_pattern = nil -- string:match use regex
local au_cmd_term_pattern = nil -- auto command use a different pattern (grub ???)
if vim.loop.os_uname().sysname ~= "Linux" then -- windows
    term_pattern = "term://.+powershell%.EXE$"
    au_cmd_term_pattern = 'term://*powershell.EXE'
else
    term_pattern = 'term://.+/bin/bash$'
    au_cmd_term_pattern = 'term://*/bin/bash'
end

function switch_term()
    local in_term = vim.api.nvim_buf_get_name(0):match(term_pattern)
    if in_term then
        vim.cmd("mksession! " ..term_view_file)
        if vim.fn.empty(vim.fn.filereadable(main_view_file)) == 0 then
            prev_term_mode = vim.fn.mode()
            vim.cmd("so " .. main_view_file)
        else
            vim.cmd "only"
            vim.cmd "Sc"
        end
    else
        if vim.opt.autowrite and vim.bo.buftype == "" then vim.cmd "wa" end
        vim.keymap.set('t', '<m-o>', 'cd ' .. vim.fn.getcwd() .. '<cr>') -- to quickly jump to current directory
        vim.cmd("mksession! " .. main_view_file)
        if vim.fn.empty(vim.fn.filereadable(term_view_file)) == 0 then
            local buffers = vim.fn.getbufinfo({buflisted = true}) -- list all buffers
            vim.cmd("so " ..term_view_file)
            if prev_term_mode == 't' then
                vim.cmd "startinsert"
                vim.opt.scrolloff = vim.g.scrolloff.h -- switch to terminal mode break scrolloff for some reasons
                vim.opt.sidescrolloff = vim.g.scrolloff.w -- switch to terminal mode break scrolloff for some reasons
            end
            return
        end
        vim.cmd "only"
        vim.cmd "term"
        vim.cmd "hi Cursor guifg=#000000 guibg=#ffffff"
        vim.cmd "hi! link TermCursor Cursor"
        if prev_term_mode == 't' then
            vim.cmd "startinsert"
            vim.opt.scrolloff = vim.g.scrolloff.h -- switch to terminal mode break scrolloff for some reasons
            vim.opt.sidescrolloff = vim.g.scrolloff.w -- switch to terminal mode break scrolloff for some reasons
        end
    end
end

function setup_term()
    if vim.fn.isdirectory(term_root_dir) ~= 1 then
        vim.fn.mkdir(term_root_dir)
    end
    local i = 0
    while vim.fn.isdirectory(term_dir) == 1 do
        i = i + 1
        term_dir = term_root_dir .. "/" .. i
    end
    term_view_file = term_dir .. "/term_temp_view"
    main_view_file = term_dir .. "/main_temp_view"
    vim.fn.mkdir(term_dir)
end

function clean_term()
    vim.system({"rm", "-rf", term_dir}):wait()
end

local remove_all_but_terms = function()
    local in_term = vim.api.nvim_buf_get_name(0):match(term_pattern)
    if not in_term then
        switch_term()
    end
    local buffers = vim.fn.getbufinfo({buflisted = true}) -- list all buffers
    for i, v in pairs(buffers) do
        if not v.name:match(term_pattern) then
            vim.cmd(string.format("bd %d", v.bufnr))
        end
    end
    vim.cmd "LspRestart"
    vim.system({"rm", "-f", main_view_file}):wait()
end

-- **KEY MAP**
vim.keymap.set('n', '<c-t>', switch_term, {silent = true})


-- **AUTO COMMAND**
local custom_term = vim.api.nvim_create_augroup("CustomizedTerm", { clear = true })
vim.api.nvim_create_autocmd('VimEnter', { -- remove temp view that switch_term use
    callback = function(_)
        setup_term()
    end,
    group = custom_term
})
vim.api.nvim_create_autocmd('VimLeave', { -- remove temp view that switch_term use
    callback = function(_)
        clean_term()
    end,
    group = custom_term
})
vim.api.nvim_create_autocmd({'TermOpen', 'BufEnter'}, {
    pattern = au_cmd_term_pattern,
    callback = function(_)
        -- vim.keymap.set('t', '<esc>', '<c-bslash><c-n>', {silent = true, buffer = true})
        -- vim.keymap.set('t', '<c-m>', 'pwd<CR><c-bslash><c-n>G?^\\/.\\+$<CR>yy<esc>:cd <C-r>"<CR>i', {silent = true, buffer = true})
        vim.cmd "set nobuflisted"
        vim.keymap.set('t', '<m- >', function()
            switch_term()
            require("telescope.builtin").find_files()
        end, {buffer = true})
        vim.keymap.set('t', '<c-t>', switch_term, {silent = true, buffer = true})
        vim.keymap.set('t', '<c-s>', switch_term, {silent = true, buffer = true})
        vim.keymap.set('t', '<m-h>', '<c-bslash><c-n><c-w>hi', {buffer = true})
        vim.keymap.set('t', '<m-j>', '<c-bslash><c-n><c-w>ji', {buffer = true})
        vim.keymap.set('t', '<m-k>', '<c-bslash><c-n><c-w>ki', {buffer = true})
        vim.keymap.set('t', '<m-l>', '<c-bslash><c-n><c-w>li', {buffer = true})
        vim.keymap.set('t', '<m-s>', '<c-bslash><c-n>:split | term<cr>i', {silent = true})
        vim.keymap.set('t', '<m-v>', '<c-bslash><c-n>:vertical split | term<cr>i', {silent = true})
        vim.keymap.set('n', '<m-s>', ':split | term<cr>', {buffer = true, silent = true})
        vim.keymap.set('n', '<m-v>', ':vertical split | term<cr>', {buffer = true, silent = true})
        vim.keymap.set('n', '<c-s>', switch_term, {silent = true, buffer = true})
        vim.keymap.set('n', '<C-p>', '<nop>', {buffer = true})
        vim.keymap.set('n', '<m- >', function()
            switch_term()
            require("telescope.builtin").find_files()
        end, {buffer = true, silent = true}) -- to quickly jump to current directory
        vim.keymap.set('n', '<C-o> ', '<nop>', {buffer = true, silent = true}) -- to quickly jump to current directory
    end,
    group = custom_term
})
return {remove_all_but_terms = remove_all_but_terms}
