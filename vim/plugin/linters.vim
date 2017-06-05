" Linting config

" Make Neomake run linters on every save
augroup neomake
  autocmd! BufWritePost * Neomake
augroup END

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_ruby_enabled_markers = ['rubocop']
let g:neomake_vim_enabled_markers = ['vint']

let rubocop_config = '/Users/gautham.chandra/development/greenhouse/.rubocop.yml'
let g:neomake_ruby_rubocop_maker = { 'args': ['-c', rubocop_config] }
