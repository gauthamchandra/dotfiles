function! MyHighlights() abort
  highlight Visual term=reverse cterm=reverse guibg=#040404
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

colorscheme tender
