vim.cmd.syntax 'on'
vim.cmd.filetype 'plugin indent on'
vim.o.background           = 'dark'
vim.o.encoding             = 'utf-8'
vim.o.ruler                = true
vim.o.number               = true
vim.o.relativenumber       = true
vim.o.incsearch            = true
vim.o.autoindent           = true
vim.o.ruler                = true
vim.o.autowrite            = true
vim.o.linebreak            = true
vim.o.et                   = true
vim.o.title                = true
vim.o.wildoptions          = 'pum,fuzzy'
vim.o.wildmode             = 'longest,full'
vim.o.wildmenu             = true
vim.o.history              = 50
vim.o.tabstop              = 4
vim.o.softtabstop          = 4
vim.o.shiftwidth           = 4
vim.o.matchtime            = 2
vim.o.sw                   = 4
vim.o.mouse                = 'a'
vim.o.backspace            = 'indent,eol,start'
vim.o.visualbell           = false
vim.o.belloff              = 'all'
vim.o.smartindent          = true
vim.o.autoindent           = true
vim.o.smarttab             = true
vim.o.spell                = false
vim.o.showmode             = true
vim.o.ignorecase           = true
vim.o.smartcase            = true
vim.o.termguicolors        = true
vim.o.list                 = true
vim.o.splitright           = true
vim.o.cursorline           = true
vim.o.cmdheight            = 1
vim.opt.listchars['trail'] = '·'
vim.opt.listchars          = "tab:  ,trail:·,nbsp:+"
vim.opt.hlsearch           = true
vim.g.scrolloff            = { -- save to fix weird bug in switch term
    h = 8,
    w = 15,
}
vim.opt.scrolloff          = vim.g.scrolloff.h
vim.opt.sidescrolloff      = vim.g.scrolloff.w
vim.opt.signcolumn         = "yes"
vim.o.laststatus           = 0
vim.cmd "set statusline=%{repeat('─',winwidth('.'))}"
vim.o.wrap                 = false
vim.opt.matchpairs:append '<:>'
vim.opt.isfname:append("@-@")
vim.opt.sessionoptions = "blank,buffers,folds,help,tabpages,winsize,winpos,terminal,localoptions,options"
-- vim.opt.updatetime = 50
-- vim.opt.iskeyword = "@,48-57,192-255"

vim.g.mapleader             = ' '
vim.g.netrw_winsize         = 20
vim.g.netrw_banner          = 0
vim.g.netrw_keepdir         = 1
vim.g.netrw_browse_split    = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.rustfmt_fail_silently = 1

vim.cmd "set undofile"

