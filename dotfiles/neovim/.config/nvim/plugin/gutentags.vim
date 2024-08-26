let g:gutentags_file_list_command = {
\ 'markers': {
\     '.git': 'git ls-files',
\   }
\ }

augroup GutenTags
    autocmd!
    autocmd User GutentagsUpdating call ui#statusline()
    autocmd User GutentagsUpdated call ui#statusline()
augroup END
