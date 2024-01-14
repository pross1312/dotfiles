local map = vim.keymap.set

local extra = require 'extra-function'

-- map('n', '<C-c>', '<Esc>', {})
map('v', '<C-c>', '<Esc>', {})
map('i', '<C-c>', '<Esc>', {})

map('i', '<C-s>', '<Cmd>write<CR>', {})
map('i', '<M-i>', vim.lsp.buf.hover, {silent = true})


map('x', '<leader>a', '<Plug>(EasyAlign)', {silent = true})
map('n', '<leader>a', '<Plug>(EasyAlign)', {silent = true})
map('n', '<C-G>', '1<C-G>', {silent = true})
map('n', '<m-h>', '<c-w>h', {})
map('n', '<m-j>', '<c-w>j', {})
map('n', '<m-k>', '<c-w>k', {})
map('n', '<m-l>', '<c-w>l', {})
-- map('n', '<esc>', '<Cmd>nohlsearch<CR>', {silent = true})
map('n', '<C-L>', '<Cmd>nohlsearch<CR>', {silent = true})
map('n', '<c-s>', '<c-^>', {silent = true})
map('n', '<m-m>',  '<cmd>make<cr>', {silent = true})
map('i', '<c-r>',  '<c-r><c-o>', {silent = true})
-- map('n', '<c-s>', extra.swap_header_src, {silent = true})
-- map('n', '!', '^', {silent = true})
--map('n', '<c-t>', function()
--    if vim.g.pre_buffer then
--        vim.cmd("buffer " .. vim.g.pre_buffer)
--    else
--        print('No buf found') end
--end, {silent = true})
map('n', 'p', 'p`]', {silent = true}) -- jump to end after pasting text
map('n', '<c-m-l>', '<Cmd>vertical res +5<cr>', {silent = true})
map('n', '<c-m-h>', '<Cmd>vertical res -5<cr>', {silent = true})
map('n', '<c-m-j>', '<Cmd>horizontal res -5<cr>', {silent = true})
map('n', '<c-m-k>', '<Cmd>horizontal res +5<cr>', {silent = true})
map('n', '<c-k>', '<cmd>cp<cr>', {silent = true})
map('n', '<c-j>', '<cmd>cn<cr>', {silent = true})
map('n', '<C-p>', '<CMD>Lexplore %:p:h<CR>', {silent = true})
map('n', '<leader>nf', '<Cmd>Lexplore %:p:h<cr>', {silent = true})

-- jump root (start directory)
map('n', '<leader>jr', function()
                            print(vim.g.root_dir)
                            vim.cmd(string.format("cd %s", vim.g.root_dir))
                        end,
                        {silent = false})
map('n', '<leader>sr', function()
                            vim.g.root_dir = vim.fn.expand('%:p:h')
                            print(vim.g.root_dir)
                       end, {silent = true})
map('n', '<leader>jc', function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 1 then
        vim.cmd(string.format("cd %s", dir))
        print(dir)
    else
        print('No directory found')
    end
end, {silent = true})
-- command mode mapping
map('c', '<C-a>', '<Home>', {})
map('c', '<C-e>', '<End>', {})
map('c', '<C-k>', '<C-F>D<C-C>', {})
for i=1,9 do
    map('n', string.format('<M-%d>', i), i .. 'gt', {})
    map('t', string.format('<M-%d>', i), '<c-bslash><c-n>' .. i .. 'gti', {})
    map('i', string.format('<M-%d>', i), '<Esc>'.. i .. 'gt', {})
end
