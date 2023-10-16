local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' }}, -- tag = '0.1.3', },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    -- 'kdheepak/lazygit.nvim',
    'rust-lang/rust.vim',
    -- 'nvim-lualine/lualine.nvim',
    'junegunn/vim-easy-align',
    'tikhomirov/vim-glsl',
    'tpope/vim-fugitive',

    { 'bkad/CamelCaseMotion', config = function()
        vim.keymap.set('n', 'w', '<Plug>CamelCaseMotion_w', {})
        vim.keymap.set('n', 'b', '<Plug>CamelCaseMotion_b', {})
        vim.keymap.set('n', 'e', '<Plug>CamelCaseMotion_e', {})
        vim.keymap.set('n', 'ge', '<Plug>CamelCaseMotion_ge', {})
        vim.keymap.set('v', 'w', '<Plug>CamelCaseMotion_w', {})
        vim.keymap.set('v', 'b', '<Plug>CamelCaseMotion_b', {})
        vim.keymap.set('v', 'e', '<Plug>CamelCaseMotion_e', {})
        vim.keymap.set('v', 'ge', '<Plug>CamelCaseMotion_ge', {})
    end },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            gui_style = {
                fg = "NONE", -- The gui style to use for the fg highlight group.
                bg = "BOLD", -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                multiline = false, -- enable multine todo comments
                -- multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                -- multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "", -- "fg" or "bg" or empty
                keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            colors = {
                ["error"] = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                hint = { "DiagnosticHint", "#10B981" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" }
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },
        }
    },
    {'mg979/vim-visual-multi', branch = 'master', config = function()
        vim.g.VM_silent_exit = 1
        vim.cmd [[let g:VM_maps = {}]]
        vim.cmd "nmap <C-J> <Plug>(VM-Add-Cursor-Down)"
        vim.cmd "nmap <C-K> <Plug>(VM-Add-Cursor-Up)"
        vim.cmd [[let g:VM_maps["Exit"] = '<C-c>']]
    end },
    -- {
    --     'VonHeikemen/lsp-zero.nvim',
    --     branch = 'v2.x',
    --     dependencies = {
    --         -- LSP Support
    --         {'neovim/nvim-lspconfig'},             -- Required
    --         {'williamboman/mason.nvim'},           -- Optional
    --         {'williamboman/mason-lspconfig.nvim'}, -- Optional

    --         -- Autocompletion
    --         {'hrsh7th/nvim-cmp'},     -- Required
    --         {'hrsh7th/cmp-nvim-lsp'}, -- Required
    --         {'L3MON4D3/LuaSnip'},     -- Required
    --     }
    -- },
    --------------------------colorschemes-------------------------------
    'ahmedabdulrahman/vim-aylin',
    'folke/tokyonight.nvim',
    'catppuccin/nvim',
    'rose-pine/neovim',
    'drewtempelmeyer/palenight.vim',
    'blazkowolf/gruber-darker.nvim',
    { "ellisonleao/gruvbox.nvim" },
    { "EdenEast/nightfox.nvim", lazy = false },
    ---------------------------------------------------------------------
})
-- require('gruber-darker').setup {
--     bold = true,
--     invert = {
--         signs = false,
--         tabline = false,
--         visual = false,
--     },
--     italic = {
--         strings = false,
--         comments = true,
--         operators = false,
--         folds = true,
--     },
--     undercurl = true,
--     underline = true,
-- }
