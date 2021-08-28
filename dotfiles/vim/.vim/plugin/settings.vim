" netrw
"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize =-22

" Plug 'editorconfig/editorconfig-vim'
"
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Plug 'mattn/emmet-vim'
"
" Use double <Leader> for expansion
let g:user_emmet_leader_key='<Leader><Leader>'
" make emmet behave well with JSX in JS and TS files
let g:user_emmet_settings = {
\  'javascript' : {
\    'extends' : 'jsx',
\  },
\  'typescript' : {
\    'extends' : 'tsx',
\  },
\}

" Plug 'dense-analysis/ale'
"
" ALE needs the following globally installed binaries. Some of these are
" preferences (configs, etc.), others are required to lint and fix things
" node_modules:
" - eslint
" - eslint-config-prettier
" - eslint-plugin-prettier
" - prettier
" - stylelint
" - stylelint-config-standard
" - typescript
let g:ale_fix_on_save = 1
let g:ale_set_balloons = 1
let g:ale_completion_max_suggestions = 999
let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_error = '‼'
let g:ale_sign_warning = '! '
let g:ale_sign_column_always = 1

" use eslint_d to spead up eslint fixing
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1

let g:ale_linters = {
\  'python': ['black', 'flake8', 'mypy', 'pyflakes', 'pyls']
\}

" make linting possible in strange files
let g:ale_linter_aliases = {
  \'javascriptreact': ['css', 'javascript', 'jsx'],
  \'typescriptreact': ['css', 'typescript', 'tsx'],
\}

" tslint is deprecated. we don't want it
let g:ale_linters_ignore = {
  \'graphql': ['eslint', 'gqlint'],
  \'typescript': ['tslint'],
  \'typescriptreact': ['tslint'],
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'css': ['prettier', 'stylelint'],
\  'html': ['prettier'],
\  'javascript': ['prettier', 'eslint'],
\  'javascriptreact': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'typescriptreact': ['prettier', 'eslint'],
\  'markdown': ['prettier'],
\  'python': ['autoimport', 'black', 'isort'],
\  'sass': ['prettier'],
\  'scss': ['prettier'],
\  'svelte': ['prettier', 'eslint'],
\  'php': ['php_cs_fixer'],
\}

" Plug 'sheerun/vim-polyglot'
"
let g:vim_svelte_plugin_use_typescript = 1

" Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
"
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = '.git/hooks/ctags || ctags -R --tag-relative'
