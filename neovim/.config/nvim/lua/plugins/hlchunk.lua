-- https://github.com/shellRaining/hlchunk.nvim/discussions/22
-- highlight code chunk similar to indent blankline

local render = true
local hlchunk = {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    LazyVim.toggle.map("<leader>uH", {
      name = "Highlight Chunks",
      get = function()
        return render
      end,
      set = function(state)
        if state then
          render = true
          vim.cmd("EnableHLChunk")
        else
          render = false
          vim.cmd("DisableHLChunk")
        end
      end,
    })

    return {
      chunk = {
        enable = true,
      },
    }
  end,
}

return hlchunk
