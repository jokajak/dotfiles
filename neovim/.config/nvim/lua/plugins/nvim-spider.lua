-- https://github.com/chrisgrieser/nvim-spider
-- Provide better subword motion

local plugin = {
  "chrisgrieser/nvim-spider",
  lazy = true,
  keys = {
    {
      "w",
      function()
        require("spider").motion("w")
      end,
      desc = "Spider-w",
      mode = "n",
    },
    {
      "e",
      function()
        require("spider").motion("e")
      end,
      desc = "Spider-e",
      mode = "n",
    },
    {
      "b",
      function()
        require("spider").motion("b")
      end,
      desc = "Spider-b",
      mode = "n",
    },
  },
}

return plugin
