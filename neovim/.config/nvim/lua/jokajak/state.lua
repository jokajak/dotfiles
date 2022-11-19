-- Copied from https://raw.githubusercontent.com/MunifTanjim/exrc.nvim/main/lua/exrc/state.lua
local state_path = (function()
  local ok, dir = pcall(vim.fn.stdpath, "state")
  return ok and dir or vim.fn.stdpath("cache")
end)() .. "/custom_state.json"

local state_default_data = {
  __rc__ = "v0.1",
  colorscheme = "tokyonight",
  bg = "light",
}

---@param data table JSON object
---@return string|nil blob # encoded string
---@return nil|string error
local function json_encode(data)
  local ok, result = pcall(vim.fn.json_encode, data)

  if ok then
    return result
  end

  return nil, result
end

---@param blob string # encoded string
---@return table|nil data # JSON object
---@return nil|table error
local function json_decode(blob)
  local ok, result = pcall(vim.fn.json_decode, blob)

  if ok then
    return result
  end

  return nil, result
end

local function state_file_exists()
  return vim.fn.filereadable(state_path) == 1
end

local function state_file_read()
  local blob = vim.fn.readfile(state_path)[1]

  local decoded_data, err = json_decode(blob)
  if err then
    vim.api.nvim_err_writeln("[jokajak] file read error: " .. err)
    return
  end

  return decoded_data
end

---@param data table
local function state_file_write(data)
  local blob, err = json_encode(data)
  if err then
    vim.api.nvim_err_writeln("[jokajak] file write error: " .. err)
    return
  end

  vim.fn.writefile({ blob }, state_path)
end

local function state_file_ensure()
  if not state_file_exists() then
    vim.fn.mkdir(vim.fn.fnamemodify(state_path, ":h"), "p")
    state_file_write(state_default_data)
  end
end

---@param data table|nil
local function state_has_current_version(data)
  return data and data.__rc__ == state_default_data.__rc__ or false
end

local state_data

local state = {
  _initialized = false,
}

---@param key string
---@return nil|{ hash: string, allowed: boolean, modified_at: number }
function state.get(key)
  return state_data[key]
end

---@param key string
---@param value? { hash: string, allowed: boolean }
function state.set(key, value)
  state_data[key] = value

  vim.schedule(function()
    state_file_write(state_data)
  end)
end

function state.setup()
  if state._initialized then
    return
  end

  state_file_ensure()

  local data = state_file_read()

  if state_has_current_version(data) then
    state_data = data
  else
    state_data = vim.deepcopy(state_default_data)
  end

  state._initialized = true
end

return state
