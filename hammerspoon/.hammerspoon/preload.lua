-- The default duration for animations, in seconds. Initial value is 0.2; set to 0 to disable animations.
hs.window.animationDuration = 0

-- Ensure hs.spoons gets created

-- auto reload config
local configFileWatcher = hs.pathwatcher
  .new(hs.configdir, function(files)
    local isLuaFileChange = utils.some(files, function(p)
      return not (string.match(p, "^.+/([^%.#][^/]+%.lua)$") == nil)
    end)
    if isLuaFileChange then
      hs.reload()
    end
  end)
  :start()

-- ensure CLI installed
hs.ipc.cliInstall()

-- helpful aliases
i = hs.inspect
fw = hs.window.focusedWindow
fmt = string.format
bind = hs.hotkey.bind
alert = hs.alert.show
clear = hs.console.clearConsole
reload = hs.reload
pbcopy = hs.pasteboard.setContents
std = hs.stdlib and require("hs.stdlib")
utils = hs.fnutils
-- hyper = {'⌘', '⌃'}
