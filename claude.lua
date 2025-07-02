local M = {}

local claude_buf = nil
local claude_win = nil
local claude_job = nil

function M.get_claude_state()
  if not claude_win or not vim.api.nvim_win_is_valid(claude_win) then
    return 'closed'
  end

  local config = vim.api.nvim_win_get_config(claude_win)
  local width = vim.o.columns
  local term_width = math.floor(width / 4)

  if config.width == term_width and config.col == width - term_width then
    return 'terminal'
  else
    return 'popup'
  end
end

function M.toggle_claude()
  local state = M.get_claude_state()

  if state == 'terminal' then
    vim.api.nvim_win_hide(claude_win)
    claude_win = nil
  elseif state == 'popup' then
    vim.api.nvim_win_hide(claude_win)
    claude_win = nil
    M.open_claude_terminal()
  else
    M.open_claude_terminal()
  end
end

function M.create_claude_buffer()
  claude_buf = vim.api.nvim_create_buf(false, true)
  
  -- Set buffer options
  vim.api.nvim_buf_set_option(claude_buf, 'bufhidden', 'hide')
  vim.api.nvim_buf_set_option(claude_buf, 'filetype', 'claude')
end

function M.start_claude_terminal()
  -- Start Claude Code terminal in the current buffer
  claude_job = vim.fn.termopen('claude', {
    on_exit = function()
      claude_job = nil
    end
  })
end

function M.open_claude_terminal()
  local width = vim.o.columns
  local height = vim.o.lines
  local term_width = math.floor(width / 4)

  if not claude_buf or not vim.api.nvim_buf_is_valid(claude_buf) then
    M.create_claude_buffer()
  end

  claude_win = vim.api.nvim_open_win(claude_buf, true, {
    relative = 'editor',
    width = term_width,
    height = height - 2,
    col = width - term_width,
    row = 0,
    style = 'minimal',
    border = 'single'
  })

  -- Start Claude Code terminal after opening the window
  if not claude_job then
    M.start_claude_terminal()
  end

  -- Start in insert mode for terminal interaction
  vim.cmd('startinsert')
end

function M.toggle_claude_popup()
  local state = M.get_claude_state()

  if state == 'popup' then
    vim.api.nvim_win_hide(claude_win)
    claude_win = nil
  elseif state == 'terminal' then
    vim.api.nvim_win_hide(claude_win)
    claude_win = nil
    M.open_claude_popup()
  else
    if not claude_buf or not vim.api.nvim_buf_is_valid(claude_buf) then
      M.create_claude_buffer()
    end
    M.open_claude_popup()
  end
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

  -- Start Claude Code terminal after opening the window
  if not claude_job then
    M.start_claude_terminal()
  end

  -- Start in insert mode for terminal interaction
  vim.cmd('startinsert')
end

vim.api.nvim_set_keymap('n', '<Leader>cc', '<cmd>lua require("config.claude").toggle_claude()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ccp', '<cmd>lua require("config.claude").toggle_claude_popup()<CR>', { noremap = true, silent = true })

-- Escape key mapping to exit terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

return M
