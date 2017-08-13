call deoplete#enable()

augroup deoplete_config
  " Don't bother enabling autocomplete for these filetypes
  autocmd FileType vim let b:deoplete_disable_auto_complete = 1
  autocmd FileType javascript let b:deoplete_disable_auto_complete = 1
  autocmd FileType javascript.jsx let b:deoplete_disable_auto_complete = 1
  autocmd FileType gitcommit let b:deoplete_disable_auto_complete = 1
augroup END
