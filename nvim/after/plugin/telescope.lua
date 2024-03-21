
if vim.fn.is_module_available('telescope') then

require('telescope').setup({
    pickers = {
        find_files = {
            hidden = true,
        }
    },
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                preview_cutoff = 80,
            },
            preview_width = 0.5,
            height = 0.95,
            width = 0.95,
        },
        preview = {
            timeout = 50,
            filesize_limit = 5,
            treesitter = false,
        },
        path_display = {'shorten', shorten = { len = 1, exclude = {-2, -1, -3} }},
        file_ignore_patterns = {"node_modules", ".git", "target", "build"},
    },
})
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<M-p>', builtin.find_files, {silent = true})
vim.keymap.set('n', '<M-b>', builtin.buffers, {silent = true})
vim.keymap.set('n', '<M-g>', function()
    builtin.live_grep({only_sort_text = true})
end, {silent = true})
vim.keymap.set('n', '<M-d>g', function()
    builtin.live_grep({only_sort_text = true, grep_open_files = true})
end, {silent = true})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>re', builtin.registers, {})
if vim.g.neovide then vim.keymap.set('c', '<C-/>', "lua require('telescope.builtin').command_history()<CR>", {})
else vim.keymap.set('c', '<C-_>', "lua require('telescope.builtin').command_history()<CR>", {}) end

end
