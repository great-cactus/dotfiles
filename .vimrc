"OMAJINAI
set t_u7=
set t_RV=
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
colorscheme vcbc
"Highlightning tab, trail...ect
set list
set listchars=tab:^\ ,trail:~

"Mapping
nmap <Esc><Esc> :nohlsearch<CR><Esc>
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

let mapleader="\<Space>"
noremap <Leader>s :%s/
noremap <Leader>y yyp

"Complement?
set completeopt=menuone

"High-lightning when insert mode
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

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

"dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

set runtimepath+=/home/titania/.vim/bundles/.//repos/github.com/Shougo/dein.vim

if dein#load_state('/home/titania/.vim/bundles/./')
    call dein#begin('/home/titania/.vim/bundles/./')

    " Let dein manage dein
    call dein#add('/home/titania/.vim/bundles/.//repos/github.com/Shougo/dein.vim')

    " Load .toml file
    let s:toml_dir  = $HOME . '/.vim'
    let s:toml      = s:toml_dir . '/dein.toml'
    let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
    " Read and cashing .toml
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    " Add or remove your plugins here like this:
    "call dein#add('Shougo/neosnippet.vim')
    "call dein#add('Shougo/neosnippet-snippets')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable
" Plugin installation check
if dein#check_install()
  call dein#install()
endif

" Plugin remove check
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif
"End dein Scripts-------------------------
