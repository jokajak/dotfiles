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
bind({"cmd", "alt"}, "V", function()
  alert('pasting the hard way...')
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
