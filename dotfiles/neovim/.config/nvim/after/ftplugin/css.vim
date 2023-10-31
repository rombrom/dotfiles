setlocal include=^\s*@import
setlocal includeexpr=expand('<cfile>:p:h').'/_'.expand('<cfile>:t')
"
" Make dash-delimited words count as words in styling languages
setlocal suffixesadd+=.css,.less,.sass,.scss,.styl

if executable('prettier')
  setlocal formatexpr=
  setlocal formatprg=prettier\ --stdin-filepath=%
endif
