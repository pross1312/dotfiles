require('telescope').setup({
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = 0.7,
            height = 0.95,
            width = 0.95,
        },
        preview = {
            timeout = 30,
            filesize_limit = 5,
            treesitter = false,
        },
        path_display = {'shorten'},
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
