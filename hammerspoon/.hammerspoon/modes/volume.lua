-- Volume mode
local function turnVolumeDown()
    local newVolume = hs.audiodevice.current().volume - 10
    hs.audiodevice.defaultOutputDevice():setVolume(newVolume)
end

local function turnVolumeUp()
    local newVolume = hs.audiodevice.current().volume + 10
    hs.audiodevice.defaultOutputDevice():setVolume(newVolume)
end

local function toggleMute()
    local isMuted = hs.audiodevice.defaultOutputDevice():muted()
    hs.audiodevice.defaultOutputDevice():setMuted(isMuted)
end

local volume = {
    trayColor = '#FE544D',
    hotkeys = {
        { nil, 'escape', false, 'previous'},
        { nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'},
        { nil, "j", false, turnVolumeDown, "Turn Volume Down" },
        { nil, "k", false, turnVolumeUp, "Turn Volume Up" },
        { nil, "m", true, toggleMute, "Mute or Unmute Volume" },
    },
    activate = {hyper_modifiers, 'v'}
}

return volume
