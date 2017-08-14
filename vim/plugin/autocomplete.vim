" Basic autocomplete config to make it behave more like an IDE
" @see: http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE

" Set the options so that:
" - the autocomplete options are filtered to where the cursor is
" - even if there is only 1 item, the autocomplete menu shows up
set completeopt=longest,menuone

" Allow tab and enter to select the first item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>\<C-y>" : "\<Tab>"

" When the menu opens, autoselect the first item so something is always
" selected. This makes it easier to 'tab' it to completion
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Remap the navigation of the popup menu to work with Ctrlp mappings
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
