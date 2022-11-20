-- neotest configuration
local neotest_status, neotest = pcall(require, "neotest")

if not neotest_status then
  return
end

-- TODO: Make this safer if adapters don't exist
neotest.setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = true },
    }),
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})
