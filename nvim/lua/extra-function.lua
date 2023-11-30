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

local term_view_file = vim.fn.stdpath("cache") .. "/term_temp_view"
local main_view_file = vim.fn.stdpath("cache") .. "/main_temp_view"
local prev_term_mode = 't'
function m.switch_term()
    local term_pattern = 'term://.+/bin/bash$'
    local in_term = vim.api.nvim_buf_get_name(0):match(term_pattern)
    if in_term then
        vim.cmd("mksession! " ..term_view_file)
        if vim.fn.empty(vim.fn.glob(main_view_file)) == 0 then
            prev_term_mode = vim.fn.mode()
            vim.cmd("so " .. main_view_file)
        else
            vim.cmd "only"
            vim.cmd "Sc"
        end
    else
        vim.keymap.set('t', '<m-o>', 'cd ' .. vim.fn.getcwd() .. '<cr>', {silent = true}) -- to quickly jump to current directory
        vim.cmd("mksession! " .. main_view_file)
        if vim.fn.empty(vim.fn.glob(term_view_file)) == 0 then
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

function m.clean_term()
    vim.system({"rm", "-f",term_view_file}):wait()
    vim.system({"rm", "-f", main_view_file}):wait()
end

function m.remove_all_buffers()
    local term_pattern = 'term://.+/bin/bash$'
    local in_term = vim.api.nvim_buf_get_name(0):match(term_pattern)
    if not in_term then
        m.switch_term()
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

function m.run_cmd(data)
    if vim.opt.autowrite and vim.bo.buftype == "" then vim.cmd "w" end
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
    vim.cmd "%s/ *$// | %s/\\n*\\%$// | nohl"
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

