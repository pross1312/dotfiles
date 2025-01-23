syntax on
" set filetype='plugin,indent,on'
if has("gui_running")
    if has("gui_gtk")
        :set guifont=Luxi\ Mono\ 12
    elseif has("x11")
        :set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("gui_win32")
        set guioptions=
        set guifont=Spleen:h14
    endif
endif
set guicursor=n-v-c-sm:block,i-ci-ve:ver1,r-cr-o:ver1
set termguicolors
color habamax
set shortmess=aoOtTWIcF
set report=10000
set encoding=utf-8
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
set wildoptions=pum,fuzzy
set wildmode=longest,full
set wildmenu
set history=50
set tabstop=4
set softtabstop=4
set shiftwidth=4
set matchtime=2
set sw=4
set mouse=a
set backspace=indent,eol,start
set novisualbell
set belloff=all
set smartindent
set autoindent
set smarttab
set nospell
set showmode
set ignorecase
set smartcase
set termguicolors
set list
set splitright
set nocursorline
set cmdheight=1
set listchars=tab:\ \ ,trail:·,nbsp:+
set hlsearch
set scrolloff=8
set sidescrolloff=15
set signcolumn=auto
set laststatus=0
set statusline=%{repeat('─',winwidth('.'))}
set nowrap
set matchpairs+=<:>
set isfname+=("@-@")
set sessionoptions=blank,buffers,folds,help,tabpages,winsize,winpos,terminal,localoptions,options,curdir
set updatetime=50
set iskeyword=@,48-57,192-255
set undofile
set directory-=.
set backupdir-=.
set undodir-=.
set undodir=~/AppData/Local/Temp
let mapleader = " "

noremap <M-1> 1gt
noremap <M-2> 2gt
noremap <M-3> 3gt
noremap <M-4> 4gt
noremap <M-5> 5gt
noremap <M-6> 6gt
noremap <M-7> 7gt
noremap <M-8> 8gt
noremap <M-9> 9gt
noremap <M-k> <C-w>k
noremap <M-j> <C-w>j
noremap <M-h> <C-w>h
noremap <M-l> <C-w>l
noremap <C-s> <C-^>
noremap <leader>nd <Cmd>NERDTreeToggle<CR>
noremap <C-C> <Esc>
inoremap <C-C> <Esc>
vnoremap <C-C> <Esc>
cnoreabbrev mkae make

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-k> <C-F>D<C-C>
