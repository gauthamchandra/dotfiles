" Enable syntax highlighting
syntax on

" For Markdown (Github flavored) 
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" enabling hidden will allow the same window to be reused to switch 
" between multiple files without saving them and keep the undo history
" for each file. If the computer crashes, the swap files will be preserved for later saving
" This is sometimes not enabled and instead split panes/windows are used instead
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporaril turn off highlighting. 
" See the mapping of <C-L> below)
set hlsearch

" ============= Usability ================

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" If no file-type specific indenting is enabled, just use the indenting inherent to the file
set autoindent

" Show cursor position on the last line as well as the line number
set ruler
set number

" Always show the status line
set laststatus=2

" Enable use of the mouse for all modes
set mouse=a

" Use visual bell which will flash on the screen instead of beeping when doing something wrong
set visualbell

" Quickly timeout on the keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" =============== Indentation ==================

" Indentation using hard tabs or softtabs of 2 spaces 
set shiftwidth=2
set tabstop=2
set shiftround
set expandtab
