" FANSI - An ANSI 16 color scheme
"
" Note: although this theme aims to be used with your terminal color palette,
"       there are a few assumptions made to make the color scheme work as
"       required. These are:
"       1. Default foreground and background colors are not in ANSI colors
"       2. 'Bright Black' (9) is significantly (>= 20%) brighter than black.
"          It's used for line numbers and other textual elements

" clear highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "fansi"

let s:colors = {
      \ 'black'   : [0, 'Black'],
      \ 'red'     : [1, 'Red'],
      \ 'green'   : [2, 'Green'],
      \ 'yellow'  : [3, 'Yellow'],
      \ 'blue'    : [4, 'Blue'],
      \ 'magenta' : [5, 'Magenta'],
      \ 'cyan'    : [6, 'Cyan'],
      \ 'grey'    : [7, 'Grey'],
      \ 'light'   : {
            \ 'black'   : [8, 'DarkGrey'],
            \ 'red'     : [9, 'LightRed'],
            \ 'green'   : [10, 'LightGreen'],
            \ 'yellow'  : [11, 'LightYellow'],
            \ 'blue'    : [12, 'LightBlue'],
            \ 'magenta' : [13, 'LightMagenta'],
            \ 'cyan'    : [14, 'LightCyan'],
            \ 'grey'    : [15, 'White'],
      \ },
      \ 'none'    : ['NONE', 'NONE'],
\ }

let s:emphasis = {
      \ 'bold'      : 'bold,',
      \ 'italic'    : 'italic,',
      \ 'none'      : 'NONE,',
      \ 'underline' : 'underline,',
\ }

function! s:HL(group, fg, ...)
  " foreground
  let fg = a:fg

  " background
  let bg = a:0 >= 1 ? a:1 : s:colors.none

  " emphasis
  let emstr = a:0 >= 2 && strlen(a:2) ? a:2 : s:emphasis.none

  let hlstr = ['hi', a:group,
        \ 'ctermfg=' . fg[0], 'guifg=' . fg[1],
        \ 'ctermbg=' . bg[0], 'guibg=' . bg[1],
        \ 'cterm=' . emstr[:-2], 'gui=' . emstr[:-2]
        \ ]

  execute join(hlstr, ' ')
endfunction

" reusable groups
call s:HL('FANSIBlack', s:colors.black)
call s:HL('FANSIRed', s:colors.red)
call s:HL('FANSIGreen', s:colors.green)
call s:HL('FANSIYellow', s:colors.yellow)
call s:HL('FANSIBlue', s:colors.blue)
call s:HL('FANSIMagenta', s:colors.magenta)
call s:HL('FANSICyan', s:colors.cyan)
call s:HL('FANSIGrey', s:colors.grey)

call s:HL('FANSIBlackBold', s:colors.black, s:colors.none, s:emphasis.bold)
call s:HL('FANSIRedBold', s:colors.red, s:colors.none, s:emphasis.bold)
call s:HL('FANSIGreenBold', s:colors.green, s:colors.none, s:emphasis.bold)
call s:HL('FANSIYellowBold', s:colors.yellow, s:colors.none, s:emphasis.bold)
call s:HL('FANSIBlueBold', s:colors.blue, s:colors.none, s:emphasis.bold)
call s:HL('FANSIMagentaBold', s:colors.magenta, s:colors.none, s:emphasis.bold)
call s:HL('FANSICyanBold', s:colors.cyan, s:colors.none, s:emphasis.bold)
call s:HL('FANSIGreyBold', s:colors.grey, s:colors.none, s:emphasis.bold)

call s:HL('FANSIBlackLight', s:colors.light.black)
call s:HL('FANSIRedLight', s:colors.light.red)
call s:HL('FANSIGreenLight', s:colors.light.green)
call s:HL('FANSIYellowLight', s:colors.light.yellow)
call s:HL('FANSIBlueLight', s:colors.light.blue)
call s:HL('FANSIMagentaLight', s:colors.light.magenta)
call s:HL('FANSICyanLight', s:colors.light.cyan)
call s:HL('FANSIGreyLight', s:colors.light.grey)

call s:HL('FANSIBlackLightBold', s:colors.light.black, s:colors.none, s:emphasis.bold)
call s:HL('FANSIRedLightBold', s:colors.light.red, s:colors.none, s:emphasis.bold)
call s:HL('FANSIGreenLightBold', s:colors.light.green, s:colors.none, s:emphasis.bold)
call s:HL('FANSIYellowLightBold', s:colors.light.yellow, s:colors.none, s:emphasis.bold)
call s:HL('FANSIBlueLightBold', s:colors.light.blue, s:colors.none, s:emphasis.bold)
call s:HL('FANSIMagentaLightBold', s:colors.light.magenta, s:colors.none, s:emphasis.bold)
call s:HL('FANSICyanLightBold', s:colors.light.cyan, s:colors.none, s:emphasis.bold)
call s:HL('FANSIGreyLightBold', s:colors.light.grey, s:colors.none, s:emphasis.bold)

" use terminal defaults
call s:HL('Normal', s:colors.none)

" cursor stuff
hi Cursor ctermfg=none ctermbg=8 cterm=reverse
hi! link iCursor Cursor
hi! link lCursor Cursor
hi! link vCursor Cursor
hi MatchParen ctermfg=none ctermbg=0

" selection
hi Visual ctermfg=none ctermbg=0 cterm=none
hi! link VisualNOS Visual

" errors, warning, info, etc.
hi Error ctermfg=1 ctermbg=none cterm=bold,reverse
hi Info ctermfg=4 ctermbg=none cterm=reverse
hi Warning ctermfg=3 ctermbg=none cterm=reverse
hi Todo ctermfg=none ctermbg=none cterm=bold,italic

" 'textual' elements
hi! link Conceal FANSIBlue
hi! link SpecialKey FANSIBlackLight
hi! link NonText FANSIBlackLight

" titles and messages
hi! link Title FANSIGreenBold
hi ErrorMsg ctermfg=none ctermbg=1
hi! link ModeMsg FANSIBlueBold
hi! link MoreMsg FANSIYellowBold
hi! link WarningMsg FANSIRedBold
hi! link Question FANSIRedLightBold

" window dressing {{{
  hi ColorColumn ctermbg=0
  hi CursorColumn ctermbg=0
  hi! link CursorLine CursorColumn
  hi! link CursorLineNr FANSIGreyLight
  hi! link Folded FANSIBlackLight
  hi! link FoldColumn FANSIBlackLight
  hi! link LineNr FANSIBlackLight
  hi! link LineNrAbove LineNr
  hi! link LineNrBelow LineNr
  hi! link SignColumn FANSIBlackLight

  if has('nvim')
    hi! link WinSeparator FANSIBlack
  else
    hi! link VertSplit FANSIBlack
  endif

  " completion menu
  hi Pmenu ctermfg=none ctermbg=0
  hi PmenuSel ctermfg=4 ctermbg=none cterm=reverse
  hi PmenuSbar ctermfg=7
  hi PmenuThumb ctermfg=15

  " search
  hi CurSearch ctermfg=11 ctermbg=none cterm=reverse
  hi Search ctermfg=3 ctermbg=none cterm=reverse
  hi! link IncSearch CurSearch
  hi! link Substitute Search

  " statusline
  hi StatusLine ctermfg=none ctermbg=0 cterm=none
  hi StatusLineNC ctermfg=7 ctermbg=0 cterm=none
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLine
  hi! link WildMenu PmenuSel

  " tabline
  hi TabLine ctermfg=12 ctermbg=none cterm=none
  hi TabLineFill ctermfg=0 ctermbg=none cterm=underline
  hi TabLineSel ctermfg=12 ctermbg=none cterm=bold,reverse

  " misc
  hi QuickFixLine ctermfg=4 ctermbg=none cterm=reverse
" }}}

" diffs
hi DiffAdd ctermfg=2 ctermbg=none cterm=reverse
hi DiffChange ctermfg=4 ctermbg=none cterm=reverse
hi DiffDelete ctermfg=1 ctermbg=none cterm=reverse
hi DiffText ctermfg=0 ctermbg=12

" spelling & diagnostics
hi! SpellBad ctermfg=1 ctermbg=none cterm=italic,undercurl
hi! SpellCap ctermfg=none ctermbg=none cterm=italic,undercurl

if has('nvim')
  hi SpellBad guisp=none
  hi SpellCap guisp=none
endif

hi! link SpellLocal SpellCap
hi! link SpellRare SpellCap
hi! link DiagnosticError FANSIRed
hi! link DiagnosticWarn FANSIYellow
hi! link DiagnosticInfo FANSIBlue
hi! link DiagnosticHint FANSIGreyLight
hi DiagnosticUnderlineError cterm=undercurl guisp=#f55c45
hi DiagnosticUnderlineWarn cterm=undercurl guisp=#ebb242
hi DiagnosticUnderlineInfo cterm=undercurl guisp=#5fb8b8
hi DiagnosticUnderlineHint cterm=undercurl guisp=#9aaab8

" Syntax: {{{
  hi Comment ctermfg=8 ctermbg=none cterm=italic

  hi! link Directory FANSIBlueBold

  hi! link Constant FANSIMagenta
  hi! link String FANSIGreen
  hi! link Character FANSIRedLight
  hi! link Number FANSIMagentaLight
  hi! link Boolean FANSIMagenta
  hi! link Float FANSIMagentaLight

  hi! link Identifier FANSIBlue
  hi! link Function FANSIGreenBold

  hi! link Statement FANSIRed
  hi! link Conditional FANSIRed
  hi! link Repeat FANSIRed
  hi! link Label FANSIRed
  hi! link Operator FANSIBlueLight
  hi! link Keyword FANSIRedLight
  hi! link Exception FANSIRedLight

  hi! link PreProc FANSICyan
  hi! link Include FANSICyan
  hi! link Define FANSICyan
  hi! link Macro Define
  hi! link PreCondit FANSICyan

  hi! link Type FANSIYellow
  hi! link StorageClass FANSIRedLight
  hi! link Structure FANSICyan
  hi! link Typedef FANSIYellow

  hi! link Special FANSIRedLight
  hi! link SpecialChar FANSIRed

  hi! link SpecialComment FANSIYellow
  hi! link Debug FANSIYellow

  hi Tag cterm=underline
  hi Underlined ctermfg=4 cterm=underline
" }}}

" Language: {{{
  " diff
  hi! link diffFile FANSIYellowLightBold
  hi! link diffIndexLine FANSIYellowLightBold
  hi! link diffLine FANSIMagentaLightBold
  hi! link diffAdded FANSIGreen
  hi! link diffRemoved FANSIRed
  hi! link diffSubname Normal

  " git
  hi! link gitcommitSummary Title
  hi! link gitcommitDiscardedFile FANSIRed
  hi! link gitcommitSelectedFile FANSIGreenLight

  " json
  hi! link jsonKeyword String

  " typescript
  hi! link typescriptAssign FANSIGrey
  hi! link typescriptAsyncFuncKeyword FANSIRed
  hi! link typescriptBinaryOp Identifier
  hi! link typescriptBraces FANSIGrey
  hi! link typescriptFuncKeyword FANSIRed
  hi! link typescriptInterfaceName Identifier
  hi! link typescriptObjectLabel FANSICyan
  hi! link typescriptObjectType FANSICyan

  hi! link typescriptBraces FANSIGrey
  hi! link typescriptParens FANSIGrey
  hi! link typescriptTypeBrackets FANSIGrey
" }}}

" Plugins: {{{
  " ALE
  hi! link ALEError Error
  hi! link ALEInfo Info
  hi! link ALEWarning Warning

  hi! link ALEErrorSign FANSIRedBold
  hi! link ALEWarningSign FANSIYellowBold
  hi! link ALEInfoSign FANSIBlueBold

  " git-gutter
  hi! link GitGutterAdd FANSIGreen
  hi! link GitGutterChange FANSIYellow
  hi! link GitGutterDelete FANSIRed
  hi! link GitGutterChangeDelete FANSIYellow

  " Netrw
  hi! link netrwExe Function
  hi! link netrwLink FANSICyanLightBold
  hi! link netrwSymLink netrwLink
  hi! link netrwTreeBar FANSIBlackLight
" }}}
