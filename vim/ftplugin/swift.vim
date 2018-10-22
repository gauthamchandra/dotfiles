" Lots of swift projects use an indentation of 4 spaces instead of the default
" of 2
setlocal shiftwidth=4
setlocal tabstop=4

let g:deoplete#sources#swift#source_kitten_binary = '/usr/local/bin/sourcekitten'
let g:deoplete#sources#swift#daemon_autostart = 1

augroup swift 
  autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
  au FileType swift nmap <C-S-r> :AsyncRun swiftrun<cr>
  au FileType swift nmap <C-S-k> :AsyncRun swifttest<cr>
augroup END
