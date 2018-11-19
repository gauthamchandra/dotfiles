call deoplete#enable()

augroup deoplete_config
  " Don't bother enabling autocomplete for these filetypes
  autocmd FileType vim let b:deoplete_disable_auto_complete = 1
  autocmd FileType javascript let b:deoplete_disable_auto_complete = 1
  autocmd FileType javascript.jsx let b:deoplete_disable_auto_complete = 1
  autocmd FileType gitcommit let b:deoplete_disable_auto_complete = 1

  call deoplete#custom#source('dictionary', 'min_pattern_length', 3)
  call deoplete#custom#option('auto_complete_delay', 500)
augroup END
