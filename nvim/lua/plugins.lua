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
        dependencies = { "nvim-lua/plenary.nvim" }
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
    'ahmedabdulrahman/vim-aylin',
    'folke/tokyonight.nvim',
    { 'catppuccin/nvim', priority = 100 },
    {'rose-pine/neovim', name = "rosepine"},
    'drewtempelmeyer/palenight.vim',
    'blazkowolf/gruber-darker.nvim',
    { "ellisonleao/gruvbox.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "uloco/bluloco.nvim",
       dependencies = 'rktjmp/lush.nvim',
    },
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
