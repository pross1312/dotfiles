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
        lazy = true,
    },
    {'mg979/vim-visual-multi', branch = 'master', lazy = false, priority = 101, config = function()
        vim.g.VM_silent_exit = 1
        vim.cmd [[let g:VM_maps = {}]]
        vim.cmd "nmap <M-n> <Plug>(VM-Add-Cursor-Down)"
        vim.cmd "nmap <M-p> <Plug>(VM-Add-Cursor-Up)"
        vim.cmd [[let g:VM_maps['Exit'] = '<C-c>']]
        vim.cmd [[let g:VM_Mono_hl   = 'MyMultiCursor']]
    end },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    },
    --------------------------colorschemes-------------------------------
    'folke/tokyonight.nvim',
    { 'catppuccin/nvim', priority = 100 },
    {'rose-pine/neovim', name = "rosepine"},
    'drewtempelmeyer/palenight.vim',
    { 'blazkowolf/gruber-darker.nvim',
        opts = {
            bold = true,
            invert = {
                signs = false,
                tabline = false,
                visual = false,
            },
            italic = {
                strings = false,
                comments = true,
                operators = false,
                folds = false,
            },
            undercurl = true,
            underline = true,
            highlights = {
                TelescopeNormal = {bg = "NONE"},
                Normal = {bg = "NONE"}
            }
        },
        config = function()
        end
    },
    { "ellisonleao/gruvbox.nvim" },
    { "EdenEast/nightfox.nvim" },
    {"adisen99/codeschool.nvim", dependencies = {"rktjmp/lush.nvim"}},
    {"polirritmico/monokai-nightasty.nvim", config=function()
        require("monokai-nightasty").setup({
            dark_style_background = "transparent", -- default, dark, transparent, #color
            light_style_background = "default", -- default, dark, transparent, #color
            terminal_colors = true, -- Set the colors used when opening a `:terminal`
            color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
            hl_styles = {
                -- Style to be applied to different syntax groups. See `:help nvim_set_hl`
                comments = { italic = false },
                keywords = { italic = false },
                functions = {},
                variables = {},
                -- Background styles for sidebars (panels) and floating windows:
                floats = "transparent", -- default, dark, transparent
                sidebars = "transparent", -- default, dark, transparent
            },
            -- sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`

            hide_inactive_statusline = false, -- Hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false, -- dims inactive windows
            lualine_bold = false, -- Lualine headers will be bold or regular.
            lualine_style = "default", -- "dark", "light" or "default" (Follows dark/light style)

            --- You can override specific color/highlights. Current values in `extras/palettes`

            ---@param colors ColorScheme
            on_colors = function(colors)
                -- colors.border = colors.grey
                -- colors.comment = "#2d7e79"
            end,

            ---@param highlights Highlights
            -- TODO: jqwoiejoiwq
            -- NOTE:
            -- FIXME:
            ---@param colors ColorScheme
            on_highlights = function(highlights, colors)
                -- highlights.TelescopeNormal = { fg = colors.magenta, bg = colors.charcoal }
                highlights.WinSeparator = { fg = colors.grey }
            end,
        })
    end},
    ---------------------------------------------------------------------
})
