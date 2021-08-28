augroup Misc
  autocmd!
  " Return to last edit position when opening files
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

  " Wrap lines in file currently being edited (the horizontal scrolling
  " trips me up...) and nowrap when we leave
  autocmd BufEnter * setlocal wrap
  autocmd BufLeave * setlocal nowrap

  " Create dir on save if it doesn't exist
  " TODO: this trips up the lcd switching?
  autocmd BufWritePre * call init#mkdirp(expand('<afile>'), +expand('<abuf>'))

  " Hack to make <C-x><C-f> work with files relative to current buffer
  autocmd InsertEnter * let cwd = getcwd() |
        \ if isdirectory(expand('%:p:h')) | lcd %:p:h | endif
  autocmd InsertLeave * execute 'lcd' fnameescape(cwd)

  " undo shell command errors
  autocmd ShellFilterPost * if v:shell_error | undo | endif

  " auto load vimrc
  autocmd BufRead vimrc,fansi.vim setlocal foldmethod=marker |
    \ lcd ~/Code/mac-setup |
    \ nnoremap <buffer> <Leader>ev :bd<Cr>
  autocmd BufWritePost vimrc,fansi.vim source $MYVIMRC
augroup END
