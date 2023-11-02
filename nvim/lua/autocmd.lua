vim.g.ibus_vn_engine = 'Bamboo'
vim.g.ibus_eng_engine = 'BambooUs'
vim.g.prev_ibus_engine = vim.g.ibus_eng_engine
local extra_fn = require('extra-function')
vim.api.nvim_create_augroup('IbusHandler', {clear = true})
vim.api.nvim_create_autocmd('CmdlineEnter', {
    callback = function(_) extra_fn.turn_ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('CmdlineLeave', {
    callback = function(_) extra_fn.turn_ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(_) extra_fn.turn_ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('InsertEnter', {
    pattern = '*',
    callback = function(_) extra_fn.turn_ibus_engine_on(vim.g.prev_ibus_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    callback = function(_) extra_fn.turn_ibus_engine_on(vim.g.ibus_eng_engine) end,
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
-- this break undo (make it too annoying to use)
-- vim.api.nvim_create_autocmd('BufWritePre', {
--     pattern = '*',
--     callback = function()
--         local view = vim.fn.winsaveview()
--         vim.cmd "%s/ *$// | %s/\\n*\\%$//"
--         vim.fn.winrestview(view)
--     end
-- })
