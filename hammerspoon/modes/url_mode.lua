-- URL Mode
local function openURLEvent(u) return function() return hs.urlevent.openURL(u) end end

local url_mode = {
    trayColor = '#FE544D',
    hotkeys = {
        {nil, 'escape', false, 'previous'},
        {nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'},
        { nil, "j", true, openURLEvent("https://jira.ctisl.gtri.gatech.edu/"), 'GTRI JIRA' },
        { nil, "b", true, openURLEvent("https://bitbucket.hawkeyecloud.org/"), "CESO Bitbucket" },
        { {"shift"}, "b", true, openURLEvent("https://bitbucket.hawkeyecloud.org/"), "Amtrak Bitbucket" },
    },
    activate = {hyper_modifiers, 'u'}
}

return url_mode
