let s:cwd = getcwd()

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

  " Hack to make <C-x><C-f> work with files relative to current buffer
  " autocmd InsertEnter * if isdirectory(expand('%:p:h')) | lcd %:p:h | endif
  " autocmd InsertLeave * execute 'lcd' fnameescape(s:cwd)

  " undo shell command errors
  autocmd ShellFilterPost * if v:shell_error | undo | endif

  " auto load vimrc
  autocmd BufRead ~/Code/mac-setup/dotfiles/vim/.vim/**
        \ setlocal foldmethod=marker | lcd ~/Code/mac-setup

  autocmd BufWritePost ~/Code/mac-setup/dotfiles/vim/.vim/** source %
augroup END
