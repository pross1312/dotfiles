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
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", lazy = true},
    -- {
    --     "NeogitOrg/neogit",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",         -- required
    --         -- "sindrets/diffview.nvim",        -- optional - Diff integration

    --         -- Only one of these is needed, not both.
    --         "nvim-telescope/telescope.nvim", -- optional
    --     },
    --     config = function()
    --         require("neogit").setup({})
    --         vim.api.nvim_create_user_command('Git', function()
    --             vim.cmd "Neogit kind=replace"
    --         end, {bang = true, bar = true})
    --     end
    -- },
    -- {'kdheepak/lazygit.nvim', config = function()
    --     vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
    --     vim.g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
    --     vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- customize lazygit popup window border characters
    --     vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
    --     vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

    --     vim.g.lazygit_use_custom_config_file_path = 1 -- config file path is evaluated if this value is 1
    --     vim.g.lazygit_config_file_path = vim.fn.expand("$HOME/dotfiles/lazygit.yml") -- custom config file path
    --     vim.api.nvim_create_user_command('G', function()
    --         vim.cmd "LazyGit"
    --     end, {bang = true, bar = true})
    --     -- OR
    --     -- vim.g.lazygit_config_file_path = {} -- table of custom config file paths
    -- end
    -- },
    -- 'nvim-lualine/lualine.nvim',
    {'junegunn/vim-easy-align', lazy = false},
    {'tikhomirov/vim-glsl', lazy = false},
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
        lazy = false,
    },
    {'mg979/vim-visual-multi', branch = 'master', config = function()
        vim.g.VM_silent_exit = 1
        -- vim.cmd [[let g:VM_maps = {}]]
        -- vim.cmd [[let g:VM_maps["Exit"] = '<C-C>']]
        vim.cmd "nmap <C-C> <Plug>(VM-Exit)"
        vim.cmd "nmap <M-n> <Plug>(VM-Add-Cursor-Down)"
        vim.cmd "nmap <M-p> <Plug>(VM-Add-Cursor-Up)"
        vim.cmd [[hi! link VM_Mono   MyMultiCursor ]]
        -- vim.cmd [[let g:VM_Mono_hl   = 'MyMultiCursor']]
    end },
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = true,
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
    {'folke/tokyonight.nvim', lazy = false},
    { 'catppuccin/nvim', lazy = false },
    {'rose-pine/neovim', name = "rosepine", lazy = false},
    {'drewtempelmeyer/palenight.vim', lazy = false},
    -- Or with configuration
    {
        'projekt0n/github-nvim-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        config = function()
        end,
    },
    {'navarasu/onedark.nvim', lazy = true, opts = {
        -- -- Main options --
        style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = false,  -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        -- ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
        -- cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- -- toggle theme style ---
        -- toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        -- toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

        -- -- Change code style ---
        -- -- Options are italic, bold, underline, none
        -- -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        -- code_style = {
        --     comments = 'italic',
        --     keywords = 'none',
        --     functions = 'none',
        --     strings = 'none',
        --     variables = 'none'
        -- },

        -- -- Lualine options --
        -- lualine = {
        --     transparent = false, -- lualine center bar transparency
        -- },

        -- -- Custom Highlights --
        -- colors = {}, -- Override default colors
        -- highlights = {}, -- Override highlight groups

        -- -- Plugins Config --
        -- diagnostics = {
        --     darker = true, -- darker colors for diagnostic
        --     undercurl = true,   -- use undercurl instead of underline for diagnostics
        --     background = true,    -- use background color for virtual text
        -- },
    }},
    { 'blazkowolf/gruber-darker.nvim', lazy = false,
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
    { "ellisonleao/gruvbox.nvim", lazy = false},
    { "EdenEast/nightfox.nvim", lazy = false },
    {"adisen99/codeschool.nvim", lazy = false, dependencies = {"rktjmp/lush.nvim"}, config = function()
        vim.cmd "hi Normal guifg=#efefef"
        vim.cmd "hi clear SignColumn"
        vim.cmd "hi CursorLineNr guibg=NONE"
        vim.g.codeschool_contrast_dark = "hard"
    end},
    {"polirritmico/monokai-nightasty.nvim", lazy = true, config=function()
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
    {'ramojus/mellifluous.nvim', lazy = true, config = function()
        require 'mellifluous'.setup({
            mellifluous = {
                neutral = true, -- set this to false and bg_contrast to 'medium' for original mellifluous (then it was called meliora theme)
                bg_contrast = 'soft' -- options: 'soft', 'medium', 'hard'
            },
            dim_inactive = false,
            color_set = 'tender',
            styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
                comments = { italic = true },
                conditionals = {},
                folds = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = { bold = false},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
                markup = {
                    headings = { bold = true },
                },
            },
        })
    end},
    ---------------------------------------------------------------------
})
