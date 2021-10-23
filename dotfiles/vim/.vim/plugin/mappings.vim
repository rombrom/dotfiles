" Move visually instead of by line
noremap <expr> k      v:count == 0 ? 'gk' : 'k'
noremap <expr> j      v:count == 0 ? 'gj' : 'j'
noremap <expr> <Up>   v:count == 0 ? "g\<Up>" : "\<Up>"
noremap <expr> <Down> v:count == 0 ? "g\<Down>" : "\<Down>"

" These things happen too often
command W w
command Q q

" Clear highlights in normal mode
nnoremap <silent> <C-c> :noh<Cr>

" <Tab> advances through the jumplist, so <S-Tab> moves backwards
nnoremap <S-Tab> <C-o>

" use `u` to undo, use `U` to redo
nnoremap U <C-r>

" make single quote work like backtick (e.g. go to column of mark, not
" beginning of line)
map ' `

" CTRL-U in insert mode deletes a lot. Put an undo-point before it.
inoremap <C-u> <C-g>u<C-u>

" autosuggest last spelling mistake in insert mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" primitive tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" easy tag jumps
nnoremap <Leader>tj :tjump /
nnoremap <Leader>tp :ptjump /

" Yank current filename + line number to clipboard
nnoremap <silent> <Leader>fy :let @*=join([expand('%'), line('.')], ':')<Cr>
nnoremap <Leader>fn :sp <C-r>=expand('%:h')<Cr>

" nnoremap <silent> <Leader>r normal :%s/<C-r>=expand('%:h')<Cr>

" Quickly create a new file in the current folder
nnoremap <Leader>s :saveas <C-r>=expand('%:h')<Cr>/

" quickly edit vimrc and color theme
nnoremap <Leader>ev :tabe $MYVIMRC<Cr>
nnoremap <Leader>ec :tabe $HOME/.vim/colors/fansi.vim<Cr>


" Plug '/usr/local/opt/fzf | Plug 'junegunn/fzf.vim'
"
nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>
nnoremap <C-o> :Tags<Cr>


" Plug 'tpope/vim-fugitive'
"
nnoremap <Leader>ga :G add %<Cr>
