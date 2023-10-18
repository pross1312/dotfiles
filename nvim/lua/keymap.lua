local map = vim.keymap.set

local extra = require 'extra-function'

-- map('n', '<C-c>', '<Esc>', {})
map('v', '<C-c>', '<Esc>', {})
map('i', '<C-c>', '<Esc>', {})

map('i', '<C-s>', '<Cmd>write<CR>', {})

map('x', '<leader>a', '<Plug>(EasyAlign)', {silent = true})
map('n', '<leader>a', '<Plug>(EasyAlign)', {silent = true})
map('n', '<m-h>', '<c-w>h', {})
map('n', '<m-j>', '<c-w>j', {})
map('n', '<m-k>', '<c-w>k', {})
map('n', '<m-l>', '<c-w>l', {})
map('n', '<esc>', '<Cmd>nohlsearch<CR>', {silent = true})
map('n', '<c-s>', '<c-^>', {silent = true})
map('n', '<m-m>',  '<cmd>Run<cr>', {silent = true})
map('i', '<c-r>',  '<c-r><c-o>', {silent = true})
-- map('n', '<c-s>', extra.swap_header_src, {silent = true})
-- map('n', '!', '^', {silent = true})
--map('n', '<c-t>', function()
--    if vim.g.pre_buffer then
--        vim.cmd("buffer " .. vim.g.pre_buffer)
--    else
--        print('No buf found') end
--end, {silent = true})
map('n', 'p', 'p`]', {silent = true})
map('n', '<c-t>', extra.switch_term, {silent = true})
map('t', '<c-t>', extra.switch_term, {silent = true})
map('n', '<c-m-l>', '<Cmd>vertical res +5<cr>', {silent = true})
map('n', '<c-m-h>', '<Cmd>vertical res -5<cr>', {silent = true})
map('n', '<c-m-j>', '<Cmd>horizontal res -5<cr>', {silent = true})
map('n', '<c-m-k>', '<Cmd>horizontal res +5<cr>', {silent = true})
map('n', '<leader>nd', '<Cmd>Lexplore<cr>', {silent = true})
map('n', '<leader>nf', '<Cmd>Lexplore %:p:h<cr>', {silent = true})
map('v', '<leader>p', '"_dP', {silent = true})
map('v', '<leader>d', '"_d', {silent = true})

local telescope = require('telescope.builtin')
map('n', '<leader> ', telescope.find_files, {silent = true})
map('n', '<leader>bb', telescope.buffers, {silent = true})
map('n', '<leader>dg', "<CMD>lua require('telescope.builtin').live_grep({only_sort_text = true})<CR>", {silent = true})
map('n', '<leader>fh', telescope.help_tags, {silent = true})
map('n', '<leader>gs', telescope.git_status, {silent = true})
map('n', '<leader>bg', "<CMD>lua require('telescope.builtin').live_grep({only_sort_text = true, grep_open_files = true})<CR>", {silent = true})
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
if vim.g.neovide then map('c', '<C-/>', "lua require('telescope.builtin').command_history()<CR>", {})
else map('c', '<C-_>', "lua require('telescope.builtin').command_history()<CR>", {}) end
