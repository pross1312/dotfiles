" Simple custom Vim colorscheme
" Save as: colors/simple_theme.vim

let g:colors_name  = "simple_theme"
let s:keyword      = "#5d8cd7"
let s:foreground   = "#eaeaea"
let s:background   = "#101010"
let s:strings      = "#51cf66"
let s:numbers      = "#51a5cf"
let s:comments     = "#868e96"
let s:line_number  = "#535b63"

let s:visual       = "#095277"
let s:visual_text  = "#eaeaea"

let s:visual_inv       = "#d08065"
let s:visual_text_inv  = "#121212"

let s:pmenu         = "#323232"
let s:pmenu_text    = "#eaeaea"

let s:pmenu_selected = "#119f94"
let s:pmenu_text_selected = s:background

let s:added = "#32cd32"
let s:changed = "#3299cd"
let s:removed  = "#cd3532"

let s:tabline = "#323232"
let s:tabline_sel = "#119f94"

" let s:visual_text  = s:foreground
" let s:visual_text_inv  = s:background

let s:default_str = ''

hi! clear
if exists("syntax_on")
  syntax reset
endif

function s:hlink(...)
    let A = a:1
    let B = a:2
    exec "hi! clear ".A
    exec "hi! link ".A" ".B
endfunction

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
    silent! exec join(cmd, ' ')
endfunction

call s:hi('Pmenu', s:pmenu_text, s:pmenu, '')
call s:hi('PmenuSel', s:pmenu_text_selected, s:pmenu_selected, 'bold')
call s:hi('Todo', s:keyword, '', 'bold')
call s:hi('WinBar', s:foreground, s:background, '')
call s:hi('WinBarNc', s:foreground, s:background, 'bold')
call s:hi('CursorLine', '', '')
call s:hi('Normal', s:foreground)
call s:hi('Keyword', s:keyword, '', 'bold')
call s:hi('String', s:strings)
call s:hi('Number', s:numbers)
call s:hi('Comment', s:comments)
call s:hi('Cursor', s:background, s:foreground)
call s:hi('Visual', s:visual_text, s:visual)
call s:hi('CurSearch', s:visual_text_inv, s:visual_inv, 'bold')
call s:hi('CursorLineNr', s:foreground, '', '')
call s:hi('LineNr', s:line_number)
call s:hi('Added', s:added)
call s:hi('Changed', s:changed)
call s:hi('Removed', s:removed)
call s:hi('TabLine', '', s:tabline, '')
call s:hi('TabLineSel', s:background, s:tabline_sel, 'bold')
call s:hi('TabLineFill')
call s:hi('Title', '', '', 'bold')
call s:hi('ModeMsg', s:strings)

call s:hlink('DiffAdd',         'Added')
call s:hlink('Directory',       'Keyword')
call s:hlink('DiffChange',      'Changed')
call s:hlink('DiffDelete',      'Removed')
call s:hlink('EndOfBuffer',     'LineNr')
call s:hlink('rustFunction',    'Function')
call s:hlink('StatusLine',      'WinBar')
call s:hlink('StatusLineNc',    'WinBarNc')
call s:hlink('Function',        'Normal')
call s:hlink('Identifier',      'Normal')
call s:hlink('Operator',        'Normal')
call s:hlink('Statement',       'Keyword')
call s:hlink('Type',            'Keyword')
call s:hlink('Constant',        'Keyword')
call s:hlink('Special',         'Keyword')
call s:hlink('PreProc',         'Keyword')
call s:hlink('Search',          'Visual')

call s:hi('TelescopeSelection')
call s:hi('TelescopeMatching', s:keyword)
call s:hlink('TelescopeSelectionCaret', 'TelescopeMatching')
call s:hlink('TelescopeNormal', 'Normal')
call s:hlink('TelescopeBorder', 'Normal')
" call s:hi('TelescopeResultsClass', s:visual_text, s:visual, 'bold')
" call s:hi('TelescopeResultsVariable', s:visual_text, s:visual, 'bold')
" hi link TelescopeTitle
" hi link TelescopePromptNormal
" hi link TelescopePromptBorder
" hi link TelescopeSelectionCaret
