" Set lightline theme for statusbar and tell tmux status to match
let g:lightline = {
  \ 'colorscheme': 'one',
  \ }
Tmuxline lightline

" Reduce timeout after pressing escape to something reasonable
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
