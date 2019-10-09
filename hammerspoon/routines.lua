local _log = hs.logger.new('routines', 'debug')
-- Take eye breaks, look away every 20 minutes
local function look_away()
    hs.alert.closeAll()
    local str = "Look 20 feet away for 20 seconds."
    _log.i('Screen break triggered')
    hs.fnutils.imap(hs.screen.allScreens(), function(screen)
        return hs.alert.show(str, hs.alert.defaultStyle, screen, 20)
    end)
end

eye_breaks = hs.timer.new(20*60, look_away)
eye_breaks:start()

-- Switch keyboard layout when kinesis is removed
-- the kinesis is programmed with a custom dvorak layout that assumes the mac is configured with a US layout
-- I want dvorak layout on the mac keyboard when I unplug the kinesis keyboard

local function _usb_handler(usb_info)
    local eventType = usb_info["eventType"]
    local productID = usb_info["productID"]
    local productName = usb_info["productName"]
    local vendorID = usb_info["vendorID"]
    local vendorName = usb_info["vendorName"]
    if eventType == "added" then
        if productID == 258 and vendorID == 10730 then
            hs.keycodes.setLayout('U.S.')
        else
            _log.i('Plugged in ' .. productName .. ' from ' .. vendorName)
        end
    elseif usb_info.eventType == "removed" then
        if productID == 258 and vendorID == 10730 then
            hs.keycodes.setLayout('Dvorak')
        else
            _log.i('Unplugged ' .. productName .. ' from ' .. vendorName)
        end
    else
        hs.alert(hs.inspect.inspect(usb_info))
    end
end
_usb_watcher = hs.usb.watcher.new(_usb_handler)
_usb_watcher:start()

_log.i('Loading')
