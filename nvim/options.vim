let g:ftplugin_sql_omni_key = '<C-1>'
syntax on
filetype plugin indent on
set ruler
set number
set relativenumber
set incsearch
set autoindent
set ruler
set autowrite
set linebreak
set et
set title
set wildmenu
set smartindent
set autoindent
set smarttab
set showmode
set ignorecase
set smartcase
set termguicolors
set list
set splitright
set cursorline
set shortmess=aoOtTWIcF
set report=10000
set history=50
set tabstop=4
set softtabstop=4
set shiftwidth=4
set matchtime=2
set sw=4
set novisualbell
set nowrap
set nospell
set cmdheight=1
set hlsearch
set scrolloff=8
set sidescrolloff=15
set laststatus=0
set encoding=utf-8
set wildoptions=pum,fuzzy
set wildmode=longest,full
set mouse=a
set backspace=indent,eol,start
set belloff=all
set listchars=tab:\ \ ,trail:·,nbsp:+
set signcolumn=no
set statusline=%{repeat('─',winwidth('.'))}
set matchpairs+=<:>
set isfname+=@-@
set sessionoptions=blank,buffers,folds,help,tabpages,winsize,winpos,terminal,localoptions,options,curdir
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
""" set updatetime=50
""" vim.opt.iskeyword = "@,48-57,192-255"
let g:mapleader=' '
let g:netrw_winsize=20
let g:netrw_banner=0
let g:netrw_keepdir=1
let g:netrw_browse_split=0
let g:netrw_localcopydircmd='cp -r'
let g:rustfmt_fail_silently=1
let g:netrw_list_hide='.*\\.swp$,node_modules/,.git/'
set undofile
if has('win32') || has('win64')
    set shell=powershell
endif
function! SetColor(name)
    set background=dark
    execute 'colorscheme ' . a:name
    hi! clear WinSeparator
    hi! link WinSeparator normal
    hi! link StatusLine WinSeperator
    hi! link StatusLineNC normal
    hi! clear CursorLine
    """ hi! MatchParen guifg=#ff0000 guibg=none
    hi! clear Cursor
    hi! Cursor guibg=#ffffff guifg=#000000
    hi! clear TermCursor
    hi! link TermCursor Cursor
    hi! TermCursorNC guifg=#1c1917 guibg=#797f84
    """ hi Normal guifg=#ffffff
    hi! link VM_Mono Cursor
    hi! TodoFgTODO guifg=#8a8a8
    hi! TodoFgNOTE guifg=#8a8a8
    hi! TodoFgFIX guifg=#8a8a8
    hi! TodoBgTODO guibg=#BF0606 guifg=#560303 gui=bold
    hi! TodoBgNOTE guibg=#BF0606 guifg=#560303 gui=bold
    hi! TodoBgFIX guibg=#BF0606 guifg=#560303 gui=bold
    """ neogit
    """ hi! NeogitCursorLine guibg=NONE
    """ hi! NeogitDiffAddHighlight guibg=NONE
    """ hi! link NeogitDiffAdd NeogitDiffAddHighlight
    """ hi! link NeogitDiffAddRegion NeogitDiffAdd

    """ hi! NeogitDiffDeleteHighlight guifg=#bc4650 guibg=NONE
    """ hi! link NeogitDiffDelete NeogitDiffDeleteHighlight
    """ hi! link NeogitDiffDeleteRegion NeogitDiffDelete
    """ hi! NeogitHunkHeader guibg=NONE guifg=#09867D gui=bold,italic
    """ hi! link NeogitHunkHeaderHighlight NeogitHunkHeader
    """ hi! NeogitDiffContext guibg=NONE
    """ hi! NeogitDiffContextHighlight guibg=NONE
    """ terminal config
    let g:terminal_color_0 = '#7D8EB0'
    let g:terminal_color_1 = '#f7768e'
    let g:terminal_color_2 = '#9ece6a'
    let g:terminal_color_3 = '#e0af68'
    let g:terminal_color_4 = '#7aa2f7'
    let g:terminal_color_5 = '#bb9af7'
    let g:terminal_color_6 = '#7dcfff'
    let g:terminal_color_7 = '#a9b1d6'
    let g:terminal_color_8 = '#7D8EB0'
    let g:terminal_color_9 = '#f7768e'
    let g:terminal_color_10 = '#9ece6a'
    let g:terminal_color_11 = '#e0af68'
    let g:terminal_color_12 = '#7aa2f7'
    let g:terminal_color_13 = '#bb9af7'
    let g:terminal_color_14 = '#7dcfff'
    let g:terminal_color_15 = '#c0caf5'
    hi! link NvimTreeWinSeparator WinSeperator
    hi! link NvimTreeNormal Normal
    hi! link NvimTreeCursorLine CursorLine
    hi! link NvimTreeCursorLineNr CursorLineNr
    hi! link NvimTreeEndOfBuffer NvimTreeNormal
endfunction

nnoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
inoremap <C-c> <Esc>

" Go to definition in a new window with Ctrl-]
nnoremap <C-]> g<C-]>

" Show file name with Ctrl-G
nnoremap <C-G> 1<C-G>

" Window navigation with Alt + hjkl
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

nnoremap <C-L> <Cmd>nohlsearch<CR>

" Switch to the previous file with Ctrl-S
nnoremap <C-s> <C-^>

" Insert mode Ctrl-R behavior
inoremap <C-r> <C-r><C-o>

" Jump to end after pasting text
nnoremap p p`]

" Resize splits with Ctrl-M + Arrow keys
nnoremap <C-M-l> <Cmd>vertical res +5<CR>
nnoremap <C-M-h> <Cmd>vertical res -5<CR>
nnoremap <C-M-j> <Cmd>horizontal res -5<CR>
nnoremap <C-M-k> <Cmd>horizontal res +5<CR>

" Navigate quickfix list with Ctrl-J and Ctrl-K
nnoremap <C-k> <Cmd>cp<CR>
nnoremap <C-j> <Cmd>cn<CR>

" Command mode key mappings
set cedit=<C-O>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-k> <C-O>D<C-C>

" Tab switching with Alt + numbers (1-9)
for i in range(1, 9)
    execute 'nnoremap <M-' . i . '> ' . i . 'gt'
    execute 'tnoremap <M-' . i . '> <C-\><C-n>' . i . 'gti'
    execute 'inoremap <M-' . i . '> <Esc>' . i . 'gt'
endfor

" Terminal mode window navigation with Alt + hjkl
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l

" Open a new terminal split with Alt-S and Alt-V
tnoremap <M-s> <C-\><C-n><cmd>split \| term<CR>i
tnoremap <M-v> <C-\><C-n><cmd>vertical split \| term<CR>i
