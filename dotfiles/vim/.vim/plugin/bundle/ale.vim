" Plug 'dense-analysis/ale'

let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_error = '‼'
let g:ale_sign_warning = '! '
let g:ale_sign_column_always = 1
let g:ale_virtualtext_cursor = 'disabled'

" use eslint_d to spead up eslint fixing
" let g:ale_javascript_eslint_executable = 'eslint_d'
" let g:ale_javascript_eslint_use_global = 1

" let g:ale_linters = {
" \  'python': []
" \}

" make linting possible in strange files
let g:ale_linter_aliases = {
  \'javascriptreact': ['css', 'javascript', 'jsx'],
  \'typescriptreact': ['css', 'typescript', 'tsx'],
\}

" tslint is deprecated. we don't want it
let g:ale_linters_ignore = {
  \'graphql': ['eslint', 'gqlint'],
  \'typescript': ['deno', 'tslint'],
  \'typescriptreact': ['deno', 'tslint'],
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'css': ['prettier', 'stylelint'],
\  'html': ['prettier'],
\  'graphql': ['prettier'],
\  'javascript': ['prettier', 'eslint'],
\  'javascriptreact': ['prettier', 'eslint'],
\  'json': ['prettier'],
\  'markdown': ['prettier'],
\  'php': ['php_cs_fixer'],
\  'python': ['autoimport', 'black', 'isort', 'ruff'],
\  'sass': ['prettier'],
\  'scss': ['prettier'],
\  'svelte': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'typescriptreact': ['prettier', 'eslint'],
\  'yaml': ['prettier'],
\}

let g:ale_python_auto_poetry = 1

nmap <Leader>af <Plug>(ale_fix)
