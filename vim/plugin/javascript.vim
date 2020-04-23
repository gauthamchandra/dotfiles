" Enable jsx syntax highlighting in .js files
let g:jsx_ext_required = 0

" Disable typescript-vim custom indenter in favor of Prettier
let g:typescript_indent_disable = 1

augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript
augroup END
