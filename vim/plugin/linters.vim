" Linting config

" Make Neomake run linters on every save
augroup neomake
  autocmd! BufWritePost * Neomake
augroup END

" Open the issue list by default
let g:neomake_open_list=0

" Enable the relevant linters
let g:neomake_javascript_enabled_makers = ['eslint', 'flow']
let g:neomake_jsx_enabled_makers = ['eslint', 'flow']
let g:neomake_vim_enabled_markers = ['vint']
let g:neomake_swift_enabled_makers = ['swiftc', 'swiftpm', 'swiftpmtest']
let g:neomake_logfile = '/usr/local/var/log/neomake.log'
