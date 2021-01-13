" Enable jsx syntax highlighting in .js files
let g:jsx_ext_required = 0

" Disable typescript-vim custom indenter in favor of Prettier
let g:typescript_indent_disable = 1

augroup SyntaxSettings
    autocmd!

    " Both is handled by the plugin: 'peitalin/vim-jsx-typescript'
    autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
    "autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
augroup END

"" Setup TSX/JSX Highlighting of colors
"" dark red
"hi tsxTagName guifg=#E06C75
"hi tsxComponentName guifg=#E06C75
"hi tsxCloseComponentName guifg=#E06C75
"
"" orange
"hi tsxCloseString guifg=#F99575
"hi tsxCloseTag guifg=#F99575
"hi tsxCloseTagName guifg=#F99575
"hi tsxAttributeBraces guifg=#F99575
"hi tsxEqual guifg=#F99575
"
"" yellow
"hi tsxAttrib guifg=#F8BD7F cterm=italic
"
"" light-grey
"hi tsxTypeBraces guifg=#999999
"" dark-grey
"hi tsxTypes guifg=#666666
