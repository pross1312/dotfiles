local m = {}
function m.swap_header_src()
    local file_path = vim.fn.expand('%');
    local extension = file_path:match("%..+$")
    if not extension then return end
    local file_name = file_path:sub(1, file_path:find("%..+$") - 1)
    local swap_table = {
        ['.cpp'] = {'.h', '.hpp'},
        ['.h'] = {'.cpp', '.cc', '.c'},
    }
    local alter_extensions = swap_table[extension]
    local swap_file = nil
    if type(alter_extensions) == 'table' then
        for _, val in pairs(alter_extensions) do
            local check_existed = io.open(file_name .. val, 'r')
            if check_existed then
                swap_file = file_name .. val
                break
            end
        end
        if not swap_file then swap_file = file_name .. swap_table[extension][1] end
    elseif type(alter_extensions) == 'string' then
        swap_file = file_name .. swap_table[extension]
    end
    if swap_file then vim.cmd(string.format("e %s", swap_file)) end
end

function m.build_and_run_cmd(data)
    local ok, stats = pcall(vim.cmd, "make")
    print(ok, stats)
    if ok then
        if not data.fargs[1] and vim.g.run_cmd then
            vim.cmd(string.format("split | term %s", vim.g.run_cmd))
        elseif data.fargs[1] then
            vim.cmd(string.format("split | term %s", data.fargs[1]))
            vim.g.run_cmd = data.fargs[1]
        else
            print('No command provided')
        end
    end
end

function m.delete_trailing()
    local view = vim.fn.winsaveview()
    vim.cmd "%s/ *$// | %s/\\n*\\%$// | nohl"
    vim.fn.winrestview(view)
end


return m

