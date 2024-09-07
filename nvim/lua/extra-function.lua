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

local run_cmd = nil
function m.build_and_run_cmd(data)
    local info = vim.fn.getbufinfo(vim.fn.bufnr());
    if #info > 0 then info = info[1] end
    if vim.opt.autowrite._value and vim.bo.buftype == "" and info.changed == 1 and info.name ~= "" then
        vim.cmd "wa"
    end
    if data.fargs[1] then
        run_cmd = string.format('term %s', data.fargs[1]):gsub(' ', '\\ ')
    end
    if vim.opt.makeprg._value ~= 'make' or vim.fn.filereadable('makefile') == 1 or vim.fn.filereadable('Makefile') == 1 then
        local cmd = vim.fn.expandcmd(vim.opt.makeprg._value)
        local output = vim.system(vim.split(cmd, ' ')):wait()
        vim.fn.setqflist({})
        local result = output.stdout .. '\n' .. output.stderr
        local err = result:gsub('"', '\\"'):gsub('\n', '\\n')
        vim.cmd(string.format('cexpr "%s" | cw', err))
        if output.code == 0 and run_cmd then
            vim.cmd(string.format("belowright split +%s", run_cmd))
            local key = vim.api.nvim_replace_termcodes("<cr>", true, false, true)
            vim.api.nvim_feedkeys(key, 'n', false)
        elseif output.code == 0 then
            print("No run command")
        end
    else
        vim.api.nvim_err_writeln("No makefiles found")
    end
end

function m.delete_trailing()
    local view = vim.fn.winsaveview()
    vim.cmd "%s/ *$// | %s/\\n*\\%$// | nohl"
    vim.fn.winrestview(view)
end


return m

