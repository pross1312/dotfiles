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

require 'options'
require 'plugins'
require 'keymap'
require 'autocmd'
require 'ibus'
require 'ftdetect'
vim.cmd 'cabbrev mkae make'
function set_color(name)
    vim.o.background = 'dark'
    vim.cmd('colorscheme ' .. name)
    vim.cmd "hi! link WinSeparator normal"
    vim.cmd "hi! link StatusLine WinSeperator"
    vim.cmd "hi! link StatusLineNC normal"
    vim.cmd 'hi! clear CursorLine'
    -- vim.cmd "hi! MatchParen guifg=#ff0000 guibg=none"
    vim.cmd "hi! clear Cursor"
    vim.cmd "hi! Cursor guibg=#ffffff guifg=#000000"
    vim.cmd "hi! clear TermCursor"
    vim.cmd "hi! link TermCursor Cursor"
    -- vim.cmd "hi Normal guifg=#ffffff"
    vim.cmd "hi! link VM_Mono Cursor"
    vim.cmd "hi! TodoFgTODO guifg=#8a8a8"
    vim.cmd "hi! TodoFgNOTE guifg=#8a8a8"
    vim.cmd "hi! TodoFgFIX guifg=#8a8a8"
    vim.cmd "hi! TodoBgTODO guibg=#BF0606 guifg=#560303 gui=bold"
    vim.cmd "hi! TodoBgNOTE guibg=#BF0606 guifg=#560303 gui=bold"
    vim.cmd "hi! TodoBgFIX guibg=#BF0606 guifg=#560303 gui=bold"
    -- neogit
    -- vim.cmd "hi! NeogitCursorLine guibg=NONE"
    -- vim.cmd "hi! NeogitDiffAddHighlight guibg=NONE"
    -- vim.cmd "hi! link NeogitDiffAdd NeogitDiffAddHighlight"
    -- vim.cmd "hi! link NeogitDiffAddRegion NeogitDiffAdd"

    -- vim.cmd "hi! NeogitDiffDeleteHighlight guifg=#bc4650 guibg=NONE"
    -- vim.cmd "hi! link NeogitDiffDelete NeogitDiffDeleteHighlight"
    -- vim.cmd "hi! link NeogitDiffDeleteRegion NeogitDiffDelete"
    -- vim.cmd "hi! NeogitHunkHeader guibg=NONE guifg=#09867D gui=bold,italic"
    -- vim.cmd "hi! link NeogitHunkHeaderHighlight NeogitHunkHeader"
    -- vim.cmd "hi! NeogitDiffContext guibg=NONE"
    -- vim.cmd "hi! NeogitDiffContextHighlight guibg=NONE"
    -- terminal config
    vim.g.terminal_color_0 = "#7D8EB0"
    vim.g.terminal_color_1 = "#f7768e"
    vim.g.terminal_color_2 = "#9ece6a"
    vim.g.terminal_color_3 = "#e0af68"
    vim.g.terminal_color_4 = "#7aa2f7"
    vim.g.terminal_color_5 = "#bb9af7"
    vim.g.terminal_color_6 = "#7dcfff"
    vim.g.terminal_color_7 = "#a9b1d6"
    vim.g.terminal_color_8 = "#7D8EB0"
    vim.g.terminal_color_9 = "#f7768e"
    vim.g.terminal_color_10 = "#9ece6a"
    vim.g.terminal_color_11 = "#e0af68"
    vim.g.terminal_color_12 = "#7aa2f7"
    vim.g.terminal_color_13 = "#bb9af7"
    vim.g.terminal_color_14 = "#7dcfff"
    vim.g.terminal_color_15 = "#c0caf5"
end

set_color 'habamax'

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
            function(data) set_color(data.fargs[1]) end,
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
