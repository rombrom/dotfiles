setlocal include=^\s*@import
setlocal includeexpr=expand('<cfile>:p:h').'/_'.expand('<cfile>:t')
" Make dash-delimited words count as words in styling languages
setlocal iskeyword+=-
setlocal suffixesadd+=.css,.less,.sass,.scss,.styl

" init ale mappings, etc.
call init#webdev()
