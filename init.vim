let mapleader="\<Space>"
let g:tex_flavor = 'latex'
"autocmd BufNewFile,BufRead *.tex set filetype=latex

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
    let g:dein#auto_recache = 1

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
set noswapfile
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
set laststatus=0
set number
set relativenumber
set display=lastline
set virtualedit=onemore
set wildmode=list:longest
"Highlightning tab, trail...ect
set list
set listchars=tab:^\ ,trail:~
"---> Color scheme
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Front
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " Background
"----> End Color scheme

set matchpairs+=（:）

set cmdheight=0
set conceallevel=2
" Explicitly read the standard plugins
let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:did_indent_on             = 1
let g:did_load_filetypes        = 1
let g:did_load_ftplugin         = 1
let g:loaded_2html_plugin       = 1
let g:loaded_gzip               = 1
let g:loaded_man                = 1
let g:loaded_matchit            = 1
let g:loaded_matchparen         = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_remote_plugins     = 1
let g:loaded_shada_plugin       = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tarPlugin          = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_zipPlugin          = 1
let g:skip_loading_mswin        = 1

"Mapping
noremap <silent> <Esc> :nohlsearch<CR><Esc>

function! ExactMatchReplace()
    let search_term = input('Search for: ')
    if search_term == '' | return | endif

    let replace_term = input('Replace with: ')
    if replace_term == '' | return | endif

    execute '%s/\<' . search_term . '\>/' . replace_term . '/gc'
endfunction

nnoremap <leader>S :call ExactMatchReplace()<CR>

nnoremap <Leader>t :tabe<Space>

nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^
noremap $ <nop>
noremap ^ <nop>

" 大文字のHでhelpを開けば，全画面表示にする．
command! -nargs=* -complete=help H help <args> | only

"Complement?
set completeopt=menuone

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
nmap gj gj<SID>g
nmap gk gk<SID>g
nnoremap <script> <SID>gj gj<SID>g
nnoremap <script> <SID>gk gk<SID>g
nmap <SID>g <Nop>

" clipboard
set clipboard&
set clipboard=unnamedplus

" yank registers
nnoremap x "_x
vnoremap x "_x
vnoremap p "_dP

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
    autocmd InsertEnter,WinEnter * checktime
augroup END

" Toggle quickfix
if exists('g:__QUICKFIX_TOGGLE__')
    finish
endif
let g:__QUICKFIX_TOGGLE__ = 1

function! ToggleQuickfix()
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif

endfunction
nnoremap <script> <silent> <leader>q :call ToggleQuickfix()<CR>

" 関数展開
function! ExpandFunctionParams()
    " 現在のカーソル位置を保存
    let l:save_cursor = getpos(".")

    " カーソル下の関数を検索
    normal! [(
    let start_line = line(".")
    normal! %
    let end_line = line(".")

    " 正規表現で関数呼び出しを展開
    silent! execute start_line . ',' . end_line . 's/\(\w\+\.\w\+\)(\([^)]*\))/\1(\r    \2\r)/g'

    " カンマの後に改行とインデントを挿入（スペースがあってもなくてもマッチ）
    silent! execute start_line . ',' . end_line . 's/,\s*/,\r    /g'

    " カーソル位置を復元
    call setpos('.', l:save_cursor)
endfunction

function! CompactFunctionParams()
    " 現在のカーソル位置を保存
    let l:save_cursor = getpos(".")

    " カーソル下の関数を検索
    normal! [(
    let start_line = line(".")
    normal! %
    let end_line = line(".")

    " 関数の範囲内で置換を実行
    silent! execute start_line . ',' . end_line . 's/\(\w\+\.\w\+\)(\_s*\([^)]*\)\_s*)/\1(\2)/g'

    " カンマの後の空白と改行を処理し、カンマの後に一つのスペースを入れる
    silent! execute start_line . ',' . end_line . 's/,\_s*/,/g'
    silent! execute start_line . ',' . end_line . 's/,/, /g'

    " 引数内の余分なスペースを処理
    silent! execute start_line . ',' . end_line . 's/=\s*/=/g'
    silent! execute start_line . ',' . end_line . 's/\s*=/=/g'

    " カーソル位置を復元
    call setpos('.', l:save_cursor)
endfunction

function! ToggleFunctionFormat()
    " カーソル行の内容を取得
    let l:line = getline('.')
    if l:line =~ '\w\+\.\w\+(' && l:line !~ ',\s*\n' " 1行にまとまっている場合
        call ExpandFunctionParams()
    else
        call CompactFunctionParams()
    endif
endfunction

nnoremap <leader>ef :call ToggleFunctionFormat()<CR>

function! s:FixPunctuation() abort
    let l:pos = getpos('.')
    let l:modified = &modified
    silent! execute ':%s/\\\@<!\s\+$//'
    if l:modified == 0 && &modified == 1
        setlocal modified
    endif
    call setpos('.', l:pos)
endfunction
augroup FixPunctuationGroup
    autocmd!
    autocmd BufWritePre * call <SID>FixPunctuation()
augroup END

lua << EOF
-- Terminal configuration
require('config.terminal')
-- Spell-check
-- require('config.spell')
-- Claude Code integration
require('config.claude')
-- Clear highlighting after Substitution
require('config.substitute_nohl')
-- Aut bracket escape
require('config.bracket_escape').setup({
  keymap='<C-l>',
  custom_pairs= {
    '$:$',
  },
})

-- Put a mark
vim.keymap.set("n", "<leader>s", "mS:%s/",
{ desc = "Put a mark before a search"}
)
vim.keymap.set("v", "<leader>s", "mS:'<,'>s/",
{ desc = "Put a mark before a search"}
)
vim.keymap.set("n", "n", "mNn")
EOF

nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT

let fortran_free_source = 0
