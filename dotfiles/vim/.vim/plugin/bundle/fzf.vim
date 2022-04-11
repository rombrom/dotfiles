" Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '40%' }
let g:fzf_tags_command = '.git/hooks/ctags || ctags -R --tag-relative'

augroup Fzf
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>
nnoremap <C-o> :Tags<Cr>
nnoremap <Leader>bb :Buffers<Cr>
tnoremap <Leader>bb <C-w>:Buffers<Cr>
