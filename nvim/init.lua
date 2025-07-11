vim.fn.is_module_available = function(module)
    local function requiref(module)
        require(module)
    end
    res = pcall(requiref,module)
    if not(res) then
        return false
    else
        return true
    end
end

vim.cmd("source " .. vim.fn.stdpath('config') .. "/options.vim")
require 'plugins'
require 'keymap'
require 'autocmd'
require 'ftdetect'
vim.cmd 'cabbrev mkae make'

vim.fn.SetColor 'termlike'

local extra_func = require 'extra-function'
vim.api.nvim_create_user_command('Brun', extra_func.build_and_run_cmd, {bang = true, bar = true, nargs = '?', complete = 'file'})
-- vim.api.nvim_create_user_command('GConflict', function()
--     vim.cmd [[vimgrep "<<<<<<< HEAD\(.*\n\)*=======\(.*\n\)*>>>>>>> .*\n" **/*]]

vim.api.nvim_create_user_command('Conflict', function()
    local obj = vim.system({"git", "--no-pager", "diff", "--no-color", "--check", "--relative"}, {text = true}):wait();
    if obj.code == 0 then
        vim.api.nvim_err_writeln("No conflict found !!!")
    elseif obj.code == 2 then
        local lines = vim.split(vim.trim(obj.stdout), "\n")
        local current_file_lines = nil
        local count = 0
        local qf_list = {}
        for i, line in pairs(lines) do
            local f_name, f_line, ignored = unpack(vim.split(line, ":"))
            if count == 0 then
                local bufnr = vim.fn.bufadd(f_name)
                vim.fn.setbufline(bufnr, f_line, "")
                qf_list[#qf_list + 1] = {bufnr = bufnr, lnum = f_line, col = 1}
            end
            count = (count + 1)%3
        end
        vim.fn.setqflist(qf_list)
        vim.cmd "cfirst"
    elseif obj.code ~= 2 then
        vim.api.nvim_err_writeln(vim.split(obj.stderr, "\n")[1])
    end
end, {bar = true, nargs = 0})

vim.api.nvim_create_user_command('Color',
            function(data) vim.fn.SetColor(data.fargs[1]) end,
            {bang = true, bar = true, nargs = 1, complete = 'color'})


vim.api.nvim_create_user_command('Scratch', function()
    if vim.g.scratch_buffer == nil then
        vim.cmd(string.format("b %s", vim.api.nvim_create_buf(false, true)))
        vim.g.scratch_buffer = vim.fn.bufnr()
    else
        vim.cmd(string.format("b %s", vim.g.scratch_buffer))
		vim.cmd "setlocal buftype=nofile"
		vim.cmd "setlocal bufhidden=hide"
		vim.cmd "setlocal noswapfile"
    end
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Write', function() -- so that :W work -_-
    vim.cmd "write"
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Dtrailing', extra_func.delete_trailing, {bang = true, bar = true})

vim.api.nvim_create_user_command('Qfix', function()
    vim.cmd "vsplit | vertical resize 65 | copen | set nowrap | wincmd k | close"
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('HTMLInit', function()
    vim.api.nvim_buf_set_text(0, 0, 0, 0, 0, {
    '<!DOCTYPE html>',
    '<html lang="en">',
    '<head>',
    '    <meta charset="UTF-8">',
    '    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
    '    <title>Document</title>',
    '</head>',
    '<body>',
    '    ',
    '</body>',
    '</html>'})
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('MIT', function()
    vim.api.nvim_buf_set_text(0, 0, 0, 0, 0,
    { 'MIT License',
    '',
    'Copyright (c) 2023 dangvinhtuong12@gmail.com',
    '',
    'Permission is hereby granted, free of charge, to any person obtaining a copy',
    'of this software and associated documentation files (the "Software"), to deal',
    'in the Software without restriction, including without limitation the rights',
    'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell',
    'copies of the Software, and to permit persons to whom the Software is',
    'furnished to do so, subject to the following conditions:',
    '',
    'The above copyright notice and this permission notice shall be included in all',
    'copies or substantial portions of the Software.',
    '',
    'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR',
    'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,',
    'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE',
    'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER',
    'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,',
    'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE',
    'SOFTWARE.'})
end, {bang = true, bar = true})

if vim.g.neovide then
    require 'gui-options'
end
