filetype plugin on
filetype indent on

set nocompatible
filetype off
set autoread

set incsearch
set nolazyredraw
set hlsearch

set magic

syntax enable

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set showcmd
set showmatch
set pastetoggle=<F3>
set tabpagemax=100

set ai
set si
set so=7

set number
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
au BufNewFile,BufRead *.rs setf rust
au BufRead,BufNewFile *.avdl setlocal filetype=avro-idl
au BufRead,BufNewFile *.gen,*.gradle setlocal filetype=groovy
au BufRead,BufNewFile *.md setlocal filetype=markdown
"let g:Powerline_symbols = 'unicode'
let g:airline_powerline_fonts = 1

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set noswapfile

set wildignore=*.hi,*.o,*.pyc

set background=dark
colorscheme solarized

" Press Space to turn off highlighting and clear any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
:nnoremap <silent> <F1> :tabedit note:todo<CR>
:nnoremap <silent> <F2> :NERDTreeToggle<CR>
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

let mapleader = ","
map <leader>j :!python -m json.tool<cr>
set backspace=indent,eol,start

set autochdir
call pathogen#infect()
call pathogen#helptags()
call pathogen#incubate()

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes':[], 'passive_filetypes':[] }
let g:syntastic_auto_jump = 1
:nnoremap <leader>. :SyntasticCheck ghc_mod hlint<cr>

ab pcore package com.palantir.reservoir.spark.core
ab pdriz package com.palantir.reservoir.spark.drizzy
ab pston package com.palantir.reservoir.spark.drizzy
