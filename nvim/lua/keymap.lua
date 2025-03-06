local map = vim.keymap.set

local extra = require 'extra-function'

-- jump root (start directory)
map('n', '<leader>jr', function()
                            print(vim.g.root_dir)
                            vim.cmd(string.format("cd %s", vim.g.root_dir))
                        end,
                        {silent = false})
map('n', '<leader>jc', function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 1 then
        vim.cmd(string.format("cd %s", dir))
        print(dir)
    else
        vim.api.nvim_err_writeln('No directory found')
    end
end, {})

local session_dir = vim.fn.stdpath("cache") .. "/sessions"
for i=1,9 do
    if vim.fn.isdirectory(session_dir .. i) ~= 1 then
        vim.fn.mkdir(session_dir .. i);
        session_dir = session_dir .. i
        break
    end
end

local session_file = session_dir .. "/tmpSession"
local session_swap = session_dir .. "/swapSession"
map('n', '<leader> ', string.format("<Cmd>mksession! %s<CR><Cmd>mksession! %s | only | lua require('telescope.builtin').find_files()<CR>", session_file, session_swap), {})
map('n', '<leader>b', string.format("<Cmd>mksession! %s<CR><Cmd>mksession! %s | only | lua require('telescope.builtin').buffers()<CR>", session_file, session_swap), {})
-- map('n', '<leader>l', string.format("<Cmd>mksession! %s | so %s<CR>", session_swap, session_file), {})
map('n', '<leader>s', string.format("<Cmd>mksession! %s.swp | so %s | lua vim.uv.fs_copyfile('%s.swp', '%s')<CR>", session_swap, session_swap, session_swap, session_swap), {})
vim.api.nvim_create_autocmd({"VimLeavePre"}, {
    callback = function()
        if vim.loop.os_uname().sysname ~= "Linux" then -- windows
        else
            vim.system({"rm", "-rf", session_dir}):wait()
        end
    end,
})
