filetype off
"execute pathogen#infect()
call pathogen#incubate()
call pathogen#helptags()
filetype plugin indent on
set nocompatible
set modelines=0

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" General
set t_Co=256
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set relativenumber
set autoread
set history=700
set ffs=unix,dos,mac

" Undo
set undodir=~/.vim/undo
set undofile
set undolevels=100
set undoreload=10000

" We need color
syntax on
set background=dark
"colorscheme distinguished
"colorscheme molokai

" Solarized
let g:solarized_termcolors=256
let g:solarized_visibility="low"
let g:solarized_termtrans=1
colorscheme solarized

" Customized statusline
hi User1 ctermfg=208 ctermbg=235 guifg=#eea040 guibg=#073642
hi User2 ctermfg=196 ctermbg=235 guifg=#dd3333 guibg=#073642
hi User3 ctermfg=207 ctermbg=235 guifg=#ff66ff guibg=#073642
hi User4 ctermfg=118 ctermbg=235 guifg=#a0ee40 guibg=#073642
hi User5 ctermfg=226 ctermbg=235 guifg=#eeee40 guibg=#073642
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

" But we don't need backups
set nobackup
set nowb
set noswapfile

" Our leader is comma
let mapleader = ","

" Searching~
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

"nnoremap <tab> %
"vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

set list
"set listchars=tab:►\ ,eol:¬
set listchars=tab:>-

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

nnoremap ; :
vnoremap ; :

" Escape from insert mode quickly
inoremap jj <ESC>

" No trailing white spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" NERDTree hotkeys
nnoremap <leader>n :NERDTree<cr>
"inoremap <leader>n <ESC>:NERDTree<cr>
nnoremap <silent> <F5> :NERDTree<cr>
"inoremap <silent> <F5> <ESC>:NERDTree<cr>

" YankRing hotkeys
nnoremap <silent> <F6> :YRShow<cr>
inoremap <silent> <F6> <ESC>:YRShow<cr>
nnoremap <leader>v V`]

" Conque hotkeys
nnoremap <leader>c :ConqueTermSplit bash<cr>
nnoremap <leader>cv :ConqueTermVSplit bash<cr>
nnoremap <leader>ct :ConqueTermTab bash<cr>
nnoremap <silent> <F7> :ConqueTermVSplit bash<cr>
inoremap <silent> <F7> :ConqueTermVSplit bash<cr>

nnoremap <leader>a= :Tabularize /=<cr>
vnoremap <leader>a= :Tabularize /=<cr>
nnoremap <leader>a: :Tabularize /:\zs<cr>
vnoremap <leader>a: :Tabularize /:\zs<cr>

" Edit .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Split window
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab pages
nnoremap <leader>h gT
nnoremap <leader>l gt
nnoremap <leader>e :tabedit 

" Remove that fucking ^M
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle line number & list
nnoremap <F2> :set nonumber!<CR><BAR>:set norelativenumber!<CR><BAR>:set nolist!<CR>

" Remember last edit position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
set viminfo^=%
