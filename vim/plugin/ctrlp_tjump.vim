" remap these to use Ctrlptjump for 'Jump to declaration' functionality
nnoremap <c-]> :CtrlPtjump<CR>
vnoremap <c-]> :CtrlPtjumpVisual<CR>

" Don't open the ctrlp window if only 1 tag exists. Just open that file
let g:ctrlp_tjump_only_silent = 1

" Don't show tag name as it takes up screen real-estate
let g:ctrlp_tjump_skip_tag_name = 1
