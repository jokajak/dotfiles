require "preload"

split=dofile('./split.lua').split
url=dofile('./url.lua')
require "hyper"
require "routines"
require "spectacle"
require "spoons"

hs.logger.defaultLogLevel="info"

-- from the online examples, send the clipboard as regular keystrokes
bind({"cmd", "alt"}, "V", function()
  alert('pasting the hard way...')
  clipboard_contents = hs.pasteboard.getContents()
  if clipboard_contents then
    hs.eventtap.keyStrokes(clipboard_contents)
  end
end)

--local _log = hs.logger.new('eventtap', 'debug')
--local function eventtap_debug(e)
--  _log.d(hs.inspect.inspect(e:getCharacters()))
--end
--eventtap_issue = hs.eventtap.new({hs.eventtap.event.types['keyDown']}, eventtap_debug)
--
