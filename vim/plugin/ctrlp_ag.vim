" Map searching files with ag to Ctrl-f
nnoremap <c-f> :CtrlPag<cr>
vnoremap <c-f> :CtrlPagVisual<cr>

" Map general ag search to Ag
command! -nargs=1 Ag CtrlPagLocate(<f-args>)
