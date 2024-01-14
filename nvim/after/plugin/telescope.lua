require('telescope').setup({
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
        dynamic_preview_title = true,
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
        },
        prompt_prefix = "> ",
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
        file_ignore_patterns = {"node_modules"},
        buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker,
        mappings = {
            i = {},
            n = {}
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true
            }
        },
    },
})
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<M- >', builtin.find_files, {silent = true})
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

