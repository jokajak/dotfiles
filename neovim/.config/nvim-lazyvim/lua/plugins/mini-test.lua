-- https://github.com/echasnovski/mini.test
-- testing

local minitest = {
  "echasnovski/mini.test",
  version = false,
  keys = {
    {
      "<leader>ctm",
      function()
        require("mini.test").setup()
        MiniTest.run()
      end,
      desc = "[C]ode: [Test] with [m]initest",
    },
  },
}

return minitest
