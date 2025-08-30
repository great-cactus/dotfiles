-- bracket-escape.lua
-- Insert modeで <C-;> を押して最も近い括弧の外側にカーソルを移動

local M = {}

-- matchpairsから括弧のペアを取得する関数
local function get_bracket_pairs()
  local matchpairs = vim.o.matchpairs
  local pairs = {}

  for pair in matchpairs:gmatch('[^,]+') do
    local open, close = pair:match('(.):(.)')
    if open and close then
      pairs[open] = close
      pairs[close] = open
    end
  end

  return pairs
end

-- 最も近い括弧の外側にカーソルを移動する関数
local function move_outside_nearest_bracket()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local bracket_pairs = get_bracket_pairs()

  -- 現在位置の文字をチェック
  local current_char = col < #line and line:sub(col + 1, col + 1) or ''

  -- 現在位置が閉じ括弧の場合、その直後に移動
  if bracket_pairs[current_char] and current_char:match('[%)}%]]') then
    vim.api.nvim_win_set_cursor(0, {row, col + 1})
    return
  end

  -- 現在位置から右側で最初に見つかる閉じ括弧を探す
  for i = col + 1, #line do
    local char = line:sub(i, i)
    if bracket_pairs[char] and char:match('[%)}%]]') then
      vim.api.nvim_win_set_cursor(0, {row, i})
      return
    end
  end
end

-- セットアップ関数
function M.setup(opts)
  opts = opts or {}
  local keymap = opts.keymap or '<C-l>'

  vim.keymap.set('i', keymap, move_outside_nearest_bracket, {
    desc = 'Move outside nearest bracket',
    silent = true
  })
end

-- デフォルトでセットアップを実行
M.setup()

return M
