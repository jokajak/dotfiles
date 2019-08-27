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

local application = {
    trayColor = '#FE544D',
    hotkeys = {
        {nil, 'escape', false, 'previous'},
        {nil, 'c', true, Application('Google Chrome'), 'Google Chrome' },
        {nil, 'f', true, Application('Firefox'), 'Firefox' },
        {nil, 'i', true, Application('iTerm2'), 'iTerm2' },
        {nil, 's', true, Application('Spotify'), 'Spotify' },
        {nil, 'v', true, Application('Visual Studio Code'), 'VS Code' },
        {nil, 'q', false, 'exit', 'Exit'},
        {nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'}
    },
    activate = {hyper_modifiers, 'a'}
}

return application
