" Map searching files with ag to Ctrl-f
nnoremap <c-f> :CtrlPag<cr>
vnoremap <c-f> :CtrlPagVisual<cr>

" Map general ag search to Ag
command! -nargs=1 Ag CtrlPagLocate(<f-args>)

" Use Ag for Ctrl+P command so that its much faster. Also enable a persistent
" cache.
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
