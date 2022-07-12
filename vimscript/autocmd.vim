" Vimscipt configuration for neovim to be sourced from lua

" First, source utility functions
let dirpath = expand("<sfile>:p:h")
execute "source" dirpath . '/utils.vim'

" **********************************************************************
"                           Auto-Commands
" **********************************************************************
"
" Update date and time of last modification on writing buffer to file
autocmd BufWritePre * call LastModified()

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

" Startup program source code from skeleton files
autocmd BufNewFile *.c    0r  ~/.local/share/nvim/skeletons/skeleton.c
autocmd BufNewFile *.cpp  0r  ~/.local/share/nvim/skeletons/skeleton.cpp
autocmd BufNewFile *.py   0r  ~/.local/share/nvim/skeletons/skeleton.py
autocmd BufNewFile *.lua  0r  ~/.local/share/nvim/skeletons/skeleton.lua
autocmd BufNewFile *.sh   0r  ~/.local/share/nvim/skeletons/skeleton.sh

augroup PreciseTrimWhitespace
  autocmd!
  autocmd InsertLeave * call PreciseTrimWhitespace()
augroup end

" Use language-spedific plugins for indentation
filetype plugin indent on
