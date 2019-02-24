" Disable gutentags for git commit and rebases due to a bug
augroup gutentag_overrides
  autocmd FileType gitcommit,gitrebase let g:gutentags_enabled=0
augroup end

