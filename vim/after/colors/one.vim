" overrides for the `vim-one` colorscheme 
" The colorscheme doesn't set sane menu colors 
" so we will set them ourselves
" - translates to:
"   - menu item (unselected)
"     - foreground: #080808
"     - background: #dadada
"   - menu item (selected)
"     - foreground: #ffffff
"     - background: #585858
highlight Pmenu ctermfg=232 ctermbg=253
highlight PmenuSel ctermfg=231 ctermbg=240
