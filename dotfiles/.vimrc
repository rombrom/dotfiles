" General Vim Settings
" ---------------------------------------------------------------------------- "
set nocompatible                    " Make Vi Improved

set autoindent                      " Automatic indentation in insert mode
set autoread                        " Re-read files when changed outside vim
set backspace=indent,eol,start      " Allow backspace in insert mode
set cindent                         " Smart autmatic indentation
set clipboard=unnamed               " Use the macOS clipboard
set colorcolumn=81                  " Show a coloumn indicating 80 char width
set encoding=utf-8 nobomb
set esckeys                         " Allow arrow keys in insert mode
set expandtab
set foldenable                      " enable folding
set foldlevelstart=99               " open all folds by default
set foldmethod=manual
set foldnestmax=10                  " 10 nested fold max; > 10 == absurd
set gdefault                        " Use /g flag for RegExp by default
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set hlsearch                        " highlight matches
set ignorecase
set incsearch                       " search as characters are entered
set laststatus=2                    " Always show status line
set lazyredraw
set linebreak                       " Break after words
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set mouse=a                         " Enable mouse in all modes
set nohidden                        " When I close a tab, remove the buffer
set noshowmode
set nostartofline
set number
set numberwidth=5                   " make the current line stand out
set relativenumber
set ruler
set scrolloff=5                     " Keep 5 lines above/below cursor visible
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
set synmaxcol=1000                  " We don't need that much syntax per line
set tabstop=2
set tag=.git/tags,./tags,tags
set ttimeoutlen=100                 " Return to NORMAL quicklt after <ESC>
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
set undofile
set undodir=~/.vim/undo

" Netrw settings
" ---------------------------------------------------------------------------- "
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_liststyle = 3
let g:netrw_altv = 1

" Useful macros
" ---------------------------------------------------------------------------- "
packadd! editexisting               " Open existing vim instance if open
packadd! matchit                    " Make % command work better

" Keybindings
" ---------------------------------------------------------------------------- "
" :W sudo saves the file
command W w !sudo tee % > /dev/null
command Q q

" <ESC> on jj in insert
inoremap jj <Esc>

" Tab completion of first suggestion
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n><C-y>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p><C-y>" : "\<S-Tab>"

" Completion modifications with FZF
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Invoke :Files finder on ctrl-p
nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>
nnoremap <C-o> :Tags<Cr>
nnoremap <S-Tab> <C-o>

" use `u` to undo, use `U` to redo, mind = blown
nnoremap U <C-r>

" Custom commands
" ---------------------------------------------------------------------------- "
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Plugin settings
" ---------------------------------------------------------------------------- "
" Plugin: worp/ale - linting
" ---------------------------------------------------------------------------- "
" use ale's completion engine
" let g:ale_completion_enabled = 1
" fix agressive completion (see :help ale-completion-completopt-bug)
set completeopt=menu,menuone,preview,noselect,noinsert

" fix files on save
let g:ale_fix_on_save = 1

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 1000

" use nice symbols for errors and warnings
let g:ale_sign_error = '✗\ '
let g:ale_sign_warning = '⚠\ '
let g:ale_sign_column_always = 1

" fixer configurations
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\   'javascript': ['prettier'],
\   'scss': ['prettier'],
\}

" Plugim: lightline
" ---------------------------------------------------------------------------- "
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'inactive': {
  \   'left': [ [ 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
\ }


" Plugin: fuzzyfinder
" ---------------------------------------------------------------------------- "
let g:fzf_layout = { 'up': '~40%' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Use preview with :Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Plugin: rainbow parentheses
" ---------------------------------------------------------------------------- "
" Enable Rainbow Parentheses by default
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Plugin: emmet
" ---------------------------------------------------------------------------- "
" Use double <Leader> for expansion
let g:user_emmet_leader_key='<Leader>'

" make emmet behave well with JSX in JS and TS files
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}

" Plugin: javascript
" ---------------------------------------------------------------------------- "
" Enable JSDoc highlighting
let g:javascript_plugin_jsdoc = 1

" Plugin: tagbar
" ---------------------------------------------------------------------------- "
let g:tagbar_type_scss = {
\  'ctagstype' : 'scss',
\  'kinds' : [
\    'm:mixins',
\    'f:functions',
\    'v:variables',
\    'c:classes',
\    'i:ids',
\    't:tags',
\    'd:media'
\  ]
\}

" Plugins
" ---------------------------------------------------------------------------- "
" Auto-install plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug '/usr/local/opt/fzf'

Plug 'airblade/vim-gitgutter'
Plug 'chr4/nginx.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'morhetz/gruvbox'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

call plug#end()

" Automatic commands
" ---------------------------------------------------------------------------- "
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Treat .json files as .js
au BufNewFile,BufRead *.json setfiletype json syntax=javascript
" Treat .md files as Markdown
au BufNewFile,BufRead *.md setlocal filetype=markdown

" augroup highlighlongline
"   au BufEnter * highlight OverLength ctermbg=darkgrey
"   au BufEnter * match OverLength /\%>80v.\+/
" augroup END

" Open file browser on opening Vim
" augroup ProjectDrawer
"   au!
"   au VimEnter * :Vexplore
" augroup END

" Auto-reload vim when ~/.vimrc is saved
augroup vimrc
  au!
  au BufWritePost .vimrc source ~/.vimrc
  au BufWritePost .vimrc call ReloadLightline()
augroup END

function ReloadLightline()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" Theme settings
" ---------------------------------------------------------------------------- "
set background=dark
filetype on " Enable file type detection

let html_wrong_comments=1

" Enable italics support in Terminal.app
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let g:gruvbox_italic = 1                " Needs to be set before the theme loads

colorscheme gruvbox
syntax enable

" Sethighlight options
highlight! link SignColumn LineNr
highlight link GitGutterAdd GruvboxGreen
highlight link GitGutterChange GruvboxAqua
highlight link GitGutterDelete GruvboxRed
highlight link GitGutterChangeDelete GruvboxAqua
