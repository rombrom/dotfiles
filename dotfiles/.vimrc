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

" Colors, Themes, etc.
colorscheme Tomorrow-Night-Eighties
syntax enable

" Spaces & Tabs
set expandtab
set smarttab
set softtabsstop=2
set tabstop=2

" Vim Keys
nnoremap <leader>u :GundoToggle<CR> " toggle Gundo.vim
nnoremap j gj                       " move down by visual line
nnoremap k gk                       " move up by visual line
nnoremap <leader>s :mksession<CR>   " save session, reopen with vim -S

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
set grepprg=ag\ --vimgrep\ $* set grepformat=%f:%l:%c:%m " use ag for vimgrep
set ignorecase
set incsearch                       " search as characters are entered
set gdefault                        " Use /g flag for RegExp by default
set hlsearch                        " highlight matches

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

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

" Vim-Plug Plugins
call plug#begin('~/.vim/bundle')

" List of plugins
Plug 'kien/ctrlp.vim'
Plug 'mhinz/vim-grepper'
Plug 'sjl/gundo.vim'

" Initialize plugin system
call plug#end()
