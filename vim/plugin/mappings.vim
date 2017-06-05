" =============== Mappings =====================

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <C-T> :NERDTreeToggle<CR>
nnoremap <Space> :NERDTree %<CR>

" For easier window management 
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
nnoremap  <Up>     <C-w>k
nnoremap  <Down>   <C-w>j
nnoremap  <Left>   <C-w>h
nnoremap  <Right>  <C-w>l
