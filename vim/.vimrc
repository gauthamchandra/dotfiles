" My Beloved Vimrc file.

let s:running_neovim = 0 
if has('nvim')
  let s:running_neovim = 1 
end

" enable clipboard register
" but only do so if not inside tmux as it has its own clipboard buffer logic
if $TMUX ==? ''
  set clipboard=unnamedplus
endif

" the plugin manager installation and some of the plugins themselves are meant for neovim, not vanilla vim
" so don't run this if running in plain vim
if s:running_neovim 
  " Needed for Plug (a plugin manager)
  " Specifying directory for plugins
  call plug#begin('~/.local/share/nvim/plugged')
  
  " My Plugins
  
  " Editor stuff (autocomplete, editor config, etc.)
  Plug 'neomake/neomake'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'fishbullet/deoplete-ruby'
  
  " Search, Browsing and files
  Plug 'scrooloose/nerdtree' 
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'ivalkeen/vim-ctrlp-tjump'
  
  " got git?
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  
  " For nicer status line UI and theme
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'edkolev/tmuxline.vim'
  Plug 'rakr/vim-one'
  
  " For proper syntax highlighting 
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  
  " All vim-plug plugins should be before this!
  " Initialize plugin system
  call plug#end()
end
