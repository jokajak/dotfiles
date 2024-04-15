return {
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
  {
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      -- set background based on time
      local now = os.date("*t")

      if (8 <= now.hour) and (now.hour < 20) then
        opts.style = "day"
      else
        opts.style = "storm"
      end
    end,
  },
}
