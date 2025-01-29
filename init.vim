let mapleader="\<Space>"
let g:tex_flavor = 'latex'

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
    let g:dein#auto_recache = v:true

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
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Front
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " Background
set background=light
colorscheme iceberg
"----> End Color scheme
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
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

function! ExactMatchReplace()
    let search_term = input('Search for: ')
    if search_term == '' | return | endif

    let replace_term = input('Replace with: ')
    if replace_term == '' | return | endif

    execute '%s/\<' . search_term . '\>/' . replace_term . '/gc'
endfunction

nnoremap <Leader>s :%s/
nnoremap <leader>S :call ExactMatchReplace()<CR>

nnoremap <Leader>t :tabe 

nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^
noremap $ <nop>
noremap ^ <nop>

" 大文字のHでhelpを開けば、全画面表示にする。
command! -nargs=* -complete=help H help <args> | only


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
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> gj j
nnoremap <silent> gk k
vnoremap <silent> j gj
vnoremap <silent> k gk
vnoremap <silent> gj j
vnoremap <silent> gk k

" Get full path of current file
command!FileNameFull :call s:FileNameFull()
function! s:FileNameFull()
    let @* = expand('%:p')
    let @" = expand('%:p')
endfunction
" map FileNameFull to <leader>y
nnoremap <silent> <leader>fy :FileNameFull<CR>

" clipboard
set clipboard&
set clipboard=unnamedplus

" yank registers
nnoremap x "_x
vnoremap x "_x

" terminal mode
nnoremap <silent> tt <cmd>terminal<CR>
nnoremap <silent> tx <cmd>belowright new<CR><cmd>terminal<CR>
nnoremap <silent> tp :call PopupTerminal()<CR>
autocmd TermOpen * :startinsert
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
tnoremap <Esc> <C-\><C-n>

function! PopupTerminal()
    " get the current window size and set popup size
    let l:magnify = 0.6
    let l:ui = nvim_list_uis()[0]

    let l:width = float2nr(l:ui['width'] * l:magnify)
    let l:height = float2nr(l:ui['height'] * l:magnify)

    let l:col = float2nr((l:ui['width'] - l:width) / 2)
    let l:row = float2nr((l:ui['height'] - l:height) / 2)

    " Create a new buffer
    let buf = nvim_create_buf(v:false, v:true)

    " Setup the new buffer
    call nvim_open_win(buf, v:true, {
    \   'relative': 'editor',
    \   'width'   : l:width,
    \   'height'  : l:height,
    \   'col'     : l:col,
    \   'row'     : l:row,
    \   'border'  : 'single'
    \   })

    " Open the terminal
    call termopen($SHELL)
endfunction

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

" Function to load foldings
function! LoadFoldings()
    if expand('%') != '' && &buftype !~ 'nofile'
        " foldmethodがexprの場合はviewのロードをスキップ
        if &foldmethod != 'expr'
            try
                silent! loadview
            catch
                " Ignore the error when view file doesn't exist
            endtry
        endif
    endif
endfunction

" Function to save foldings
function! SaveFoldings()
    if expand('%') != '' && &buftype !~ 'nofile'
        " foldmethodがexprの場合はviewの保存をスキップ
        if &foldmethod != 'expr'
            mkview
        endif
    endif
endfunction

" Autocommands for foldings
augroup remember_folds
    autocmd!
    autocmd BufWritePost * call SaveFoldings()
    autocmd BufRead * call LoadFoldings()
augroup END
" Don't save options.
set viewoptions-=options

" Iceberg color theme adjustments for status bar
" ---------------------------------------------------
let g:last_mode = ""

function! Mode()
  let l:mode = mode()

  if l:mode !=# g:last_mode
    let g:last_mode = l:mode

    hi User2 guifg=#9ccfd8 guibg=#161821 gui=BOLD ctermfg=81 ctermbg=234 cterm=BOLD
    hi User3 guifg=#c6c8d1 guibg=#3b4252 ctermfg=251 ctermbg=238
    hi User4 guifg=#4c566a guibg=#2e3440 ctermfg=241 ctermbg=236
    hi User5 guifg=#d8dee9 guibg=#e5e9f0 gui=bold ctermfg=253 ctermbg=255 cterm=bold
    hi User6 guifg=#eceff4 guibg=#4c566a ctermfg=255 ctermbg=245
    hi User7 guifg=#eceff4 guibg=#d08770 gui=bold ctermfg=255 ctermbg=173 cterm=bold
    hi User8 guifg=#d08770 guibg=#3b4252 ctermfg=173 ctermbg=238

    if l:mode ==# 'n'
      hi User3 guifg=#8fbcbb ctermfg=158
    elseif l:mode ==# "i"
      hi User2 guifg=#88c0d0 guibg=#e5e9f0 ctermfg=110 ctermbg=255
      hi User3 guifg=#eceff4 ctermfg=255
    elseif l:mode ==# "R"
      hi User2 guifg=#eceff4 guibg=#bf616a ctermfg=255 ctermbg=131
      hi User3 guifg=#bf616a ctermfg=131
    elseif l:mode ==? "v" || l:mode ==# ""
      hi User2 guifg=#d8dee9 guibg=#b48ead ctermfg=253 ctermbg=140
      hi User3 guifg=#b48ead ctermfg=140
    endif
  endif

  if l:mode ==# "n"
    return "  NORMAL "
  elseif l:mode ==# "i"
    return "  INSERT "
  elseif l:mode ==# "R"
    return "  REPLACE "
  elseif l:mode ==# "v"
    return "  VISUAL "
  elseif l:mode ==# "V"
    return "  V·LINE "
  elseif l:mode ==# ""
    return "  V·BLOCK "
  elseif l:mode ==# "c"
    return "  COMMAND "
  elseif l:mode ==# "t"
    return "  TERMINAL "
  else
    return l:mode
  endif
endfunction

" Left hand side
set statusline=%2*%{Mode()}
set statusline+=%#StatusLine#
set statusline+=%f%R%m%<
set statusline+=%#warningmsg#

set statusline+=%=

" Right hand side
set statusline+=%#StatusLine#
set statusline+=%{strlen(&fileencoding)>0?&fileencoding.'\ \ ':''}
set statusline+=%{strlen(&filetype)>0?&filetype:''}
set statusline+=\ %8*
set statusline+=%3*\ %p%%
set statusline+=%2*%l/%L:%c

nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT
