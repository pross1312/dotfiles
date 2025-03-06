" Vim color scheme based on Alacritty config
set background=dark
hi! clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "termlike"

" Define colors
let s:foreground = "#c5c8c6"
let s:background = "#1d1f21"

let s:black = "#282a2e"
let s:red = "#a54242"
let s:green = "#8c9440"
let s:yellow = "#de935f"
let s:blue = "#5f819d"
let s:magenta = "#85678f"
let s:cyan = "#5e8d87"
let s:white = "#707880"

let s:bright_black = "#373b41"
let s:bright_red = "#cc6666"
let s:bright_green = "#b5bd68"
let s:bright_yellow = "#f0c674"
let s:bright_blue = "#81a2be"
let s:bright_magenta = "#b294bb"
let s:bright_cyan = "#8abeb7"
let s:bright_white = "#c5c8c6"
let s:default_str = ''

function s:hi(...)
    let group = a:1
    let fg    = get(a:, 2, s:foreground)
    let bg    = get(a:, 3, s:background)
    let attr  = get(a:, 4, s:default_str)

    exec "hi! clear ".group
    let cmd = ['hi!', group]
    if fg != s:default_str
        call add(cmd, 'guifg='.fg)
    endif

    if bg != s:default_str
        call add(cmd, 'guibg='.bg)
    endif

    if attr != s:default_str
        call add(cmd, 'gui='.attr)
        call add(cmd, 'cterm='.attr)
    endif
    exec join(cmd, ' ')
endfunction

" Set terminal colors
let g:terminal_ansi_colors = [
    \ s:black, s:red, s:green, s:yellow,
    \ s:blue, s:magenta, s:cyan, s:white,
    \ s:bright_black, s:bright_red, s:bright_green, s:bright_yellow,
    \ s:bright_blue, s:bright_magenta, s:bright_cyan, s:bright_white
\ ]

" TODO: Basic highlighting
call s:hi('Normal')
call s:hi('Comment', s:yellow)
call s:hi('Constant', s:cyan)
call s:hi('Identifier', s:blue)
call s:hi('Statement', s:red,)
call s:hi('PreProc', s:bright_yellow,)
call s:hi('Type', s:red,)
call s:hi('Underlined', s:bright_blue, '','underline')
call s:hi('Error', s:bright_white, s:red)
call s:hi('Todo', s:yellow, s:bright_black, 'bold')

hi! link Function Identifier
hi! link Special Statement
