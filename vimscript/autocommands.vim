" Vimscipt configuration for neovim to be sourced from lua

" Switch between absolute and relative line numbers upon entering & leaving neovim.
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Map <Escape> to <CapsLock>
" CAUTION: If you exit a single vim buffer while one/more vim buffers remain open,
" this <Esc> to <CapsLock> mapping will be disabled for those opened buffers.
autocmd VimEnter * silent! !xmodmap -e "clear Lock" -e "keycode 0x42 = Escape"
autocmd VimLeave * silent! !xmodmap -e "clear Lock" -e "keycode 0x42 = Caps_Lock"

" auto-pairs for python F-strings and raw-strings
autocmd FileType python let b:AutoPairs = AutoPairsDefine({ "f'" : "'", "r'" : "'" })
autocmd FileType html,xml let b:AutoPairs = AutoPairsDefine({ "<" : ">" })

" Auto-complete HTML tags with omnicomplete
autocmd FileType html inoremap </ </<C-x><C-o>

" Remove trailing whitespace & blank lines
autocmd FileType python,c,cpp,lua,vim autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType python,c,cpp,lua,vim autocmd BufWritePre <buffer> %s/\($\n\s*\)\+\%$//e

" Use language-spedific plugins for indentation
filetype plugin indent on

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

" " This does not work
" augroup UpdateLastMod
"   autocmd!
"   autocmd FileType lua autocmd BufWritePre <buffer> <SID>UpdateLastMod()<CR>
" augroup END

" Use skeleton file for lua
autocmd BufNewFile *.lua 0read $NVIM_DATA_DIR/templates/template.lua
autocmd BufNewFile *.c   0read $NVIM_DATA_DIR/templates/template.c
autocmd BufNewFile *.py  0read $NVIM_DATA_DIR/templates/template.py
