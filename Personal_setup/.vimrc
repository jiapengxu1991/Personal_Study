" set up plugins manager
set nocompatible " required
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" solve some problem cause by the indents
Plugin 'tmhedberg/SimpylFold'
" fix indentatation issue cause by autoindent
Plugin 'vim-scripts/indentpython.vim'
" add indentation line
Plugin 'Yggdroot/indentLine'
" auto-complete plugin
Plugin 'ycm-core/YouCompleteMe'
" syntax checking
Plugin 'vim-syntastic/syntastic'
" PEP 8 checking
Plugin 'nvie/vim-flake8'
" colorscheme
Plugin 'morhetz/gruvbox'
" file tree
Plugin 'scrooloose/nerdtree'
" use tabs
Plugin 'jistr/vim-nerdtree-tabs'
" powerline
Plugin 'Lokaltog/vim-powerline'
" super search for file
Plugin 'ctrlpvim/ctrlp.vim'
" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on "required

" Personal setup 
com Py ! python3 %
set number " show the line numbers
"set hls " highlight search results
set tabstop=4 softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set nowrap " when content longer than one line, automatically change the line
set splitright " split the a window on the right
set splitbelow
set showmatch " show the matched bracket
" set the appearance of vim 
syntax on " show colors for syntax
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox " set color scheme
set background=dark

" set the configration of python file
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
" spot unwanted whitespace and then remove
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set encoding=utf-8

set clipboard+=unnamed " Yanks go on clipboard instead
" Enable folding code
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
" nnoremap <space> za
" autocmd vimenter * NERDTree " open nerdtree when open vim
let mapleader = " "
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>w :wincmd w<CR>
let g:SimpylFold_docstring_preview=1 " see the docstrings for folded code
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let python_highlight_all=1

" Setup for NERDTree
" let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" When set to 2, always focus file window after startup
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_smart_startup_focus=2

" Setup for the plugin YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_auto_trigger = 1
let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }
"nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
