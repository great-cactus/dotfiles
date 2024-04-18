let mapleader="\<Space>"

augroup MyAutoCmd
    autocmd!
augroup END

" dein scripts ---------------------------------------------------
set nocompatible
let s:dein_base = '~/.cache/dein'->expand()
let s:dein_src = s:dein_base . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_src

if dein#load_state(s:dein_base)
    call dein#begin(s:dein_base)

    let s:toml      = s:dein_base . '/dein.toml'
    let s:lazy_toml = s:dein_base . '/dein_lazy.toml'

    call dein#load_toml(s:toml     , {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#add(s:dein_src)

    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
 call dein#install()
endif

if has('filetype')
    filetype indent plugin on
endif

if has('syntax')
    syntax enable
endif
" end dein ---------------------------------------------------

"""OMAJINAI
set t_u7=
set t_RV=
set belloff=all
set backspace=indent,eol,start
"Tab settings
set tabstop=4
set shiftwidth=4
set expandtab
"Indent settings
set autoindent
set smartindent
"Search settings
set ignorecase
set wrapscan
set showmatch
set hlsearch
set smartcase
"Display settings
set t_Co=256
set laststatus=2
set number
set relativenumber
set display=lastline
set virtualedit=onemore
set wildmode=list:longest
"Highlightning tab, trail...ect
set list
set listchars=tab:^\ ,trail:~
"---> Color scheme
set background=light
colorscheme iceberg
"----> End Color scheme

"Mapping
noremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

nnoremap <Leader>s :%s/
nnoremap <Leader>t :tabe 

nnoremap <Leader>4 $
nnoremap <Leader>5 %

"Complement?
set completeopt=menuone

function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
endfunction

if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \ exe "normal! g'\"" |
    \ endif
endif

" change for US keybord
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" change for cursor move
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" Get full path of current file
command!FileNameFull :call s:FileNameFull()
function! s:FileNameFull()
    let @* = expand('%:p')
    let @" = expand('%:p')
endfunction
" map FileNameFull to <leader>y
nnoremap <silent> <leader>fy :FileNameFull<CR>

" python
nnoremap <F5> :!python % <Enter>

" clipboard
set clipboard&
set clipboard=unnamedplus

" yank registers
nnoremap x "_x
vnoremap x "_x

" terminal mode
nnoremap <silent> tt <cmd>terminal<CR>
nnoremap <silent> tx <cmd>belowright new<CR><cmd>terminal<CR>
autocmd TermOpen * :startinsert
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
tnoremap <Esc> <C-\><C-n>

augroup KeepLastPosition
    au BufRead * if line("`\"") > 0 && line("`\"") <= line("$") | exe "normal g`\"" | endif
augroup END

if has('persistent_undo')
    set undodir=./.vimundo,~/.vimundo
    augroup SaveUndoFile
        autocmd!
        autocmd BufReadPre ~/* setlocal undofile
    augroup END
endif

augroup VimCheckTime
    autocmd!
    autocmd InsertEnter, WinEnter * checktime
augroup END
