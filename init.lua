vim.opt.mapleader = '<Space>'
vim.opt.tex_flavor = 'latex'

-- OMAJINAI
vim.opt.t_u7 = ''
vim.opt.t_RV = ''
vim.opt.belloff = 'all'
vim.opt.backspace  = 'indent,eol,start'
vim.opt.noswapfile = true

-- Tab and indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Searching
vim.opt.ignorecase = true
vim.opt.wrapscan = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true

-- Display settings
vim.opt.t_Co = 256
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.display = 'lastline'
vim.opt.virtualedit = 'onemore'
vim.opt.wildmode = 'list:longest'
vim.opt.list = true
-- vim.opt.listchars='tab:^\ ,trail:~'

-- cmd line
vim.opt.cmdheight = 0
vim.opt.conceallevel=2

-- keymappings
vim.api.nvim_set_keymap('n', '<Esc>', 'vim.cmd("nohlsearch<CR><Esc>")', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>s', 'vim.cmd("%s/")', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', 'vim.cmd("tabe<Space>")', { silent = true })

-- US keybord
vim.api.nvim_set_keymaps({'n', 'v'}, ';', ':', { silent = true })
vim.api.nvim_set_keymaps({'n', 'v'}, ':', ';', { silent = true })

vim.api.nvim_set_keymaps({'n', 'v'}, 'x', '"_x')

-- Cursor move
vim.api.nvim_set_keymap('n', 'gj', 'gj<SID>g', {noremap=false})
vim.api.nvim_set_keymap('n', 'gk', 'gk<SID>g', {noremap=false})
vim.api.nvim_set_keymap('n', '<SID>gj', 'gj<SID>g', {script=true})
vim.api.nvim_set_keymap('n', '<SID>gj', 'gj<SID>g', {script=true})
