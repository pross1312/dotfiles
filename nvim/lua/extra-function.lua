vim.g.alter_dir = vim.fn.fnamemodify(os.getenv('MYVIMRC'), ':p:h')
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

vim.g.prev_term_mode = 'n'
function m.switch_term()
    local term_pattern = 'term://.+/bin/bash$'
    local in_term = vim.api.nvim_buf_get_name(0):match(term_pattern)
    local buffers = vim.fn.getbufinfo({buflisted = true}) -- list all buffers
    if in_term then
        vim.g.prev_term_mode = vim.fn.mode()
        if vim.g.pre_buffer then
            if #buffers == 1 and vim.fn.bufname(vim.g.pre_buffer):match(term_pattern) then vim.cmd("buffer " .. vim.api.nvim_create_buf(true, false))
            elseif vim.fn.bufexists(vim.g.pre_buffer) == 1 then vim.cmd("buffer " .. vim.g.pre_buffer)
            else vim.g.pre_buffer = nil
            end
        else
            print('No buffer found')
        end
    else
        vim.g.pre_buffer = vim.fn.bufnr()
        vim.keymap.set('t', '<m-k>', 'cd ' .. vim.fn.getcwd() .. '<cr>', {silent = true}) -- to quickly jump to current directory
        if vim.fn.bufexists(vim.g.extra_term) == 0 or not vim.fn.bufname(vim.g.extra_term):match(term_pattern) then
            vim.g.extra_term = nil
        end
        if vim.g.extra_term then
            vim.cmd("buffer " .. vim.g.extra_term)
        else
            vim.cmd "term"
            vim.g.extra_term = vim.fn.bufnr()
        end
        if vim.g.prev_term_mode == 't' then vim.cmd "startinsert" end
    end
end

function m.run_cmd(data)
    if vim.opt.autowrite then vim.cmd "w" end
    if not data.fargs[1] and vim.g.run_cmd then
        vim.cmd(string.format("split | term %s", vim.g.run_cmd))
    elseif data.fargs[1] then
        vim.cmd(string.format("split | term %s", data.fargs[1]))
        vim.g.run_cmd = data.fargs[1]
    else
        print('No command provided')
    end
end

function m.delete_trailing()
    local view = vim.fn.winsaveview()
    vim.cmd "%s/ *$// | %s/\\n*\\%$//"
    vim.fn.winrestview(view)
end

function m.turn_ibus_engine_on(engine)
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

return m

