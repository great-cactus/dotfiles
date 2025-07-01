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

vim.api.nvim_set_keymap('n', '<Leader>cc', '<cmd>lua require("claude").toggle_claude()<CR>', { noremap = true, silent = true })

return M