--[[ recursive binder ]]--

-- spoon to make it easy to have leader-key like functionality

local M = {}
-- spoon to make it easy to have leader-key like functionality
-- copied from https://nethuml.github.io/posts/2022/04/hammerspoon-global-leader-key/
M.config = {
  applications = {
    {
      bundleID = "org.mozilla.firefox",
      key = "f",
      name = "Firefox",
    },
    {
      bundleID = "net.kovidgoyal.kitty",
      key = "k",
      name = "kitty",
    },
    {
      bundleID = "com.microsoft.Outlook",
      key = "o",
      name = "Outlook",
    },
    {
      bundleID = "com.microsoft.teams",
      key = "t",
      name = "Teams",
    },
    {
      bundleID = "com.spotify.client",
      key = "s",
      name = "Spotify",
    },
  },
  domains = {
    {
      key = "b",
      name = "Bitbucket",
      url = "bitbucket.org",
    },
    {
      key = "j",
      name = "Jira",
      url = "novetta.atlassian.net",
    }
  },
  windows = {
    {
      mod = {},
      key = "k",
      name = "Monitor up",
      fn = function()
        local focused_window = hs.window.focusedWindow()
        focused_window:moveOneScreenNorth()
      end,
    },
    {
      mod = {},
      key = "j",
      name = "Monitor Down",
      fn = function()
        local focused_window = hs.window.focusedWindow()
        focused_window:moveOneScreenSouth()
      end,
    },
    {
      mod = {},
      key = "p",
      name = "Present",
      fn = function()
        local focused_window = hs.window.focusedWindow()
        focused_window:setSize(1280, 1024)
      end,
    },
    {
      mod = {},
      key = "g",
      name = "Grid",
      fn = function()
        hs.grid.show()
      end,
    }
  }
}

local singleKey = function(key, name)
  local mod = {}

  if name then
    return {mod, key, name}
  else
    return {mod, key, 'no name'}
  end
 end

M.applicationsKeyMap = {}
hs.fnutils.each(M.config.applications, function(app)
    M.applicationsKeyMap[singleKey(app.key, app.name)] = function()
      hs.application.launchOrFocusByBundleID(app.bundleID)
    end
end)

M.domainsKeyMap = {}
hs.fnutils.each(M.config.domains, function(domain)
    M.domainsKeyMap[singleKey(domain.key, domain.name)] = function()
      hs.urlevent.openURL("https://" .. domain.url)
    end
end)

M.windowsKeyMap = {}
hs.fnutils.each(M.config.windows, function(entry)
  print(entry.mod)
  print(entry.key)
  print(entry.name)
  print(entry.fn)
  M.windowsKeyMap[{entry.mod, entry.key, entry.name}] = entry.fn
end)

local keymap = {
  [{{}, 'd', 'domain+'}] = M.domainsKeyMap,
  [{{}, 'o', 'open+'}] = M.applicationsKeyMap,
  [{{}, 'w', 'window+'}] = M.windowsKeyMap,
  [singleKey('h', 'hammerspoon+')] = {
    [singleKey('r', 'reload')] = function() hs.reload() hs.console.clearConsole() end,
  }
}

M.fn = function(spn)
  hs.hotkey.bind({'option'}, 'space', spn.recursiveBind(keymap))
end

print("Loading recursive binder")
Install:andUse("RecursiveBinder", {
  fn = M.fn
})
