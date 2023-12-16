require 'options'
require 'plugins'
require 'keymap'
require 'autocmd'
vim.cmd 'cabbrev mkae make'
function set_color(name)
    vim.cmd('colorscheme ' .. name)
    if name == "codeschool" then
        vim.cmd "hi Normal guifg=#efefef"
        vim.cmd "hi clear SignColumn"
        vim.cmd "hi CursorLineNr guibg=NONE"
    end
    vim.cmd "hi! clear TermCursorNC"
    vim.cmd "hi! clear Cursor"
    vim.cmd "hi! clear TermCursor"
    vim.cmd "hi! link VertSplit normal"
    vim.cmd "hi! link StatusLine normal"
    vim.cmd "hi! link StatusLineNC normal"
    vim.cmd 'hi clear CursorLine'
    vim.cmd "hi! MatchParen guifg=#ff0000 guibg=none"
    vim.cmd "hi! Cursor guibg=#ffffff guifg=#000000"
    vim.cmd "hi! link TermCursor Cursor"
    vim.cmd "hi Normal guifg=#ffffff"
    vim.cmd "hi MyMultiCursor guibg=#777777 gui=bold"
    vim.cmd "hi! TodoFgTODO guifg=#8a8a8"
    vim.cmd "hi! TodoFgNOTE guifg=#8a8a8"
    vim.cmd "hi! TodoFgFIX guifg=#8a8a8"
    vim.cmd "hi! TodoBgTODO guibg=#BF0606 guifg=#560303 gui=bold"
    vim.cmd "hi! TodoBgNOTE guibg=#BF0606 guifg=#560303 gui=bold"
    vim.cmd "hi! TodoBgFIX guibg=#BF0606 guifg=#560303 gui=bold"
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

vim.g.codeschool_contrast_dark = "hard"
set_color 'gruvbox'

local extra_func = require 'extra-function'
vim.api.nvim_create_user_command('Run', extra_func.run_cmd, {bang = true, bar = true, nargs = '?', complete = 'file'})

vim.api.nvim_create_user_command('Color',
            function(data) set_color(data.fargs[1]) end,
            {bang = true, bar = true, nargs = 1, complete = 'color'})


vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd(string.format("b %s", vim.api.nvim_create_buf(false, true)))
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Write', function()
    vim.cmd "write"
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Dtrailing', extra_func.delete_trailing, {bang = true, bar = true})

vim.api.nvim_create_user_command('Qfix', function()
    vim.cmd "vsplit | vertical resize 65 | copen | set nowrap | wincmd k | close"
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('RemoveAllBuffers', function()
    extra_func.remove_all_buffers()
end, {bang = true, bar = true})

vim.api.nvim_create_user_command('Cleanterm', function()
    extra_func.clean_term()
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
vim.cmd(string.format("source %s/vim-plugins/vim-cool/plugin/cool.vim", vim.fn.stdpath("config")))
