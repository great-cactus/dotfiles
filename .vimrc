"OMAJINAI
set t_u7=
set t_RV=
set belloff=all
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
set display=lastline
set virtualedit=onemore
set wildmode=list:longest
set background=light
syntax on
" set vim's background same as terminal's
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LinerNr ctermbg=none
colorscheme PaperColor
"Highlightning tab, trail...ect
set list
set listchars=tab:^\ ,trail:~

"Mapping
noremap <Esc><Esc> :nohlsearch<CR><Esc>
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

let mapleader="\<Space>"
noremap <Leader>s :%s/

"Complement?
set completeopt=menuone

"High-lightning when insert mode
let g:hi_insert = 'highlight StatusLine ctermbg=magenta'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    set cursorline
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    set nocursorline
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

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
vnoremap : :
vnoremap : ;

" fzf
let $FZF_DEFAULT_OPTS="--layout=reverse"
"let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset':0.5, 'border': 'sharp' }}
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>G :GFiles?<CR>
nnoremap <silent> <leader>b :Buffer<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>r :Rg<CR>

" Get full path of current file
command!FileNameFull :call s:FileNameFull()
function! s:FileNameFull()
    let @* = expand('%:p')
    let @" = expand('%:p')
endfunction
" map FileNameFull to <leader>y
nnoremap <silent> <leader>y :FileNameFull<CR>

" python
nnoremap <F5> :!python % <Enter>

" clipboard
set clipboard=unnamedplus

" vim-jetpack
packadd vim-jetpack
call jetpack#begin()
    Jetpack 'tani/vim-jetpack', {'opt' : 1} " bootstrap
    Jetpack 'tpope/vim-surround'
    Jetpack 'mechatroner/rainbow_csv'
    Jetpack 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Jetpack 'junegunn/fzf.vim'
call jetpack#end()
