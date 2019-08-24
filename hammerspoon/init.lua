require "preload"

split=dofile('./split.lua').split
url=dofile('./url.lua')
require "hyper"
require "routines"
require "spoons"
require "spectacle"
require "shortcuts"

hs.logger.defaultLogLevel="info"

-- from the online examples, send the clipboard as regular keystrokes
hs.hotkey.bind({"cmd", "alt"}, "V", function()
  hs.alert.show('pasting the hard way...')
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
