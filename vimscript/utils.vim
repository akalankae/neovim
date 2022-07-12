" vimscript utility functions
" sourced by autocmd.vim

" **********************************************************************
"                         Utility functions
" **********************************************************************
"
" Remove trailing whitespace and newlines without moving cursor
function! PreciseTrimWhitespace()
  " --> Trim trailing whitespace
  let savedView = winsaveview() "#1
  keepjumps '[,']s/\s+\+$//e    "#2
  call winrestview(savedView)   "#3

  " --> Remove trailing blank lines
  let saveCursor = getpos(".")  "#4
  silent! %s#\($\n\s*\)\+\%$##  "#5
  call setpos(".", saveCursor)  "#6
endfunction

" Update timestamp
" If buffer is modified, update any 'Last modified: ' in the first 10 lines.
" 'Last modified: ' can have upto 10 leading characters (they are retained).
" Restores cursor and window position using save_cursor variable.
" [From https://vim.fandom.com/wiki/Insert_current_date_or_time]
function LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([10, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%b %d, %Y %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfunction
