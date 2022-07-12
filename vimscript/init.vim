" init.vim
" Some initializations in vimscript
" Code here is duplicated in utils.vim and autocmd.vim

" Startup program source code from skeleton files
autocmd BufNewFile *.c    0r  ~/.local/share/nvim/skeletons/skeleton.c
autocmd BufNewFile *.cpp  0r  ~/.local/share/nvim/skeletons/skeleton.cpp
autocmd BufNewFile *.py   0r  ~/.local/share/nvim/skeletons/skeleton.py
autocmd BufNewFile *.lua  0r  ~/.local/share/nvim/skeletons/skeleton.lua
autocmd BufNewFile *.sh   0r  ~/.local/share/nvim/skeletons/skeleton.sh

" From https://vim.fandom.com/wiki/Insert_current_date_or_time
" If buffer is modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have upto 10 leading characters (they are retained).
" Restores cursor and window position using save_cursor variable.
function LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfunction
autocmd BufWritePre * call LastModified()
