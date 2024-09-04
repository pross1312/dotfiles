local map = vim.keymap.set

local extra = require 'extra-function'

map('n', '<C-c>', '<Esc>', {})
map('v', '<C-c>', '<Esc>', {})
map('i', '<C-c>', '<Esc>', {})

map('i', '<C-s>', '<Cmd>write<CR>', {})

map('n', '<C-]>', 'g<C-]>', {})

map('x', '<leader>a', '<Plug>(EasyAlign)', {})
map('n', '<leader>a', '<Plug>(EasyAlign)', {})
map('n', '<C-G>', '1<C-G>', {})
map('n', '<m-h>', '<c-w>h', {})
map('n', '<m-j>', '<c-w>j', {})
map('n', '<m-k>', '<c-w>k', {})
map('n', '<m-l>', '<c-w>l', {})
-- map('n', '<esc>', '<Cmd>nohlsearch<CR>', {})
map('n', '<C-L>', '<Cmd>nohlsearch<CR>', {})
map('n', '<c-s>', '<c-^>', {})
map('n', '<m-m>',  '<cmd>Brun<cr>', {})
map('i', '<c-r>',  '<c-r><c-o>', {})
-- map('n', '<c-s>', extra.swap_header_src, {})
-- map('n', '!', '^', {})
--map('n', '<c-t>', function()
--    if vim.g.pre_buffer then
--        vim.cmd("buffer " .. vim.g.pre_buffer)
--    else
--        vim.api.nvim_err_writeln('No buf found') end
--end, {})
map('n', 'p', 'p`]', {}) -- jump to end after pasting text
map('n', '<c-m-l>', '<Cmd>vertical res +5<cr>', {})
map('n', '<c-m-h>', '<Cmd>vertical res -5<cr>', {})
map('n', '<c-m-j>', '<Cmd>horizontal res -5<cr>', {})
map('n', '<c-m-k>', '<Cmd>horizontal res +5<cr>', {})
map('n', '<c-k>', '<cmd>cp<cr>', {})
map('n', '<c-j>', '<cmd>cn<cr>', {})
map('n', '<C-p>', '<CMD>Lexplore %:p:h<CR>', {})
map('n', '<leader>nf', '<Cmd>Lexplore %:p:h<cr>', {})

-- jump root (start directory)
map('n', '<leader>jr', function()
                            print(vim.g.root_dir)
                            vim.cmd(string.format("cd %s", vim.g.root_dir))
                        end,
                        {silent = false})
map('n', '<leader>sr', function()
                            vim.g.root_dir = vim.fn.expand('%:p:h')
                            print(vim.g.root_dir)
                       end, {})
map('n', '<leader>jc', function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 1 then
        vim.cmd(string.format("cd %s", dir))
        print(dir)
    else
        vim.api.nvim_err_writeln('No directory found')
    end
end, {})
-- command mode mapping
local cedit = "<C-O>"
vim.cmd(string.format('exe "set cedit=\\%s"',cedit))
map('c', '<C-a>', '<Home>', {})
map('c', '<C-e>', '<End>', {})
map('c', '<C-f>', '<Right>', {})
map('c', '<C-b>', '<Left>', {})
map('c', '<M-b>', '<S-Left>', {})
map('c', '<M-f>', '<S-Right>', {})
map('c', '<C-k>', cedit .. 'D<C-C>', {})
for i=1,9 do
    map('n', string.format('<M-%d>', i), i .. 'gt', {})
    map('t', string.format('<M-%d>', i), '<c-bslash><c-n>' .. i .. 'gti', {})
    map('i', string.format('<M-%d>', i), '<Esc>'.. i .. 'gt', {})
end
