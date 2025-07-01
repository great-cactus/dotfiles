local M = {}

local claude_buf = nil
local claude_win = nil
local claude_job = nil

function M.toggle_claude()
  if claude_win and vim.api.nvim_win_is_valid(claude_win) then
    vim.api.nvim_win_hide(claude_win)
    claude_win = nil
  else
    M.open_claude_terminal()
  end
end

function M.open_claude_terminal()
  local width = vim.o.columns
  local height = vim.o.lines
  local term_width = math.floor(width / 4)
  
  if claude_buf and vim.api.nvim_buf_is_valid(claude_buf) then
    claude_win = vim.api.nvim_open_win(claude_buf, true, {
      relative = 'editor',
      width = term_width,
      height = height - 2,
      col = width - term_width,
      row = 0,
      style = 'minimal',
      border = 'single'
    })
  else
    claude_buf = vim.api.nvim_create_buf(false, true)
    claude_win = vim.api.nvim_open_win(claude_buf, true, {
      relative = 'editor',
      width = term_width,
      height = height - 2,
      col = width - term_width,
      row = 0,
      style = 'minimal',
      border = 'single'
    })
    
    claude_job = vim.fn.termopen('claude', {
      on_exit = function()
        claude_job = nil
      end
    })
    
    vim.api.nvim_buf_set_option(claude_buf, 'bufhidden', 'hide')
  end
  
  vim.cmd('startinsert')
end

function M.toggle_claude_popup()
  if not claude_buf or not vim.api.nvim_buf_is_valid(claude_buf) then
    M.open_claude_terminal()
  end
  
  if claude_win and vim.api.nvim_win_is_valid(claude_win) then
    vim.api.nvim_win_hide(claude_win)
    claude_win = nil
  end
  
  M.open_claude_popup()
end

function M.open_claude_popup()
  local width = vim.o.columns
  local height = vim.o.lines
  local popup_width = math.floor(width * 0.75)
  local popup_height = math.floor(height * 0.75)
  local col = math.floor((width - popup_width) / 2)
  local row = math.floor((height - popup_height) / 2)
  
  claude_win = vim.api.nvim_open_win(claude_buf, true, {
    relative = 'editor',
    width = popup_width,
    height = popup_height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'single'
  })
  
  vim.cmd('startinsert')
end

vim.api.nvim_set_keymap('n', '<Leader>cc', '<cmd>lua require("claude").toggle_claude()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ccp', '<cmd>lua require("claude").toggle_claude_popup()<CR>', { noremap = true, silent = true })

return M