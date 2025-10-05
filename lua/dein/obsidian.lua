vim.opt_local.conceallevel = 2
require("obsidian").setup{
  notes_subdir = "Output",
  log_level = vim.log.levels.INFO,
  disable_frontmatter = true,
  legacy_commands = false,

  workspaces = {
    {
      name = "Obsidian_Vault",
      path = vim.fn.expand("$OBSIDIAN_PATH")
    },
  },
  daily_notes = {
    folder      = "Output/DailyNotes",
    date_format = "%Y-%m-%d",
  },
  attachments = {
    img_folder = './Attachments',
  },
  picker = {
    name = 'fzf-lua',
    new = "<C-x>",
    insert_link = "<C-l>",
  },
  completion = {
    nvim_cmp = false,
    min_chars = 2,
  },
  footer = {
    enabled = false, -- turn it off
    separator = false, -- turn it off
    -- separator = "", -- insert a blank line
    format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars", -- works like the template system
    hl_group = "@property", -- Use another hl group
  }
}

-- Create permanent note function
local function create_permanent_note()
  local title = vim.fn.input("Enter title of Permanent note: ")
  if title == "" then
    return
  end

  local obsidian_path = vim.fn.expand("$OBSIDIAN_PATH")
  local file_path = obsidian_path .. "/Output/" .. title .. ".md"

  -- Check if file already exists
  if vim.fn.filereadable(file_path) == 1 then
    vim.notify("⚠️Error: Output/" .. title .. ".md already exists.", vim.log.levels.WARN)
    return
  end

  -- Generate metadata
  local today_id = os.date("%Y%m%d%H%M")
  local today_created = os.date("%Y-%m-%d %H:%M")
  local today_tag = os.date("%Y/%m/%d")

  local content = string.format([[---
ID: %s
created: %s
title: %s
aliases: []
tags: [ %s, PERMANENT ]
---
]], today_id, today_created, title, today_tag
  )

    -- Create file
  local file = io.open(file_path, "w")
  if file then
    file:write(content)
    file:close()

    -- Open the created file
    vim.cmd("edit " .. file_path)
    vim.notify("Created permanent note: " .. title, vim.log.levels.INFO)
  else
    vim.notify("Failed to create file: " .. file_path, vim.log.levels.ERROR)
  end
end

-- Create literature note function
local function create_literature_note()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_file_path = vim.api.nvim_buf_get_name(current_buf)

  -- Check if there's an active file
  if current_file_path == "" then
    vim.notify("No active file found.", vim.log.levels.ERROR)
    return
  end

  -- Get the basename of the current file (without extension)
  local file_title = vim.fn.fnamemodify(current_file_path, ":t:r")

  local title = vim.fn.input("Enter title of Literature note: ")
  if title == "" then
    vim.notify("⚠️Error: No title is available.", vim.log.levels.WARN)
    return
  end

  local obsidian_path = vim.fn.expand("$OBSIDIAN_PATH")
  local file_path = obsidian_path .. "/Output/" .. file_title .. "-" .. title .. ".md"

  -- Check if file already exists
  if vim.fn.filereadable(file_path) == 1 then
    vim.notify("⚠️Error: Output/" .. file_title .. "-" .. title .. ".md already exists.", vim.log.levels.WARN)
    return
  end

  -- Generate metadata
  local today_id = os.date("%Y%m%d%H%M")
  local today_created = os.date("%Y-%m-%d %H:%M")
  local today_tag = os.date("%Y/%m/%d")

  -- Get relative path for the link
  local relative_path = vim.fn.fnamemodify(current_file_path, ":~:.")
  if vim.startswith(relative_path, obsidian_path) then
    relative_path = string.sub(relative_path, string.len(obsidian_path) + 2) -- Remove obsidian_path + "/"
  end
  local active_file_link = "[[" .. relative_path .. "]]"

  local content = string.format([[---
ID: %s
created: %s
title: %s
aliases: []
tags: [ %s, LITERATURE ]
---
%s

]], today_id, today_created, title, today_tag, active_file_link)

  -- Create file
  local file = io.open(file_path, "w")
  if file then
    file:write(content)
    file:close()

    -- Open the created file
    vim.cmd("edit " .. file_path)
    vim.notify("Created literature note: " .. file_title .. "-" .. title, vim.log.levels.INFO)
  else
    vim.notify("Failed to create file: " .. file_path, vim.log.levels.ERROR)
  end
end

-- Set keymap for <leader>op
vim.keymap.set('n', '<leader>op', create_permanent_note, { desc = 'Create Obsidian Permanent Note' })
-- Set keymap for <leader>ol
vim.keymap.set('n', '<leader>ol', create_literature_note, { desc = 'Create Obsidian Literature Note' })
