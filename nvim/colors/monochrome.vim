" Vim color scheme
"
" Name:       monochrome.vim
" Maintainer: Xavier Noria <fxn@hashref.com>
" License:    MIT

set background=dark

hi clear
if exists('syntax_on')
   syntax reset
endif

let g:colors_name = 'monochrome'

" let s:keyword  = ['White', 15]
" let s:black  = ['#0e1111', 16]
" let s:bgray  = ['#181818', 233]
" let s:lgray  = ['LightGray', 255]
" let s:cgray  = ['#737373', 243]
" let s:dgray  = ['DarkGray', 248]
" let s:sblue  = ['#778899', 67]
" let s:yellow = ['Yellow', 226]
" let s:red    = ['#b6403a', 160]
" let s:green  = ['#478226', 28]

let s:keyword  = ['#F2E342', 15]  "key words
let s:dimgray  = ['#222222', 15]
let s:dimblue  = ['#9E775E', 15]
let s:white    = ['#eeeeee', 15]
let s:black    = ['#151515', 10]
let s:bgray    = ['#181818', 233]
let s:lgray    = ['LightGray', 255]
let s:cgray    = ['#636363', 243]
let s:dgray    = ['DarkGray', 248]
let s:sblue    = ['#4ED947', 67]  "Text in between quote
let s:yellow   = ['#0e1111', 226]
let s:red      = ['#FF632E', 20]
let s:lightRed = ['LightRed', 160]
let s:green    = ['#478226', 28]
let s:gruber_darker_visual = '#453d41'

let s:gruber_darker_number = ['#9e95c7', 28]
let s:gruber_darker_function = ['#96a6c8', 20]
let s:default_fg = s:white
let s:default_bg = s:black

let s:italic    = 'italic'
let s:bold      = 'bold'
let s:underline = 'underline'
let s:none      = 'NONE'

let s:default_lst = []
let s:default_str = ''

if !exists("g:monochrome_italic_comments")
  let g:monochrome_italic_comments = 0
endif
let s:comment_attr = g:monochrome_italic_comments ? s:italic : s:none

function! s:hi(...)
    let group = a:1
    let fg    = get(a:, 2, s:default_fg)
    let bg    = get(a:, 3, s:default_bg)
    " let bg    = get(a:, 3, s:black)
    " let bg    = get(a:, 3, s:default_bg)
    let attr  = get(a:, 4, s:default_str)

    let cmd = ['hi', group]
    if fg != s:default_lst
        call add(cmd, 'guifg='.fg[0])
        call add(cmd, 'ctermfg='.fg[1])
    endif

    if bg != s:default_lst
        call add(cmd, 'guibg='.bg[0])
        call add(cmd, 'ctermbg='.bg[1])
    endif

    if attr != s:default_str
        call add(cmd, 'gui='.attr)
        call add(cmd, 'cterm='.attr)
    endif
    exec join(cmd, ' ')
endfunction


"
" --- Vim interface ------------------------------------------------------------
"
call s:hi('Normal')
call s:hi('Cursor', s:black, s:lgray)
call s:hi('CursorLine', s:default_lst, s:bgray, s:none)
call s:hi('CursorLineNr', s:keyword, s:default_bg, s:bold)
call s:hi('ColorColumn', s:default_fg, s:bgray)
call s:hi('Search', s:dimgray, s:dimblue)
hi! Visual guibg=#453d41
call s:hi('ErrorMsg', s:keyword, s:red)

" Tildes at the bottom of a buffer, etc.
call s:hi('NonText', s:dgray)

" Folding.
call s:hi('FoldColumn', s:dgray)
call s:hi('Folded')

" Line numbers gutter.
call s:hi('LineNr', s:gruber_darker_number)

" Small arrow used for tabs.
call s:hi('SpecialKey', s:sblue, s:default_bg, s:bold)

" File browsers.
call s:hi('Directory', s:keyword, s:default_bg, s:bold)

" Help.
call s:hi('helpSpecial')
call s:hi('helpHyperTextJump', s:sblue, s:default_bg, s:underline)
call s:hi('helpNote')

" Popup menu. " use from gruber-darker
call s:hi('Pmenu', ['#e4e4e4', 20], ['#282828', 16])
call s:hi('PmenuSel', ['#e4e4e4', 20], ['#453d41', 16])
" Notes.
call s:hi('Todo', s:red, s:yellow, s:bold)

" Signs.
call s:hi('SignColumn')

"
" --- Programming languages ----------------------------------------------------
"

call s:hi('Statement', s:keyword, s:default_bg, s:bold)
call s:hi('PreProc', s:keyword, s:default_bg, s:bold)
call s:hi('String', s:sblue)
call s:hi('Comment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('Constant', s:gruber_darker_number, s:default_bg)
call s:hi('Type', s:keyword, s:default_bg, s:bold)
call s:hi('Function', s:gruber_darker_function)
call s:hi('Identifier')

" from gruber-darker
hi Special guifg=#ffdd33 gui=bold

" call s:hi('MatchParen', s:lgray, s:black, s:underline)
call s:hi('MatchParen', s:red, s:default_bg, s:bold)
" hi! MatchParen guifg=#FF632E gui=bold guibg=#0e1111

"
" --- VimL ---------------------------------------------------------------------
"

call s:hi('vimOption')
call s:hi('vimGroup')
call s:hi('vimHiClear')
call s:hi('vimHiGroup')
call s:hi('vimHiAttrib')
call s:hi('vimHiGui')
call s:hi('vimHiGuiFgBg')
call s:hi('vimHiCTerm')
call s:hi('vimHiCTermFgBg')
call s:hi('vimSynType')
hi link vimCommentTitle Comment


"
" --- Ruby ---------------------------------------------------------------------
"

call s:hi('rubyConstant')
call s:hi('rubySharpBang', s:cgray)
call s:hi('rubySymbol', s:sblue)
call s:hi('rubyStringDelimiter', s:sblue)
call s:hi('rubyStringEscape', s:sblue)
call s:hi('rubyRegexpEscape', s:sblue)
call s:hi('rubyRegexpAnchor', s:sblue)
call s:hi('rubyRegexpSpecial', s:sblue)


"
" --- Elixir -------------------------------------------------------------------
"

call s:hi('elixirAlias', s:default_fg, s:default_bg, s:none)
call s:hi('elixirDelimiter', s:sblue)
call s:hi('elixirSelf', s:default_fg, s:default_bg, s:none)

" For ||, ->, etc.
call s:hi('elixirOperator')

" Module attributes like @doc or @type.
hi link elixirVariable Statement

" While rendered as comments in other languages, docstrings are strings,
" experimental.
hi link elixirDocString String
hi link elixirDocTest String
hi link elixirStringDelimiter String


"
" --- Perl ---------------------------------------------------------------------
"

call s:hi('perlSharpBang', s:cgray)
call s:hi('perlStringStartEnd', s:sblue)
call s:hi('perlStringEscape', s:sblue)
call s:hi('perlMatchStartEnd', s:sblue)


"
" --- Python -------------------------------------------------------------------
"

call s:hi('pythonEscape', s:sblue)


"
" --- JavaScript ---------------------------------------------------------------
"

call s:hi('javaScriptFunction', s:keyword, s:default_bg, s:bold)


"
" --- Diffs --------------------------------------------------------------------
"

call s:hi('diffFile', s:cgray)
call s:hi('diffNewFile', s:cgray)
call s:hi('diffIndexLine', s:cgray)
call s:hi('diffLine', s:cgray)
call s:hi('diffSubname', s:cgray)
call s:hi('diffAdded', s:keyword, s:green)
call s:hi('diffRemoved', s:keyword, s:red)


"
" --- Markdown -----------------------------------------------------------------
"

call s:hi('Title', s:keyword, s:default_bg, s:bold)
call s:hi('markdownHeadingDelimiter', s:keyword, s:default_bg, s:bold)
call s:hi('markdownHeadingRule', s:keyword, s:default_bg, s:bold)
call s:hi('markdownLinkText', s:sblue, s:default_bg, s:underline)


"
" --- vim-fugitive -------------------------------------------------------------
"

call s:hi('gitcommitComment', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitOnBranch', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitBranch', s:sblue, s:default_bg, s:none)
call s:hi('gitcommitHeader', s:keyword, s:default_bg, s:bold)
call s:hi('gitcommitSelected', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitDiscarded', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitSelectedType', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitDiscardedType', s:default_fg, s:default_bg, s:none)


"
" --- NeoMake ------------------------------------------------------------------
"

call s:hi('NeomakeMessageSign')
call s:hi('NeomakeWarningSign', s:sblue)
call s:hi('NeomakeErrorSign', s:red)
call s:hi('NeomakeInfoSign')
call s:hi('NeomakeError', s:red)
call s:hi('NeomakeInfo', s:default_fg, s:default_bg, s:bold)
call s:hi('NeomakeMessage')
call s:hi('NeomakeWarning', s:lightRed)
