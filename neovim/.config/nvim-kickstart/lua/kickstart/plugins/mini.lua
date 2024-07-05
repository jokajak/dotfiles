return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup({ n_lines = 500 })

      -- text alignment
      require('mini.align').setup({
        mappings = {
          start = 'gA',
          start_with_preview = 'ga',
        },
      })

      -- more forward/backward movement targets
      require('mini.bracketed').setup()

      -- keep window layout
      require('mini.bufremove').setup()

      -- enable commenting
      require('mini.comment').setup()

      -- highlight the current word
      require('mini.cursorword').setup()

      -- work with diff hunks
      require('mini.diff').setup()

      -- highlight patterns in text
      require('mini.hipatterns').setup()

      -- icons
      require('mini.icons').setup()

      -- extra operators
      require('mini.operators').setup()

      --- session management
      require('mini.sessions').setup()
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- tab line
      require('mini.tabline').setup()
      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require('mini.statusline')
      -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- highlight trailing whitespace
      require('mini.trailspace').setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
