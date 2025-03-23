-- simple reminder to look away from the screen periodically
local module = {}

local drawing = require("hs.drawing")
local timer = require("hs.timer")
local uuid = require("hs.host").uuid
local _duration = 20

module._screenShades = {}
module._start_sound_name = "Morse"
module._stop_sound_name = "Blow"

local start_sound = require("hs.sound").getByName(module._start_sound_name)
local stop_sound = require("hs.sound").getByName(module._stop_sound_name)

local purgeShade = function(UUID)
  local indexToRemove
  for i, v in ipairs(module._screenShades) do
    if v.UUID == UUID then
      if v.timer then
        v.timer:stop()
      end
      v.drawing:hide()
      indexToRemove = i
      break
    end
  end
  if indexToRemove then
    table.remove(module._screenShades, indexToRemove)
  end
  stop_sound:play()
end

function module:shade()
  hs.alert.closeAll()
  local str = "Look 20 feet away for 20 seconds."
  hs.fnutils.imap(hs.screen.allScreens(), function(screen)
    local UUID = uuid()
    local shade = {
      drawing = drawing.rectangle(screen:fullFrame()),
      screen = screen,
      UUID = UUID,
    }

    --shade characteristics
    --white - the ratio of white to black from 0.0 (completely black) to 1.0 (completely white); default = 0.
    --alpha - the color transparency from 0.0 (completely transparent) to 1.0 (completely opaque)
    shade.drawing:setFillColor({ ["white"] = 0, ["alpha"] = 0.8 })

    --set to cover the whole screen, all spaces and expose
    shade.drawing:bringToFront(true):setBehavior(17)

    shade.drawing:show()
    table.insert(module._screenShades, shade)
    shade.timer = timer.doAfter(_duration, function()
      purgeShade(UUID)
    end)
    start_sound:play()
    return hs.alert.show(str, hs.alert.defaultStyle, screen, _duration)
  end)
end

-- Take eye breaks, look away every 20 minutes
module.timer = hs.timer.new(_duration * 60, module.shade)
module.timer:start()

local function screenSaverWatcher(event_type)
  if event_type == hs.caffeinate.watcher.screenDidLock then
    module.timer:stop()
  elseif event_type == hs.caffeinate.watcher.screensDidUnlock then
    module.timer:start()
  end
end

module.watcher = hs.caffeinate.watcher.new(screenSaverWatcher)

return module
