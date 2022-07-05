" vimscript utility functions
" sourced by autocmd.vim

" Remove trailing whitespace without moving cursor
function! PreciseTrimWhitespace()
  --> Trim trailing whitespace
  let savedView = winsaveview()
  keepjumps '[,']s/\s+\+$//e
  call winrestview(savedView)

  --> Remove trailing blank lines
  let saveCursor = getpos(".")
  silent! %s#\($\n\s*\)\+\%$##
  call setpos(".", saveCursor)
endfunction

" Update date and time of last modification of in a given file
function UpdateLastMod()
  if line("$") > 10
    let l = 10
  else
    let l = line("$")
  endif
  execute "1," . l . "g/Last modified on /s/Last modified on .*/Last modified on " .
        \ strftime("%b %d %Y at %H:%M")
endfunction
