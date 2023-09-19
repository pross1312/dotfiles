vim.g.ibus_vn_engine = 'Bamboo'
vim.g.ibus_eng_engine = 'BambooUs'
vim.g.prev_ibus_engine = vim.g.ibus_eng_engine
vim.g.disable_ibus_error = false
vim.g.has_ibus = true -- asume we have it
local function ibus_engine_on(engine)
    if not vim.g.has_ibus then return end
    if (type(engine) ~= 'string') then error(string.format('Invalid type %s', type(engine))) end
    local output = vim.system({"ibus", "engine"}):wait()
    if output.code ~= 0 or output.signal ~= 0 then
        if not vim.g.disable_ibus_error then
            print('Something wrong happen with `ibus engine` cmd')
            vim.g.has_ibus = false
        end
        return
    end
    local cur_engine = output.stdout:sub(1, #output.stdout - 1)
    if cur_engine ~= engine then
        vim.g.prev_ibus_engine = cur_engine
        output = vim.system({'ibus', 'engine', engine}):wait()
        if output.stderr ~= nil and output.stderr ~= '' then
            print(string.format('Something wrong happen when execute `ibus engine %s` cmd', engine))
            vim.g.has_ibus = false
        end
    end
end

vim.api.nvim_create_augroup('IbusHandler', {clear = true})
vim.api.nvim_create_autocmd('CmdlineEnter', {
    callback = function(_) ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('CmdlineLeave', {
    callback = function(_) ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(_) ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('InsertEnter', {
    pattern = '*',
    callback = function(_) ibus_engine_on(vim.g.prev_ibus_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    callback = function(_) ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(_)
        vim.g.root_dir = vim.fn.getcwd()
        if vim.g.root_dir ~= vim.fn.expand('%:p:h') then
            vim.g.alter_dir = vim.fn.expand('%:p:h')
        end
    end
})
vim.api.nvim_create_autocmd({'TermOpen', 'BufEnter'}, {
    pattern = "term://*/bin/bash",
    callback = function(_)
        vim.keymap.set('t', '<esc>', '<c-bslash><c-n>', {silent = true, buffer = true})
        -- vim.keymap.set('t', '<c-m>', 'pwd<CR><c-bslash><c-n>G?^\\/.\\+$<CR>yy<esc>:cd <C-r>"<CR>i', {silent = true, buffer = true})
        vim.keymap.set('t', '<m-j>', '<C-a><C-k>pwd<CR><c-bslash><c-n>G$?^\\/.\\+$<CR>yy:cd <C-r>"<CR>', {silent = true, buffer = true})
    end
})
vim.api.nvim_create_autocmd('BufEnter', {
    pattern =  "*.py",
    callback = function(_)
        vim.cmd "compiler pyunit"
    end
})
-- remove trailing space (end of line) and newline (end of file)
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd "%s/ *$// | %s/\\n*\\%$//"
        vim.fn.winrestview(view)
    end
})

vim.api.nvim_create_autocmd('filetype', {
    pattern = 'netrw',
    desc = 'Better mappings for netrw',
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, {remap = true, buffer = true})
        end
        -- edit new file
        bind('n', '%')
        -- rename file
        bind('r', 'R')
        bind('<esc>', '-cd')
        bind('h', '<CR>cd')
    end
})
