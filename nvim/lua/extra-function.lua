local m = {}
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
        -- vim.cmd(string.format('copen | cexpr "%s"', err))
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
