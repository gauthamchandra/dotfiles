" Let airline populate the powerline symbols
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

" Reduce timeout after pressing escape to something reasonable
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
