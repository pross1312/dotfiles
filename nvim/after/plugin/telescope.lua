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
