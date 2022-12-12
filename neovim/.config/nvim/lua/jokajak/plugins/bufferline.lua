-- https://github.com/akinsho/nvim-bufferline.lua
-- A snazzy nail_care buffer line (with tabpage integration) for Neovim built
-- using lua.

local M = {
  "akinsho/nvim-bufferline.lua",
  event = "BufReadPre",
}

function M.config()
  local signs = require("jokajak.lsp.diagnostics").signs
  signs = {
    error = signs.Error,
    warning = signs.Warn,
    info = signs.Info,
    hint = signs.Hint,
  }

  local severities = {
    "error",
    "warning",
    -- "info",
    -- "hint",
  }

  local status_ok, bufferline = pcall(require, "bufferline")

  if not status_ok then
    return
  end

  local options = {
    numbers = "ordinal",
    show_close_icon = true,
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo Tree",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "NvimTree",
        text = "File Explorer",
        padding = 1,
      },
    },
    diagnostics_indicator = function(_, _, diag)
      local s = {}
      for _, severity in ipairs(severities) do
        if diag[severity] then
          table.insert(s, signs[severity] .. diag[severity])
        end
      end
      return table.concat(s, " ")
    end,
  }
  bufferline.setup({
    options = options,
  })

  --  options = {
  --    mode = "buffers", -- set to "tabs" to only show tabpages instead
  --    numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
  --    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
  --    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
  --    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
  --    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
  --    -- NOTE: this plugin is designed with this icon in mind,
  --    -- and so changing this is NOT recommended, this is intended
  --    -- as an escape hatch for people who cannot bear it for whatever reason
  --    indicator = {
  --      style = "icon",
  --      icon = "▎",
  --    },
  --    buffer_close_icon = "",
  --    modified_icon = "●",
  --    close_icon = "",
  --    left_trunc_marker = "",
  --    right_trunc_marker = "",
  --    --- name_formatter can be used to change the buffer's label in the bufferline.
  --    --- Please note some names can/will break the
  --    --- bufferline so use this at your discretion knowing that it has
  --    --- some limitations that will *NOT* be fixed.
  --    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
  --      -- remove extension from markdown files for example
  --      if buf.name:match("%.md") then
  --        return vim.fn.fnamemodify(buf.name, ":t:r")
  --      end
  --    end,
  --    max_name_length = 18,
  --    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
  --    tab_size = 18,
  --    diagnostics = "nvim_lsp", -- show lsp in bufferline
  --    diagnostics_update_in_insert = false,
  --    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
  --    diagnostics_indicator = function(count, level, diagnostics_dict, context)
  --      return "(" .. count .. ")"
  --    end,
  --    -- NOTE: this will be called a lot so don't do any heavy processing here
  --    custom_filter = function(buf_number, buf_numbers)
  --      -- filter out filetypes you don't want to see
  --      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
  --        return true
  --      end
  --      -- filter out by buffer name
  --      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
  --        return true
  --      end
  --      -- filter out based on arbitrary rules
  --      -- e.g. filter out vim wiki buffer from tabline in your work repo
  --      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
  --        return true
  --      end
  --      -- filter out by it's index number in list (don't show first buffer)
  --      if buf_numbers[1] ~= buf_number then
  --        return true
  --      end
  --    end,
  --    offsets = {
  --      { filetype = "NvimTree", text = "File Explorer", padding = 1 },
  --    },
  --    color_icons = true, -- whether or not to add the filetype icon highlights
  --    show_buffer_icons = true, -- disable filetype icons for buffers
  --    show_buffer_close_icons = true,
  --    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
  --    show_close_icon = true,
  --    show_tab_indicators = true,
  --    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
  --    -- can also be a table containing 2 custom separators
  --    -- [focused and unfocused]. eg: { '|', '|' }
  --    separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' },
  --    enforce_regular_tabs = true, -- false | true,
  --    always_show_bufferline = true, -- true | false,
  --    -- sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
  --    --   -- add custom logic
  --    --   return buffer_a.modified > buffer_b.modified
  --    -- end
  --    sort_by = "insert_after_current",
  --
  --    options = {
  --      show_close_icon = true,
  --      diagnostics = "nvim_lsp",
  --      always_show_bufferline = false,
  --      separator_style = "thick",
  --      diagnostics_indicator = function(_, _, diag)
  --        local s = {}
  --        for _, severity in ipairs(severities) do
  --          if diag[severity] then
  --            table.insert(s, signs[severity] .. diag[severity])
  --          end
  --        end
  --        return table.concat(s, " ")
  --      end,
  --    },
  --  })
end

function M.init()
  vim.keymap.set("n", "<leader>bp", "<cmd>:BufferLineCyclePrev<CR>", { desc = "[B]uffer [P]revious" })
  vim.keymap.set("n", "<leader>bn", "<cmd>:BufferLineCycleNext<CR>", { desc = "[B]uffer [N]ext" })
  vim.keymap.set("n", "[b", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
  vim.keymap.set("n", "]b", "<cmd>:BufferLineCycleNext<CR>", { desc = "Next Buffer" })
end

return M
