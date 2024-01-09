function turn_ibus_engine_on(engine)
    local cur_engine = nil
    local check_cmd = {"ibus", "engine"}
    if not xpcall(function()
        local output = vim.system(check_cmd):wait()
        if output.code ~= 0 then
            print('Something wrong happen with `ibus engine` cmd')
            return
        end
        cur_engine = output.stdout:sub(1, #output.stdout - 1)
    end, function(err)
        print(string.format('Command `%s` not found', table.concat(check_cmd, ' ')))
    end) then return end
    if cur_engine and cur_engine ~= engine then
        vim.g.prev_ibus_engine = cur_engine
        local output = vim.system({'ibus', 'engine', engine}):wait()
        if output.code ~= 0 then
            print(string.format('Something wrong happen when execute `ibus engine %s` cmd', engine))
        end
    end
end
vim.g.ibus_vn_engine = 'Bamboo'
vim.g.ibus_eng_engine = 'BambooUs'
vim.g.prev_ibus_engine = vim.g.ibus_eng_engine
vim.api.nvim_create_augroup('IbusHandler', {clear = true})
vim.api.nvim_create_autocmd('CmdlineEnter', {
    callback = function(_) turn_ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('CmdlineLeave', {
    callback = function(_) turn_ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(_) turn_ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('InsertEnter', {
    pattern = '*',
    callback = function(_) turn_ibus_engine_on(vim.g.prev_ibus_engine) end,
    group = 'IbusHandler'
})
vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    callback = function(_) turn_ibus_engine_on(vim.g.ibus_eng_engine) end,
    group = 'IbusHandler'
})

