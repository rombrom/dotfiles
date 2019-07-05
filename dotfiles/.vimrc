" Rommert Zijlstra's .vimrc

" {{{ General

  set autoindent                    " Automatic indentation in insert mode
  set autoread                      " Re-read files when changed outside vim
  set backspace=indent,eol,start    " Allow backspace in insert mode
  set cindent                       " Smart autmatic indentation
  set clipboard=unnamed             " Use the macOS clipboard
  set colorcolumn=81                " Show a coloumn indicating 80 char width
  set display+=lastline
  set encoding=utf-8 nobomb
  set esckeys                       " Allow arrow keys in insert mode
  set expandtab
  set foldenable                    " enable folding
  set foldlevelstart=99             " open all folds by default
  set foldmethod=indent
  set foldnestmax=10                " 10 nested fold max; > 10 == absurd
  set formatoptions+=j              " Delete comment character when joining lines
  set gdefault                      " Use /g flag for RegExp by default
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set hlsearch                      " highlight matches
  set ignorecase
  set incsearch                     " search as characters are entered
  set laststatus=2                  " Always show status line
  set lazyredraw
  set linebreak                     " Break after words
  set list
  set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
  set mouse=a                       " Enable mouse in all modes
  set nohidden                      " When I close a tab, remove the buffer
  set nomodeline                    " Prevent weird stuff with modelines
  set noshowmode
  set nostartofline
  set number
  set numberwidth=5                 " make the current line stand out
  set relativenumber
  set ruler
  set scrolloff=5                   " Keep 5 lines above/below cursor visible
  set shiftwidth=2
  set shortmess=atI                 " Don’t show the intro message
  set showcmd                       " Show command as it’s being typed
  set showmatch                     " highlight matching [{()}]
  set signcolumn=yes
  set smartcase
  set smarttab
  set softtabstop=2
  set splitbelow                    " split below instead of above
  set splitright                    " split after instead of before
  set synmaxcol=1000                " We don't need that much syntax per line
  set tag+=.git/tags
  set ttimeoutlen=100               " Return to NORMAL quicklt after <ESC>
  set title                         " Show the filename in the window titlebar
  set ttyfast                       " Optimize for fast terminal connections
  set vb t_vb=                      " Remove 'bell' in vim
  set wildmenu                      " visual autocomplete for command menu

" }}}

" {{{ Backup & undo

  set backup
  set backupdir=~/.vim/backup
  set directory=~/.vim/swap
  set writebackup
  set undofile
  set undodir=~/.vim/undo

" }}}

" {{{ Plugins

  " {{{ Auto-install Plug

    " https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

  " }}}

  call plug#begin('~/.vim/bundle')

  " Plugin: ale {{{

    Plug 'w0rp/ale'

    " fix files on save
    let g:ale_fix_on_save = 1

    " lint 1000ms after changes are made both on insert mode and normal mode
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_delay = 1000

    " use nice symbols for errors and warnings
    let g:ale_sign_error = '✗ '
    let g:ale_sign_warning = '⚠ '
    let g:ale_sign_column_always = 1

    " fixer configurations
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'css': ['prettier'],
    \   'html': ['prettier'],
    \   'javascript': ['prettier'],
    \   'scss': ['prettier'],
    \}

  " }}}

  " Plugin: editexisting & matchit {{{

    packadd! editexisting               " Open existing vim instance if open
    packadd! matchit                    " Make % command work better

  " }}}

  " Plugin: editorconfig {{{

    Plug 'editorconfig/editorconfig-vim'

  " }}}

  " PLugin: emmet {{{

    Plug 'mattn/emmet-vim'

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

  " }}}

  " Plugin: fzf {{{

    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1

    " Use preview with :Files
    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  " }}}

  " Plugin: gruvbox {{{

    Plug 'gruvbox-community/gruvbox'

    " Needs to be set before the theme loads
    let g:gruvbox_italic = 1

  " }}}

  " Plugin: lightline {{{

    Plug 'itchyny/lightline.vim'

    let g:lightline = {
    \   'active': {
    \     'left': [ [ 'mode', 'paste' ],
    \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \   },
    \   'inactive': {
    \     'left': [ [ 'filename', 'modified' ] ],
    \     'right': [ [ 'lineinfo' ],
    \                [ 'percent' ] ]
    \   },
    \   'component_function': {
    \     'gitbranch': 'fugitive#head'
    \   },
    \ }

  " }}}

  " Plugin: netrw {{{

    let g:netrw_banner = 0
    let g:netrw_winsize = 20
    let g:netrw_liststyle = 3
    let g:netrw_altv = 1

  " }}}

  " Plugin: nginx {{{

    Plug 'chr4/nginx.vim'

  " }}}

  " Plugin: scss-syntax {{{

    Plug 'cakebaker/scss-syntax.vim'

  " }}}

  " Plugin: tagbar {{{

    Plug 'majutsushi/tagbar'

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

  " }}}

  " Plugin: tmux navigator {{{

    Plug 'christoomey/vim-tmux-navigator'
    Plug 'tmux-plugins/vim-tmux-focus-events'

  " }}}

  " Plugin: vim-commentary {{{

    Plug 'tpope/vim-commentary'

  " }}}

  " Plugin: vim-fugitive {{{

    Plug 'tpope/vim-fugitive'

  " }}}

  " Plugin: vim-gitgutter {{{

    Plug 'airblade/vim-gitgutter'

  " }}}

  " Plugin: vim-javascript {{{

    Plug 'pangloss/vim-javascript'

    " Enable JSDoc highlighting
    let g:javascript_plugin_jsdoc = 1

  " }}}

  " Plugin: vim-jsx {{{

    Plug 'mxw/vim-jsx'

  " }}}

  " Plugin: vim-mustache-handlebars {{{

    Plug 'mustache/vim-mustache-handlebars'

  " }}}

  " Plugin: vim-repeat {{{

    Plug 'tpope/vim-repeat'

  " }}}

  " Plugin: vim-surround {{{

    Plug 'tpope/vim-surround'

  " }}}

  " Plugin: vim-unimpaired {{{

    Plug 'tpope/vim-unimpaired'

  " }}}

call plug#end()
" }}}

" Key bindings {{{

  " :W sudo saves the file
  command W w !sudo tee % > /dev/null
  command Q q

  " Clear highlight with leader
  nnoremap <Leader>c :noh<Cr>

  " Tab completion of first suggestion
  " inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n><C-y>" : "\<Tab>"
  " inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p><C-y>" : "\<S-Tab>"

  " Completion modifications with FZF
  " imap <C-x><C-k> <plug>(fzf-complete-word)
  " imap <C-x><C-f> <plug>(fzf-complete-path)
  " imap <C-x><C-l> <plug>(fzf-complete-line)

  " Invoke :Files finder on ctrl-p
  nnoremap <C-p> :Files<Cr>
  nnoremap <C-g> :Rg<Cr>
  nnoremap <C-o> :Tags<Cr>
  nnoremap <S-Tab> <C-o>

  " use `u` to undo, use `U` to redo
  nnoremap U <C-r>

" }}}

" Commands {{{

  " Diff changes before save
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" }}}

" Autocommands {{{

  augroup ImproveEditing
    au!

    " Return to last edit position when opening files
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Treat .json files as .js
    au BufNewFile,BufRead *.json setfiletype json syntax=javascript

    " Treat .md files as Markdown
    au BufNewFile,BufRead *.md setfiletype markdown

    " Treat .svelte files as HTML
    au BufNewFile,BufRead *.svelte setfiletype html

    " Treat kebab-case in CSS as one word
    au FileType css,less,sass,scss setlocal iskeyword+=-

    " TODO: make this work?
    au FileType css,html,less,sass,scss EmmetInstall

  augroup END

  " Auto-reload vim when ~/.vimrc is saved
  augroup ReloadVimrc
    au!
    au BufRead .vimrc setlocal foldmethod=marker
    au BufWritePost $MYVIMRC source $MYVIMRC | call ReloadLightline()
  augroup END

  function! ReloadLightline()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endfunction

" }}}

" Theme {{{

  set background=dark

  " Enable file type detection
  filetype plugin indent on

  " Use <!-- --> comments in HTML
  let html_wrong_comments=1

  " fix indenting of css/js syntax in script/style tags
  let g:html_indent_script1 = "inc"
  let g:html_indent_style1 = "inc"

  " Enable italics support in Terminal.app
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"

  colorscheme gruvbox
  syntax enable

  " Set highlight options
  hi! link Folded LineNr
  hi! link GitGutterAdd GruvboxGreen
  hi! link GitGutterChange GruvboxAqua
  hi! link GitGutterDelete GruvboxRed
  hi! link GitGutterChangeDelete GruvboxAqua
  hi! link SignColumn LineNr
  hi! link EndOfBuffer NonText

" }}}

" Misc {{{

  " Attempt to rename tmyx pane title
  if &term == "tmux-256color"
    set t_ts=]2
    set t_fs=\\
  endif

" }}}
