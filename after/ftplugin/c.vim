setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal textwidth=78

" C Comment
" ";cc" mapped to insert a multiline comment in C source files in INSERT mode
" textwidth is taken to be 80 characters
imap <Leader>cc /<C-o>78a*<Esc>o<C-o>76a*<Esc>a/<Esc>ko
