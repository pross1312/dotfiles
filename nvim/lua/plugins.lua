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
    {'kdheepak/lazygit.nvim', config = function()
        vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
        vim.g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
        vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- customize lazygit popup window border characters
        vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
        vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

        vim.g.lazygit_use_custom_config_file_path = 1 -- config file path is evaluated if this value is 1
        vim.g.lazygit_config_file_path = vim.fn.expand("$HOME/dotfiles/lazygit.yml") -- custom config file path
        vim.api.nvim_create_user_command('G', function()
            vim.cmd "LazyGit"
        end, {bang = true, bar = true})
        -- OR
        -- vim.g.lazygit_config_file_path = {} -- table of custom config file paths
    end
    },
    'rust-lang/rust.vim',
    -- 'nvim-lualine/lualine.nvim',
    'junegunn/vim-easy-align',
    'tikhomirov/vim-glsl',
    -- 'tpope/vim-fugitive',

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
    {'navarasu/onedark.nvim', opts = {
        -- -- Main options --
        style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        -- transparent = false,  -- Show/hide background
        -- term_colors = true, -- Change terminal color as per the selected theme style
        -- ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
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
