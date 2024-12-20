-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Sync background with wezterm
-- File path
local file_path = vim.fn.expand("~/.local/cache/wezterm/background.lua")

-- Function to read the file and set the background
local function set_background_from_file()
  -- Check if the file exists
  if vim.fn.filereadable(file_path) == 1 then
    -- Read the file contents
    local file = io.open(file_path, "r")
    local content = ""
    if file ~= nil then
      content = file:read("*all")
      file:close()
    end

    -- Trim any whitespace from the content
    content = vim.trim(content)

    -- Match the TERM_BACKGROUND value
    local background = content:match("TERM_BACKGROUND%s*=%s*(%w+)")

    -- Set the background based on the content
    if background == "dark" or background == "light" then
      vim.o.background = content
    else
      vim.notify("Invalid background found, ignoring", vim.log.levels.WARN)
    end
  end
end

local background_timer = vim.uv.new_timer()
if background_timer ~= nil then
  -- Start a timer to run the function every 5 seconds
  background_timer:start(
    1000,
    -1,
    vim.schedule_wrap(function()
      set_background_from_file()
    end)
  )
end
