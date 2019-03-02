" General Vim Settings
let mapleader=","                   " Leader key = ,

set clipboard=unnamed               " Use the macOS clipboard
set encoding=utf-8 nobomb
set nocompatible                    " Make Vi Improved
set nohidden                        " When I close a tab, remove the buffer
set mouse=a                         " Enable mouse in all modes
set shortmess=atI                   " Don’t show the intro message
set showcmd                         " Show (partial) command as it’s being typed
set showmode                        " Show the current mode
set title                           " Show the filename in the window titlebar
set ttyfast                         " Optimize for fast terminal connections

" Vim Backup Settings
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set writebackup
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Enable italics support in Terminal.app
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let g:gruvbox_italic=1

" Colors, Themes, etc.
set background=dark
try
	colorscheme gruvbox
catch
endtry
syntax enable

" Spaces, Tabs, Wrapping
set expandtab
set smarttab
set softtabstop=2
set tabstop=2
set lbr															" Break lines
set tw=80														" At 80 characters"
set ai 															" Auto indent
set si 															" Smart indent
set wrap 														" Wrap lines

" Vim Keys
nnoremap <leader>u :GundoToggle<CR> " toggle Gundo.vim
nnoremap j gj                       " move down by visual line
nnoremap k gk                       " move up by visual line
nnoremap <leader>s :mksession<CR>   " save session, reopen with vim -S

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" :W sudo saves the file
command W w !sudo tee % > /dev/null

set backspace=indent,eol,start      " Allow backspace in insert mode
set nostartofline

" Vim UI
set backspace=indent,eol,start      " Allow backspace in insert mode
set esckeys                         " Allow arrow keys in insert mode
set foldenable                      " enable folding
set foldlevelstart=99               " open all folds by default
set foldnestmax=10                  " 10 nested fold max; > 10 == absurd
set foldmethod=manual
set laststatus=2                    " Always show status line
set number
set lazyredraw
set ruler
set showcmd
set showmatch                       " highlight matching [{()}]
set wildmenu                        " visual autocomplete for command menu

" Vim Search
set ignorecase
set incsearch                       " search as characters are entered
set gdefault                        " Use /g flag for RegExp by default
set hlsearch                        " highlight matches

" Invoke :Files finder on ctrl-p
nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>

" Enable JSDoc highlighting
let g:javascript_plugin_jsdoc = 1

" make emmet behave well with JSX in JS and TS files
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}

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

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Auto-install plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-Plug Plugins
call plug#begin('~/.vim/bundle')

" List of plugins
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'


" Initialize plugin system
call plug#end()
