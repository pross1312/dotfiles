" dark_visual_studio.vim

hi! clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "vsdark"
set background=dark

" =========================
" Palette
" =========================

let s:none        = ''
let s:bg          = '#1E1E1E'
let s:bg_alt      = '#252526'
let s:border      = '#303031'

let s:fg          = '#D4D4D4'
let s:fg_dim      = '#808080'
let s:fg_line     = '#858585'
let s:fg_line_cur = '#C6C6C6'

let s:blue        = '#569CD6'
let s:light_blue  = '#9CDCFE'
let s:yellow      = '#DCDCAA'
let s:orange      = '#CE9178'
let s:red         = '#D16969'
let s:green       = '#6A9955'
let s:number      = '#B5CEA8'
let s:darkgray    = '#4F5258'

let s:error       = '#F44747'
let s:warn        = '#CCA700'
let s:info        = s:blue
let s:hint        = s:green

let s:visual      = '#264F78'

let s:search      = '#613214'
let s:incsearch   = '#515C6A'

let s:pmenu_sel   = '#0078D4'
let s:title       = '#D7BA7D'

let s:added = "#32cd32"
let s:changed = "#3299cd"
let s:removed  = "#cd3532"

" =========================
" Helpers
" =========================

function! s:hlink(from, to) abort
    execute 'hi! clear ' . a:from
    execute 'hi! link ' . a:from . ' ' . a:to
endfunction

function! s:hi(group, ...) abort
    let l:fg   = get(a:, 1, s:none)
    let l:bg   = get(a:, 2, s:none)
    let l:attr = get(a:, 3, s:none)

    execute 'hi! clear ' . a:group

    let l:cmd = ['hi!', a:group]

    if l:fg !=# s:none
        call add(l:cmd, 'guifg=' . l:fg)
    endif

    if l:bg !=# s:none
        call add(l:cmd, 'guibg=' . l:bg)
    endif

    if l:attr !=# s:none
        call add(l:cmd, 'gui=' . l:attr)
        " call add(l:cmd, 'cterm=' . l:attr)
    endif

    execute join(l:cmd, ' ')
endfunction

" =========================
" UI
" =========================

call s:hi('Normal',        s:fg, s:bg)

call s:hi('CursorLine',    s:none, s:bg_alt)
call s:hlink('CursorColumn', 'CursorLine')
call s:hlink('ColorColumn',  'CursorLine')

call s:hi('LineNr',        s:fg_line, s:bg)
call s:hi('CursorLineNr',  s:fg_line_cur, s:bg)

call s:hi('VertSplit',     s:border, s:bg)
call s:hlink('WinSeparator', 'VertSplit')

call s:hi('StatusLine',    s:fg, s:bg_alt)
call s:hi('StatusLineNC',  s:fg_dim, s:bg_alt)

call s:hi('Visual',        s:none, s:visual)

call s:hi('Search',        '#FFFFFF', s:search)
call s:hi('IncSearch',     '#FFFFFF', s:incsearch)
call s:hlink('CurSearch', 'IncSearch')

call s:hi('MatchParen',    '#FFFFFF', s:incsearch)

call s:hi('NonText', s:darkgray)

" =========================
" Popup Menu
" =========================

call s:hi('Pmenu',         '#CCCCCC', s:bg_alt)
call s:hi('PmenuSel',      '#FFFFFF', s:pmenu_sel)
call s:hi('PmenuSbar',     s:none, '#383838')
call s:hi('PmenuThumb',    s:none, '#707070')

" =========================
" Syntax
" =========================

call s:hi('Comment',       s:green, s:none, 'italic')

call s:hi('Constant',      s:blue)
call s:hi('String',        s:orange)
call s:hlink('Character',  'String')

call s:hi('Number',        s:number)
call s:hlink('Float',      'Number')

call s:hi('Boolean',       s:blue)

call s:hi('Identifier',    s:light_blue)
call s:hi('Function',      s:yellow)

call s:hi('Keyword',       s:blue)

call s:hlink('Statement',    'Keyword')
call s:hlink('Conditional',  'Keyword')
call s:hlink('Repeat',       'Keyword')
call s:hlink('Label',        'Keyword')
call s:hlink('Exception',    'Keyword')

call s:hi('Operator',      s:fg)

call s:hlink('PreProc',      'Keyword')
call s:hlink('Include',      'Keyword')
call s:hlink('Define',       'Keyword')
call s:hlink('Macro',        'Keyword')

call s:hlink('Type',         'Keyword')
call s:hlink('StorageClass', 'Keyword')
call s:hlink('Structure',    'Keyword')
call s:hlink('Typedef',      'Keyword')

call s:hi('Special',       s:red)
call s:hlink('SpecialChar', 'Special')

call s:hi('Tag',           s:blue)
call s:hi('Delimiter',     s:fg)

call s:hi('Underlined',    s:none, s:none, 'underline')
call s:hi('Error',         s:error)
call s:hi('Todo',          '#FFFFFF', s:green, 'bold')

if has('nvim')
    " =========================
    " Treesitter
    " =========================

    call s:hlink('@comment',          'Comment')
    call s:hlink('@string',           'String')
    call s:hlink('@string.escape',    'SpecialChar')
    call s:hlink('@number',           'Number')
    call s:hlink('@boolean',          'Boolean')

    call s:hlink('@keyword',          'Keyword')
    call s:hlink('@keyword.function', 'Keyword')
    call s:hlink('@keyword.return',   'Keyword')

    call s:hlink('@operator',         'Operator')

    call s:hlink('@function',         'Function')
    call s:hlink('@function.call',    'Function')
    call s:hlink('@method',           'Function')

    call s:hlink('@variable',         'Identifier')
    call s:hlink('@property',         'Identifier')
    call s:hlink('@field',            'Identifier')
    call s:hlink('@parameter',        'Identifier')

    call s:hlink('@type',             'Type')
    call s:hlink('@type.builtin',     'Type')

    call s:hlink('@constant',         'Constant')
    call s:hlink('@constant.builtin', 'Constant')

    call s:hlink('@tag',              'Tag')
    call s:hlink('@tag.attribute',    'Identifier')

    " =========================
    " Telescope
    " =========================

    call s:hi('TelescopeNormal',        s:fg, s:bg, 'bold')
    call s:hi('TelescopeBorder',        s:border, s:bg, 'bold')

    call s:hi('TelescopePromptNormal',  s:fg)
    call s:hi('TelescopePromptBorder',  s:border)

    call s:hi('TelescopeResultsNormal', s:fg, s:bg)
    call s:hi('TelescopeResultsBorder', s:border, s:bg)

    call s:hi('TelescopePreviewNormal', s:fg, s:bg)
    call s:hi('TelescopePreviewBorder', s:border, s:bg)

    call s:hi('TelescopeSelection',     s:none, '#2A2D2E')
    call s:hi('TelescopeMatching',      s:light_blue, s:none, 'bold')

    call s:hi('TelescopePromptPrefix',  s:blue)
    call s:hi('TelescopeTitle',         s:title, s:none, 'bold')
endif

" =========================
" Diagnostics
" =========================

call s:hi('DiagnosticError', s:error)
call s:hi('DiagnosticWarn',  s:warn)
call s:hi('DiagnosticInfo',  s:info)
call s:hi('DiagnosticHint',  s:hint)

execute 'hi DiagnosticUnderlineError gui=undercurl guisp=' . s:error
execute 'hi DiagnosticUnderlineWarn  gui=undercurl guisp=' . s:warn
execute 'hi DiagnosticUnderlineInfo  gui=undercurl guisp=' . s:info
execute 'hi DiagnosticUnderlineHint  gui=undercurl guisp=' . s:hint

" =========================
" Git
" =========================

call s:hi('Added', s:added)
call s:hi('Changed', s:changed)
call s:hi('Removed', s:removed)
call s:hlink('DiffAdd',         'Added')
call s:hlink('DiffChange',      'Changed')
call s:hlink('DiffDelete',      'Removed')


