" Sheesh. Neovim sends `CTRL-@` (:h i_CTRL-@) when pressing <C-Space>. Can't
" repro this in vanilla vim, which inserts a space. It's annoying af when
" doing fast completions. Just make it a regular space pls.
if has('nvim')
  inoremap <C-Space> <Space>
endif

" Move visually instead of by line
noremap <expr> k      v:count == 0 ? 'gk' : 'k'
noremap <expr> j      v:count == 0 ? 'gj' : 'j'
noremap <expr> <Up>   v:count == 0 ? "g\<Up>" : "\<Up>"
noremap <expr> <Down> v:count == 0 ? "g\<Down>" : "\<Down>"

" Y does the same as yy by default, instead of being consistent
" with C, D (change/delete until end of line). I've began shooting
" myself in the foot without this one.
nnoremap Y y$

" These things happen too often
if has('nvim')
  command -bang X x
endif
command -bang W w
command -bang Q q
command -bang Qa qa

" Clear highlights in normal mode. After much fussing, C-c just
" seems like a really intuitive binding for this.
nnoremap <silent> <C-c> :noh<Cr>
nnoremap <silent> <Esc> :noh<Cr>

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

" buffer nav
nnoremap <Leader>bd :bdelete!<Cr>
tnoremap <Leader>bd <C-w>:bdelete!<Cr>
nnoremap <Leader>bh :hide<Cr>
tnoremap <Leader>bh <C-w>:hide<Cr>
nnoremap <Leader>bn :bnext<Cr>
tnoremap <Leader>bn <C-w>:bnext<Cr>
nnoremap <Leader>bp :bprevious<Cr>
tnoremap <Leader>bp <C-w>:bprevious<Cr>

" easy tag jumps
nnoremap <Leader>tj :tjump /
nnoremap <Leader>tp :ptjump /

" Yank current filename + line number to clipboard
nnoremap <silent> <Leader>fy :let @*=join([expand('%'), line('.')], ':')<Cr>
nnoremap <Leader>fn :sp <C-r>=expand('%:h')<Cr>

" Quickly create a new buffer in the current folder
nnoremap <Leader>nn :e <C-r>=expand('%:h')<Cr>/
nnoremap <Leader>ns :sp <C-r>=expand('%:h')<Cr>/
nnoremap <Leader>nt :tabe <C-r>=expand('%:h')<Cr>/
nnoremap <Leader>nv :vsp <C-r>=expand('%:h')<Cr>/

" quickly edit vimrc and color theme
nnoremap <Leader>ev :tabe $MYVIMRC<Cr>

" navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
