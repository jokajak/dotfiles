-- Application mode
local function Application(nameOrId)
    local f = function()
        hs.alert.show("Launch "..nameOrId)
        local located_name = hs.application.nameForBundleID(nameOrId)
        if located_name then
            hs.application.launchOrFocusByBundleID(nameOrId)
        else
            hs.application.launchOrFocus(nameOrId)
        end
    end
    return f
end

local chrome = dofile('./modes/google-chrome.lua')
local firefox = dofile('./modes/firefox.lua')

local application = {
    trayColor = '#FE544D',
    hotkeys = {
        {nil, 'escape', false, 'previous'},
        {nil, 'c', true, function() chrome.chooser:show() end, 'Google Chrome' },
        {nil, 'f', true, Application('Firefox'), 'Firefox' },
        { { 'shift' }, 'f', true, function() firefox.chooser:show() end, 'Firefox Chooser' },
        {nil, 'i', true, Application('iTerm'), 'iTerm2' },
        {nil, 's', true, Application('Spotify'), 'Spotify' },
        {nil, 'v', true, Application('Visual Studio Code'), 'VS Code' },
        {nil, 'q', false, 'exit', 'Exit'},
        {nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'}
    },
    activate = {hyper_modifiers, 'a'}
}

return application
