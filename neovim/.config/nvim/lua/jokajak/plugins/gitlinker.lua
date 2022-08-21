--[[ gitlinker config ]]--
local status_ok, gitlinker = pcall(require, "gitlinker")

if not status_ok then
  return
end

local hosts = require("gitlinker.hosts")

gitlinker.setup({
  opts = {
    remote = nil, -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,
    -- callback for what to do with the url
    action_callback = require"gitlinker.actions".copy_to_clipboard,
    -- print the url after performing the action
    print_url = true,
  },
  callbacks = {
        ["github.com"] = hosts.get_github_type_url,
        ["gitlab.com"] = hosts.get_gitlab_type_url,
        ["try.gitea.io"] = hosts.get_gitea_type_url,
        ["codeberg.org"] = hosts.get_gitea_type_url,
        ["bitbucket.org"] = hosts.get_bitbucket_type_url,
        ["try.gogs.io"] = hosts.get_gogs_type_url,
        ["git.sr.ht"] = hosts.get_srht_type_url,
        ["git.launchpad.net"] = hosts.get_launchpad_type_url,
        ["repo.or.cz"] = hosts.get_repoorcz_type_url,
        ["git.kernel.org"] = hosts.get_cgit_type_url,
        ["git.savannah.gnu.org"] = hosts.get_cgit_type_url,
        ["bitbucket.hawkeyecloud.org"] = hosts.get_bitbucket_type_url,
  },
-- default mapping to call url generation with action_callback
  mappings = nil
})

-- Set up key mappings
local function set_keymap(mode, keys, fn, mapping_opts)
  mapping_opts = vim.tbl_extend(
    "force",
    { noremap = true, silent = true },
    mapping_opts or {}
  )
  vim.keymap.set(
    mode,
    keys,
    fn,
    mapping_opts
  )
end

set_keymap('n', '<leader>gll', '<cmd>lua require"gitlinker".get_buf_range_url("n") <CR>', { desc = "Get link to current line."})
set_keymap('n', '<leader>glf', '<cmd>lua require"gitlinker".get_buf_range_url("n", {add_current_line_on_normal_mode = false}) <CR>', { desc = "Get link to current file."})
set_keymap('v', '<leader>gll', '<cmd>lua require"gitlinker".get_buf_range_url("v") <CR>', { desc = "Get link to current file.", silent = false})
set_keymap('v', '<leader>glf', '<cmd>lua require"gitlinker".get_buf_range_url("v", {add_current_line_on_normal_mode = false}) <CR>', { desc = "Get link to current file.", silent = false})
set_keymap('n', '<leader>glr', '<cmd>lua require"gitlinker".get_repo_url()<cr>', { desc = "Get link to current repo", silent = true})
