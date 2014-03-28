filetype off
execute pathogen#infect()
"call pathogen#incubate()
"call pathogen#helptags()
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
set listchars=tab:\¦\ 

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
nnoremap <leader>1 :tabmove 0<CR>
nnoremap <leader>2 :tabmove 1<CR>
nnoremap <leader>3 :tabmove 2<CR>
nnoremap <leader>4 :tabmove 3<CR>
nnoremap <leader>5 :tabmove 4<CR>
nnoremap <leader>6 :tabmove 5<CR>
nnoremap <leader>7 :tabmove 6<CR>
nnoremap <leader>8 :tabmove 7<CR>
nnoremap <leader>9 :tabmove 8<CR>
nnoremap <leader>0 :tabmove 9<CR>

" Remove that fucking ^M
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle line number & list
nnoremap <F2> :set nonumber!<CR><BAR>:set norelativenumber!<CR><BAR>:set nolist!<CR>

" Toggle paste mode
nnoremap <F3> :set paste!<CR>

" Remember last edit position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
set viminfo^=%

set tabline=%!SetTabLine()

function! SetTabLine()
    " NOTE: left/right padding of each tab was hard coded as 1 space.
    " NOTE: require Vim 7.3 strwidth() to display fullwidth text correctly.

    " settings
    let tabMinWidth = 0
    let tabMaxWidth = 40
    let tabMinWidthResized = 15
    let tabScrollOff = 5
    let tabEllipsis = '…'
    let tabDivideEquel = 0

    let s:tabLineTabs = []

    let tabCount = tabpagenr('$')
    let tabSel = tabpagenr()

    " fill s:tabLineTabs with {n, filename, split, flag} for each tab
    for i in range(tabCount)
        let tabnr = i + 1
        let buflist = tabpagebuflist(tabnr)
        let winnr = tabpagewinnr(tabnr)
        let bufnr = buflist[winnr - 1]

        let filename = bufname(bufnr)
        let filename = fnamemodify(filename, ':p:t')
        let buftype = getbufvar(bufnr, '&buftype')
        if filename == ''
            if buftype == 'nofile'
                let filename .= '[Scratch]'
            else
                let filename .= '[New]'
            endif
        endif
        let split = ''
        let winCount = tabpagewinnr(tabnr, '$')
        if winCount > 1   " has split windows
            let split .= winCount
        endif
        let flag = ''
        if getbufvar(bufnr, '&modified')  " modified
            let flag .= '+'
        endif
        if strlen(flag) > 0 || strlen(split) > 0
            let flag .= ' '
        endif

        call add(s:tabLineTabs, {'n': tabnr, 'split': split, 'flag': flag, 'filename': filename})
    endfor

    " variables for final oupout
    let s = ''
    let l:tabLineTabs = deepcopy(s:tabLineTabs)

    " overflow adjustment
    " 1. apply min/max tabWidth option
    if s:TabLineTotalLength(l:tabLineTabs) > &columns
        unlet i
        for i in l:tabLineTabs
            let tabLength = s:CalcTabLength(i)
            if tabLength < tabMinWidth
                let i.filename .= repeat(' ', tabMinWidth - tabLength)
            elseif tabMaxWidth > 0 && tabLength > tabMaxWidth
                let reserve = tabLength - StrWidth(i.filename) + StrWidth(tabEllipsis)
                if tabMaxWidth > reserve
                    let i.filename = StrCrop(i.filename, (tabMaxWidth - reserve), '~') . tabEllipsis
                endif
            endif
        endfor
    endif
    " 2. try divide each tab equal-width
    if tabDivideEquel
        if s:TabLineTotalLength(l:tabLineTabs) > &columns
            let divideWidth = max([tabMinWidth, tabMinWidthResized, &columns / tabCount, StrWidth(tabEllipsis)])
            unlet i
            for i in l:tabLineTabs
                let tabLength = s:CalcTabLength(i)
                if tabLength > divideWidth
                    let i.filename = StrCrop(i.filename, divideWidth - StrWidth(tabEllipsis), '~') . tabEllipsis
                endif
            endfor
        endif
    endif
    " 3. ensure visibility of current tab 
    let rhWidth = 0
    let t = tabCount - 1
    let rhTabStart = min([tabSel - 1, tabSel - tabScrollOff])
    while t >= max([rhTabStart, 0])
        let tab = l:tabLineTabs[t]
        let tabLength = s:CalcTabLength(tab)
        let rhWidth += tabLength
        let t -= 1
    endwhile
    while rhWidth >= &columns
        let tab = l:tabLineTabs[-1]
        let tabLength = s:CalcTabLength(tab)
        let lastTabSpace = &columns - (rhWidth - tabLength)
        let rhWidth -= tabLength
        if rhWidth > &columns
            call remove(l:tabLineTabs, -1)
        else
            " add special flag (will be removed later) indicating that how many
            " columns could be used for last displayed tab.
            if tabSel <= tabScrollOff || tabSel < tabCount - tabScrollOff
                let tab.flag .= '>' . lastTabSpace
            endif
        endif
    endwhile

    " final ouput
    unlet i
    for i in l:tabLineTabs
        let tabnr = i.n

        let split = ''
        if strlen(i.split) > 0
            if tabnr == tabSel
                let split = '%#TabLineSplitNrSel#' . i.split .'%#TabLineSel#'
            else
                let split = '%#TabLineSplitNr#' . i.split .'%#TabLine#'
            endif
        endif

        let text = ' ' . split . i.flag . i.filename . ' '

        if i.n == l:tabLineTabs[-1].n
            if match(i.flag, '>\d\+') > -1 || i.n < tabCount
                let lastTabSpace = matchstr(i.flag, '>\zs\d\+')
                let i.flag = substitute(i.flag, '>\d\+', '', '')
                if lastTabSpace <= strlen(i.n)
                    if lastTabSpace == 0
                        let s = strpart(s, 0, strlen(s) - 1)
                    endif
                    let s .= '%#TabLineMore#>'
                    continue
                else
                    let text = ' ' . i.split . i.flag . i.filename . ' '
                    let text = StrCrop(text, (lastTabSpace - strlen(i.n) - 1), '~') . '%#TabLineMore#>'
                    let text = substitute(text, ' ' . i.split, ' ' . split, '')
                endif
            endif
        endif

        let s .= '%' . tabnr . 'T'  " start of tab N

        if tabnr == tabSel
            let s .= '%#TabLineNrSel#' . tabnr . '%#TabLineSel#'
        else
            let s .= '%#TabLineNr#' . tabnr . '%#TabLine#'
        endif

        let s .= text

    endfor

    let s .= '%#TabLineFill#%T'
    return s
endf

function! s:CalcTabLength(tab)
    return strlen(a:tab.n) + 2 + strlen(a:tab.split) + strlen(a:tab.flag) + StrWidth(a:tab.filename)
endf

function! s:TabLineTotalLength(dict)
    let length = 0
    for i in (a:dict)
        let length += strlen(i.n) + 2 + strlen(i.split) + strlen(i.flag) + StrWidth(i.filename)
    endfor
    return length
endf

" }}}2   字串長度（column 數）   {{{2
function StrWidth(str)
    if exists('*strwidth')
        return strwidth(a:str)
    else
        let strlen = strlen(a:str)
        let mstrlen = strlen(substitute(a:str, ".", "x", "g"))
        if strlen == mstrlen
            return strlen
        else
            " Note: 暫不處理全形字（以下值不正確）
            return strlen
        endif
    endif
endf

" }}}2   依字串長度（column 數）裁切多餘文字   {{{2
function! StrCrop(str, len, ...)
    let l:padChar = a:0 > 0 ? a:1 : ' '
    if exists('*strwidth')
        let text = substitute(a:str, '\%>' . a:len . 'c.*', '', '')
        let remainChars = split(substitute(a:str, text, '', ''), '\zs')
        while strwidth(text) < a:len
            let longer = len(remainChars) > 0 ? (text . remove(remainChars, 0)) : text
            if strwidth(longer) < a:len
                let text = longer
            else
                let text .= l:padChar
            endif
        endwhile
        return text
    else
" Note: 暫不處理全形字（以下值不正確）
        return substitute(a:str, '\%>' . a:len . 'c.*', '', '')
    endif
endf

hi TabLine           cterm=underline ctermfg=15    ctermbg=242   gui=underline guibg=#6c6c6c guifg=White
hi TabLineSel        cterm=bold      gui=NONE      guifg=White
hi TabLineNr         cterm=underline ctermbg=238   guibg=#444444
hi TabLineNrSel      cterm=bold      ctermfg=45    guifg=#00d7ff
hi TabLineFill       cterm=reverse   gui=reverse
hi TabLineMore       cterm=underline ctermfg=White ctermbg=236   gui=underline guifg=White   guibg=#303030
hi TabLineSplitNr    cterm=underline ctermfg=148 ctermbg=240   gui=underline,italic guifg=#afd700   guibg=#6c6c6c
hi TabLineSplitNrSel cterm=NONE      ctermfg=148 ctermbg=236   gui=NONE,italic      guifg=#afd700   guibg=#303030
