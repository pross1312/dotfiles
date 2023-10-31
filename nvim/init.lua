require 'plugins'
require 'options'
require 'keymap'
require 'autocmd'
vim.cmd 'cabbrev mkae make'
function set_color(name)
    vim.cmd('colorscheme ' .. name)
    vim.cmd 'hi clear CursorLine'
    vim.cmd 'hi clear Todo' -- use todo-comments plugin instead
    vim.cmd "hi MyMultiCursor guibg=#777777 gui=bold"
end

set_color 'tokyonight-night'

local extra_func = require 'extra-function'
vim.api.nvim_create_user_command('Run', extra_func.run_cmd, {bang = true, bar = true, nargs = '?', complete = 'file'})

vim.api.nvim_create_user_command('Color',
            function(data) set_color(data.fargs[1]) end,
            {bang = true, bar = true, nargs = 1, complete = 'color'})

vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd(string.format("b %s", vim.api.nvim_create_buf(true, true)))
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd(string.format("b %s", vim.api.nvim_create_buf(true, true)))
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Dtrailing', extra_func.delete_trailing, {bang = true, bar = true})

vim.api.nvim_create_user_command('Qfix', function()
    vim.cmd "vsplit | vertical resize 55 | copen | set nowrap | wincmd k | close"
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('RemoveAllBuffers', function()
    extra_func.remove_all_buffers()
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('HtmlInit', function()
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
    'Copyright (c) 2023 pross1312',
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
