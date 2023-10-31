augroup Misc
  autocmd!
  " Return to last edit position when opening files
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g'\" zz" |
    \ endif

  " Create dir on save if it doesn't exist
  " TODO: this trips up the lcd switching?
  autocmd BufWritePre * call utils#mkdirp(expand('<afile>'), +expand('<abuf>'))

  " undo shell command errors
  autocmd ShellFilterPost * if v:shell_error | undo | endif

  " auto insert mode
  autocmd TermOpen * startinsert
augroup END
