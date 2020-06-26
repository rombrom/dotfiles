" Rommert Zijlstra's .vimrc

" {{{ General

  set nohidden                      " When I close a tab, remove the buffer
  set nomodeline                    " Prevent weird stuff with modelines

  " Editing
  set autoread                      " Re-read files when changed outside vim
  set backspace=indent,eol,start    " Allow backspace in insert mode
  set clipboard=unnamed             " Use the macOS clipboard
  set complete+=kspell              " Add dictionary to autocomplete options
  set dictionary+=/usr/share/dict/words " Use the linked dictionary of macOS
  set display+=lastline
  set encoding=utf-8 nobomb
  set esckeys                       " Allow arrow keys in insert mode
  set formatoptions+=j              " Delete comment character when joining lines
  set history=200                   " never found use of setting this higher
  set nostartofline
  set spelllang=en,nl               " Use English and Dutch

  " Indentation and wrapping
  set autoindent                    " Automatic indentation in insert mode
  set breakindent                   " Indent text wrapping
  set cindent                       " Smart autmatic indentation
  set expandtab                     " Use spaces for tabs
  set linebreak                     " Break after words
  set shiftwidth=2                  " Use 2 spaces for indentation
  let &showbreak='› '               " Show a wrapping indicator
  set smarttab                      " Delete shiftwidth amount of chars
  set wrap                          " Wrap it up

  " Search & tags
  set gdefault                      " Use /g flag for RegExp by default
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set hlsearch                      " highlight matches
  set ignorecase
  set incsearch                     " search as characters are entered
  set smartcase
  set tag+=.git/tags                " DEPRECATED

  " Terminal behavior
  set lazyredraw
  set mouse=a                       " Enable mouse in all modes
  set title                         " Show the filename in the window titlebar
  set ttimeoutlen=50                " Return to NORMAL quickly after <ESC>
  set ttyfast                       " Optimize for fast terminal connections
  set ttymouse=sgr                  " Enable proper mouse support
  set vb t_vb=                      " Remove 'bell' in vim

  " UI
  set ballooneval
  set balloonevalterm
  set foldenable                    " enable folding
  set foldlevelstart=99             " open all folds by default
  set foldmethod=indent
  set foldnestmax=10                " 10 nested fold max; > 10 == absurd
  set laststatus=2                  " Always show status line
  set list
  set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
  set noshowmode
  set number
  set numberwidth=5                 " make the current line stand out
  set relativenumber
  set scrolloff=3                   " Keep 5 lines above/below cursor visible
  set shortmess=atI                 " Don’t show the intro message
  set showcmd                       " Show command as it’s being typed
  set showmatch                     " highlight matching [{()}]
  set signcolumn=yes
  set smartcase
  set smarttab
  set softtabstop=2
  set spelllang=en,nl               " Use English and Dutch
  set synmaxcol=1000                " We don't need that much syntax per line
  set wildmenu                      " visual autocomplete for command menu

  " Windows
  set splitbelow splitright         " The same behavior as tmux
  set winheight=25
  set winminheight=6
  set winminwidth=20
  set winwidth=87

  " Experimental
  set path=.,,**                    " Let :find work as a fuzzy-matcher
  set wildignore=**/dist/**,**/node_modules/** " and ignore some folders

" }}}

" {{{ Backup & undo

  set writebackup     " Protect files against crash-during-write
  set nobackup        " but remove the backup after succesful write
  set backupcopy=auto "  use rename-and-write-new method whenever safe
  set backupdir=~/.vim/backup//

  set swapfile        " write a swap every now and then
  set directory=~/.vim/swap//

  set undofile        " persistent undo is AWESOME
  set undodir=~/.vim/undo//

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

  "" Plugins: autocomplete & LSP {{{
  "" TODO: find a better lsp/js autocomplete solution
  "" the most important thing for me is completion of library stuff

  "  Plug 'natebosch/vim-lsc'

  "  let g:lsc_server_commands = {
  "  \  'javascript': 'typescript-language-server --stdio',
  "  \  'typescript': 'typescript-language-server --stdio',
  "  \}

  "  " TODO: the default mappings overwrite <C-p> which I want
  "  " mapped to fzf. SAD!
  "  let g:lsc_auto_map = {
  "  \  'defaults': v:true,
  "  \  'NextReference': '',
  "  \  'PreviousReference': '',
  "  \}

  "" }}}

  " Plugins: editing {{{

    packadd! editexisting               " Open existing vim instance if open
    packadd! matchit                    " Make % command work better

    Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'

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

  " Plugins: linting {{{

    " ALE needs the following globally installed binaries. Some of these are
    " preferences (configs, etc.), others are required to lint and fix things
    " node_modules:
    " - eslint
    " - eslint-config-prettier
    " - eslint-plugin-prettier
    " - eslint-plugin-svelte
    " - prettier
    " - prettier-plugin-svelte
    " - stylelint
    " - stylelint-config-standard
    " - stylelint-scss
    " - svelte (because its a compiler, the fixer/linter needs it)
    " - typescript
    " other (brew):
    " - php-cs-fixer

    Plug 'dense-analysis/ale'

    " fix files on save
    let g:ale_fix_on_save = 1

    " :h ale-hover
    " let g:ale_set_balloons = 1

    " lint 1000ms after changes are made both on insert mode and normal mode
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_delay = 1000

    " use nice symbols for errors and warnings
    let g:ale_sign_error = '✗ '
    let g:ale_sign_warning = '⚠ '
    let g:ale_sign_column_always = 1

    " make svelte linting possible
    let g:ale_linter_aliases = { 'svelte' : ['css', 'html', 'javascript'] }
    let g:ale_linters = { 'svelte': ['stylelint', 'eslint'] }

    " fixer configurations
    let g:ale_fixers = {
    \  '*': ['remove_trailing_lines', 'trim_whitespace'],
    \  'css': ['prettier'],
    \  'html': ['prettier'],
    \  'javascript': ['prettier'],
    \  'typescript': ['prettier'],
    \  'markdown': ['prettier'],
    \  'sass': ['prettier'],
    \  'scss': ['prettier'],
    \  'svelte': ['prettier'],
    \  'php': ['php_cs_fixer'],
    \}

  " }}}

  " Plugins: syntax {{{

    Plug 'cakebaker/scss-syntax.vim'
    Plug 'chr4/nginx.vim'
    Plug 'mustache/vim-mustache-handlebars'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'pangloss/vim-javascript'
    Plug 'digitaltoad/vim-pug'
    Plug 'leafgarland/typescript-vim'
    Plug 'evanleck/vim-svelte'

    " Enable JSDoc highlighting
    let g:javascript_plugin_jsdoc = 1

  " }}}

  " Plugins: UI {{{

    " netrw UI tweaks
    let g:netrw_altv = 1
    let g:netrw_banner = 0
    let g:netrw_browse_split = 4
    let g:netrw_liststyle = 3
    let g:netrw_winsize =-22

    Plug 'airblade/vim-gitgutter'
    Plug 'itchyny/lightline.vim'

    " Make vim + tmux awesome
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'tmux-plugins/vim-tmux-focus-events'

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-unimpaired'

    let g:lightline = {
    \  'active': {
    \    'left': [ [ 'mode', 'paste' ],
    \              [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
    \  },
    \  'inactive': {
    \    'left': [ [ 'relativepath', 'modified' ] ],
    \    'right': []
    \  },
    \  'component_function': {
    \    'readonly': 'LightlineReadonly',
    \    'gitbranch': 'FugitiveHead'
    \  },
    \  'separator': { 'left': '', 'right': '' },
    \  'subseparator': { 'left': '▪', 'right': '▪', },
    \  'tabline_separator': { 'left': '', 'right': '' },
    \}

    function! LightlineReadonly()
      return &readonly ? '🔒' : ''
    endfunction

    " Theme
    Plug 'gruvbox-community/gruvbox'

    " Needs to be set before the theme loads
    let g:gruvbox_italic = 1

    " fzf fuzzyfinding
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1

    " Set default tags command
    let g:fzf_tags_command = '.git/hooks/ctags || ctags -R --tag-relative'

    " Use preview with :Files
    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  " }}}

call plug#end()
" }}}

" Key bindings {{{

  " Move visually instead of by line
  noremap <silent> j gj
  noremap <silent> k gk
  noremap <silent> <Down> gj
  noremap <silent> <Up> gk

  " Center on n and N
  map n nzz
  map N Nzz

  " These things happen too often
  command W w
  command Q q

  " Clear highlight with leader
  nnoremap <silent> <Leader>c :noh<Cr>

  " Invoke :Files finder on ctrl-p
  nnoremap <C-p> :Files<Cr>
  nnoremap <C-g> :Rg<Cr>
  nnoremap <C-o> :Tags<Cr>
  nnoremap <S-Tab> <C-o>

  " use `u` to undo, use `U` to redo
  nnoremap U <C-r>

  " CTRL-U in insert mode deletes a lot. Put an undo-point before it.
  inoremap <C-u> <C-g>u<C-u>

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
    " Hack to make <C-x><C-f> work with files relative to current buffer
    au InsertEnter * let cwd = getcwd() | lcd %:p:h
    au InsertLeave * execute 'lcd' fnameescape(cwd)
    " Create dir on save if it doesn't exist
    " TODO: this trips up the lcd switching above.
    au BufWritePre * call MakeDirIfNotExists(expand('<afile>'), +expand('<abuf>'))

    " Treat .json files as .js
    au BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    au BufNewFile,BufRead *.md setfiletype markdown
    " Treat .svelte files as HTML
    " au BufNewFile,BufRead *.svelte setfiletype html

    " fix common syntax highlighting issues in html files
    au BufNewFile,BufRead *.html,*.svelte syntax sync fromstart

    " Make dash-delimited words count as words in styling languages
    " Improve lookups when working with css @imports
    au FileType css,less,sass,scss,styl call ImproveCSSEditing()
    " Use spell checking on commits
    au FileType gitcommit setlocal spell
    " Improve working with node_modules projects
    au FileType javascript,json,jsx,typescript,tsx call ImproveNodeEditing()
    " Improve markdown editing
    au FileType markdown setlocal spell | setlocal textwidth=80
  augroup END

  function! ImproveCSSEditing()
    setlocal iskeyword+=-
    setlocal suffixesadd+=.css,.less,.sass,.scss,.styl
    setlocal include=^\s*@import
    setlocal includeexpr=expand('<cfile>:p:h').'/_'.expand('<cfile>:t')
  endfunction

  function! ImproveNodeEditing()
    setlocal isfname+=@-@ " some node_modules are namespaced with an @
    setlocal suffixesadd+=.js,.json,.jsx,.ts,.tsx
    setlocal include=from
    setlocal includeexpr=LookupNodeModule(v:fname)
  endfunction

  function! ImprovePHPEditing()
    " PHP includes often start with a slash so vim thinks the path is absolute
    setlocal include=^\s*(include|require)(_once)?
    setlocal includeexpr=expand('%:p:h').v:fname
  endfunction

  function! LookupNodeModule(fname)
    let basePath = finddir('node_modules', expand('%:p:h') . ';' . getcwd()) . '/' . a:fname
    let indexFileJs = basePath . '/index.js'
    let indexFileTs = basePath . '/index.ts'
    let packageFile = basePath . '/package.json'

    if filereadable(packageFile)
      let package = json_decode(join(readfile(packageFile)))

      if has_key(package, 'module')
        return basePath . '/' . package.module
      endif

      if has_key(package, 'main')
        return basePath . '/' . package.main
      endif
    endif

    if filereadable(indexFileTs)
      return indexFileTs
    endif

    if filereadable(indexFileJs)
      return indexFileJs
    endif

    return basePath
  endfunction

  function! MakeDirIfNotExists(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file !~# '\v^\w+\:\/'
      call mkdir(fnamemodify(a:file, ':h'), 'p')
    endif
  endfunction

  " Auto-reload vim when ~/.vimrc is saved
  augroup ReloadVimrc
    au!
    au BufRead .vimrc setlocal foldmethod=marker
    au BufWritePost .vimrc source $MYVIMRC | call ReloadLightline()
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

  " Change cursor in insert mode
  let &t_SI="\e[5 q"
  let &t_EI="\e[2 q"

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
