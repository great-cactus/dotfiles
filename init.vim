" dein scripts ---------------------------------------------------
" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

""augroup MyAutoCmd
""    autocmd!
""augroup END

" Set Dein base path (required)
let s:dein_base = '/home/tnd/.cache/dein'
" Set Dein source path (required)
let s:dein_src = '/home/tnd/.cache/dein/repos/github.com/Shougo/dein.vim'
" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
if dein#load_state(s:dein_base)
    call dein#begin(s:dein_base)

    let s:toml      = s:dein_base . '/dein.toml'
    let s:lazy_toml = s:dein_base . '/dein_lazy.toml'

    call dein#load_toml(s:toml     , {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#add(s:dein_src)

    " Finish Dein initialization (required)
    call dein#end()
    call dein#save_state()
endif
" install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif
" end dein ---------------------------------------------------

"OMAJINAI
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
set display=lastline
set virtualedit=onemore
set wildmode=list:longest
"Highlightning tab, trail...ect
set list
set listchars=tab:^\ ,trail:~
"---> Color scheme
set background=light
" set vim's background same as terminal's
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LinerNr ctermbg=none
colorscheme iceberg
"----> End Color scheme

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

" yank registers
nnoremap x "_x
vnoremap x "_x
