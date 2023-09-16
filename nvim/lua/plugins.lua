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
    { "ellisonleao/gruvbox.nvim", priority = 1000 }
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
