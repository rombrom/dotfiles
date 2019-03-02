" General Vim Settings
" ---------------------------------------------------------------------------- "
let mapleader=","                   " Leader key = ,

set backspace=indent,eol,start      " Allow backspace in insert mode
set clipboard=unnamedplus           " Use the macOS clipboard
set colorcolumn=80                  " Show a coloumn indicating 80 char width
set encoding=utf-8 nobomb
set esckeys                         " Allow arrow keys in insert mode
set expandtab
set foldenable                      " enable folding
set foldlevelstart=99               " open all folds by default
set foldmethod=manual
set foldnestmax=10                  " 10 nested fold max; > 10 == absurd
set gdefault                        " Use /g flag for RegExp by default
set hlsearch                        " highlight matches
set ignorecase
set incsearch                       " search as characters are entered
set laststatus=2                    " Always show status line
set lazyredraw
set linebreak                       " Break after words
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set mouse=a                         " Enable mouse in all modes
set nocompatible                    " Make Vi Improved
set nohidden                        " When I close a tab, remove the buffer
set noshowmode
set nostartofline
set number
set ruler
set shiftwidth=2
set shortmess=atI                   " Don’t show the intro message
set showcmd                         " Show (partial) command as it’s being typed
set showmatch                       " highlight matching [{()}]
set signcolumn=yes
set smartcase
set smarttab
set softtabstop=2
set splitbelow                      " split below instead of above
set splitright                      " split after instead of before
set tabstop=2
set title                           " Show the filename in the window titlebar
set ttyfast                         " Optimize for fast terminal connections
set vb t_vb=                        " Remove 'bell' in vim
set wildmenu                        " visual autocomplete for command menu

" Vim backup settings
" ---------------------------------------------------------------------------- "
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set writebackup
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Theme settings
" ---------------------------------------------------------------------------- "
set background=dark
filetype on " Enable file type detection

" Enable italics support in Terminal.app
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let g:gruvbox_italic = 1                " Needs to be set before the theme loads

try
	colorscheme gruvbox
catch
endtry

syntax enable

" Keybindings
" ---------------------------------------------------------------------------- "
" :W sudo saves the file
command W w !sudo tee % > /dev/null
command Q q

" Invoke :Files finder on ctrl-p
nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>

" use tab and shift tab to indent and de-indent code
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
inoremap <S-Tab> <C-d>

" use `u` to undo, use `U` to redo, mind = blown
nnoremap U <C-r>

let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_browse_split = 4

" Plugins
" ---------------------------------------------------------------------------- "
" Auto-install plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start plug
call plug#begin('~/.vim/bundle')

" Plugin: worp/ale - linting
" fix files on save
let g:ale_fix_on_save = 1

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000

" use nice symbols for errors and warnings
let g:ale_sign_error = '✗\ '
let g:ale_sign_warning = '⚠\ '

" fixer configurations
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

Plug 'w0rp/ale'

" Plugin: tmux-navigator
Plug 'christoomey/vim-tmux-navigator'

" Plugin: editorconfig
Plug 'editorconfig/editorconfig-vim'

" Plugim: lightline
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
\ }
Plug 'itchyny/lightline.vim'

" Plugin: git gutter
" Sethighlight options
hi! link SignColumn LineNr
highlight link GitGutterAdd GruvboxGreen
highlight link GitGutterChange GruvboxAqua
highlight link GitGutterDelete GruvboxRed
highlight link GitGutterChangeDelete GruvboxAqua

Plug 'airblade/vim-gitgutter'

" Plugin: fuzzyfinder
let g:fzf_layout = { 'up': '~40%' }

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Plugin: rainbow parentheses
" Enable Rainbow Parentheses by default
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

Plug 'kien/rainbow_parentheses.vim'

" Plugin: emmet
" make emmet behave well with JSX in JS and TS files
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}

Plug 'mattn/emmet-vim'

" Plugin: javascript
" Enable JSDoc highlighting
let g:javascript_plugin_jsdoc = 1

Plug 'pangloss/vim-javascript'

" Plugin: gundo
Plug 'sjl/gundo.vim'

" Plugin: commentary - toggle comment blocks
Plug 'tpope/vim-commentary'

" Plugin: fugitive - git interface
Plug 'tpope/vim-fugitive'

" Plugin: surround - surround words with text
Plug 'tpope/vim-surround'

call plug#end()

" Automatic commands
" ---------------------------------------------------------------------------- "
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Treat .json files as .js
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
" Treat .md files as Markdown
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

" augroup highlighlongline
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey
"   autocmd BufEnter * match OverLength /\%>80v.\+/
" augroup END

" Open file browser on opening Vim
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

" Auto-reload vim when ~/.vimrc is saved
augroup vimrc
  au!
  autocmd BufWritePost .vimrc source ~/.vimrc
  autocmd BufWritePost .vimrc call ReloadLightline()
augroup END

function ReloadLightline()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
