" My Beloved Vimrc file.

let s:running_neovim = 0 
if has('nvim')
  let s:running_neovim = 1 
end

" enable clipboard register
" but only do so if not inside tmux as it has its own clipboard buffer logic
set clipboard+=unnamedplus

" Change tabs to spaces so everything is consisent formatting wise
set expandtab

" the plugin manager installation and some of the plugins themselves are meant for neovim, not vanilla vim
" so don't run this if running in plain vim
if s:running_neovim 
  " Install vim-plug if not found
  " See here if it fails: https://github.com/junegunn/vim-plug#unix
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  " Needed for Plug (a plugin manager)
  " Specifying directory for plugins
  call plug#begin('~/.local/share/nvim/plugged')
  
  " My Plugins
  
  " Editor stuff (autocomplete, editor config, etc.)
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-eslint'
  Plug 'leafgarland/typescript-vim'
  Plug 'artur-shaik/vim-javacomplete2'
  Plug 'prettier/vim-prettier', { 'do': 'npm  install' }
  Plug 'tpope/vim-commentary'
  
  " Search, Browsing and files
  Plug 'scrooloose/nerdtree' 
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'ivalkeen/vim-ctrlp-tjump'
  Plug 'lokikl/vim-ctrlp-ag'
  
  " got git?
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  
  " For nicer status line UI and theme
  Plug 'itchyny/lightline.vim'
  Plug 'edkolev/tmuxline.vim'
  Plug 'jacoborus/tender.vim'
  
  " For proper syntax highlighting 
  "Plug 'pangloss/vim-javascript'
  " Use the above line one this PR is merged: https://github.com/leafgarland/typescript-vim/pull/171
  Plug 'iwikal/typescript-vim', { 'branch': 'typescriptreact' }
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'keith/swift.vim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'satabin/hocon-vim'

  " Utils
  Plug 'AndrewRadev/linediff.vim'
  
  " All vim-plug plugins should be before this!
  " Initialize plugin system
  call plug#end()
end

