" Editing
set autoread                      " Re-read files when changed outside vim
set backspace=indent,eol,start    " Allow backspace in insert mode
set clipboard=unnamed             " Use the macOS clipboard
set complete+=kspell              " Add dictionary to autocomplete options
set complete-=i                   " Don't scan included files from `path`
set completeopt=menuone,noinsert,noselect
set dictionary+=/usr/share/dict/words " Use the linked dictionary of macOS
set display+=lastline
set encoding=utf-8 nobomb
set formatoptions+=jn             " Delete comment character when joining lines
set history=200                   " never found use of setting this higher
set nostartofline
set nrformats+=unsigned           " Just :h 'nrformats'
set spelllang=en,nl               " Use English and Dutch
set omnifunc=syntaxcomplete#Complete " Default omnifunc

" Indentation and wrapping
set autoindent                    " Automatic indentation in insert mode
set breakindent                   " Indent text wrapping
set cindent                       " Smart autmatic indentation
set expandtab                     " Use spaces for tabs
set linebreak                     " Break after words
set shiftround                    " Round < & > to nearest softtabstop
set shiftwidth=2                  " Use 2 spaces for indentation
set smarttab
set softtabstop=2
let &showbreak='› '               " Show a wrapping indicator
set smarttab                      " Delete shiftwidth amount of chars
set nowrap                        " Let lines overflow a window

" Search & tags
set gdefault                      " Use /g flag for RegExp by default
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden\ --glob\ '!.git'\ --ignore
set hlsearch                      " highlight matches
set ignorecase
set incsearch                     " search as characters are entered
set smartcase

" Terminal behavior
set lazyredraw
set mouse=a                       " Enable mouse in all modes
set title                         " Show the filename in the window titlebar
set ttimeoutlen=50                " Return to NORMAL quickly after <ESC>
set ttyfast                       " Optimize for fast terminal connections

set vb t_vb=                      " Remove 'bell' in vim

" UI
if has("8.0.1037")
  set diffopt+=algorithm:histogram,indent-heuristic,vertical
endif

set background=dark
set cursorlineopt=screenline,number
set statusline=%!init#statusline()
set tabline=%!init#tabline()
set foldcolumn=0
set foldenable                    " enable folding
set foldlevelstart=99             " open all folds by default
set foldmethod=indent
set foldnestmax=10                " 10 nested fold max; > 10 == absurd
set hidden                        " Allow unsaved buffers
set laststatus=2                  " Always show status line
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set scrolloff=3                   " Keep 5 lines above/below cursor visible
set shortmess=atI                 " Don’t show the intro message
set showcmd                       " Show command as it’s being typed
set showmatch                     " highlight matching [{()}]
set signcolumn=yes
set synmaxcol=1000                " We don't need that much syntax per line
set wildmenu                      " visual autocomplete for command menu
set wildoptions+=pum

" Windows
set splitbelow splitright         " The same behavior as tmux
set winheight=25
set winminheight=8
set winminwidth=20
set winwidth=88

" Experimental
set path=.,,
set sessionoptions=buffers,folds,tabpages,winsize
set wildignore=**/dist/**,**/node_modules/** " and ignore some folders

" Backup & undo
set writebackup     " Protect files against crash-during-write
set nobackup        " but remove the backup after succesful write
set backupcopy=auto "  use rename-and-write-new method whenever safe
set backupdir=~/.vim/backup//

set swapfile        " write a swap every now and then
set directory=~/.vim/swap//

set undofile        " persistent undo is AWESOME
set undodir=~/.vim/undo//
set noundofile

" Theme
colorscheme fansi
filetype plugin indent on
syntax enable

" Change cursor in insert mode
let &t_SI="\e[5 q"
let &t_EI="\e[2 q"

" nvim transition
if !has('nvim')
  set ttymouse=sgr
  set completeopt+=popup
  set ballooneval
  set balloonevalterm
  set wildoptions+=fuzzy
endif
