-- URL Mode
local function openURLEvent(u) return function() return hs.urlevent.openURL(u) end end

local url_mode = {
    trayColor = '#FE544D',
    hotkeys = {
        {nil, 'escape', false, 'previous'},
        {nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'},
        { nil, "b", true, openURLEvent("https://bitbucket.org/"), "AFS Bitbucket" },
        { nil, "j", true, openURLEvent("https://novetta.atlassian.net/"), 'CESO JIRA' },
        { {"shift"}, "j", true, openURLEvent("https://jira.hawkeyecloud.org/"), 'CESO JIRA' },
        { nil, "t", true, openURLEvent("https://time.accenturefederal.com"), "Timesheet" },
        { {"shift"}, "b", true, openURLEvent("https://bitbucket.hawkeyecloud.org/"), "CESO Bitbucket" },
    },
    activate = {hyper_modifiers, 'u'}
}

return url_mode
