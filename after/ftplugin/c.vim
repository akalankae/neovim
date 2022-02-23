setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

" C Comment
" ";cc" mapped to insert a multiline comment in C source files in INSERT mode
" textwidth is taken to be 84 characters (newline in 85th column)
imap <Leader>cc /<C-o>83a*<Esc>o<C-o>81a*<Esc>a/<Esc>ko
