let g:gutentags_file_list_command = {
\ 'markers': {
\     '.git': 'git ls-files',
\   }
\ }

augroup GutenTags
    autocmd!
    autocmd User GutentagsUpdating call init#statusline()
    autocmd User GutentagsUpdated call init#statusline()
augroup END
