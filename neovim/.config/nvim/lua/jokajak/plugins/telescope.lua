-- https://github.com/telescope/telescope.nvim
-- telescope.nvim is a highly extendable fuzzy finder over lists.

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
}

M.config = function()
  -- [[ Telescope ]]--
  local status_ok, telescope = pcall(require, "telescope")

  if not status_ok then
    return
  end

  local actions = require("telescope.actions")

  local path_display_fn = function(opts, path)
    local tail = require("telescope.utils").path_tail(path)
    return string.format("%s (%s)", tail, path)
  end

  local config = {
    defaults = {

      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { truncate = 3 },

      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
        },
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,

          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {},
    extensions = {},
  }

  local trouble_ok, trouble = pcall(require, "trouble.providers.telescope")

  if trouble_ok then
    config["defaults"]["mappings"]["i"]["<c-t>"] = trouble.open_with_trouble
    config["defaults"]["mappings"]["n"]["<c-t>"] = trouble.open_with_trouble
  end

  telescope.setup(config)
end

M.setup = function()
  -- Telescope
  vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>", { desc = "[?] Find recently opened files" })
  vim.keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>", { desc = "[ ] Find existing buffers" })
  vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      winblend = 10,
      previewer = false,
    }))
  end, { desc = "[/] Fuzzily search in current buffer]" })

  vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "[S]earch [F]iles" })
  vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "[S]earch [H]elp" })
  vim.keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "[S]earch current [W]ord" })
  vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "[S]earch by [G]rep" })
  vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "[S]earch [D]iagnostics" })
end

return M
