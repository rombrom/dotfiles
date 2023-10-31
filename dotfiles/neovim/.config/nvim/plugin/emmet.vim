" Plug 'mattn/emmet-vim'
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
