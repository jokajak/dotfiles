-- Configuration for Flow.spoon
local actions = {}

hyper_modifiers = {'ctrl','shift','alt','cmd'}
local function getSelectionItems(app)
    local choices = {}
    local script = Application.renderScriptTemplate("application-tab-titles", { application = app})
    local isOk, tabList, rawTable = hs.osascript.applescript(script)

    if not isOk then
        Application.notifyError("Error fetching browser tab information", rawTable.NSLocalizedFailureReason)

        return {}
    end

    local windowIndex = 0

    for windowId, titleList in pairs(tabList) do
        windowIndex = windowIndex + 1
        for tabIndex, tabTitle in pairs(titleList) do
            local lastOpenParenIndex = tabTitle:match("^.*()%(")
            local title = tabTitle:sub(1, lastOpenParenIndex - 1)
            local url = tabTitle:sub(lastOpenParenIndex - #tabTitle - 1):match("%((.-)%)") or ""

            table.insert(choices, {
                text = title,
                subText = "Window "..windowIndex.." Tab #"..tabIndex.." - "..url,
                tabIndex = tabIndex,
                windowIndex = windowIndex,
                windowId = windowId,
            })
        end
    end

    return choices
end

function actions.focus(app, choice)
    if choice then
        local viewModel = { target = "window id "..choice.windowId.." to "..choice.tabIndex }
        local script = Application.renderScriptTemplate("focus-chrome-tab", viewModel)
        local isOk, _, rawTable = hs.osascript.applescript(script)

        if not isOk then
            Application.notifyError("Error activating Google Chrome tab", rawTable.NSLocalizedFailureReason)
        end
    end

    Application.focus(app)
end

local normal = {
    trayColor = '#FFBD2E',
    hotkeys = {
        {nil, 'escape', false, 'exit'},
        {{'cmd'}, 'a', true, 'application', 'Application Mode'},
        {{'cmd'}, 'c', true, 'cheatsheet', 'Cheatsheet'},
        {{'cmd'}, 'u', true, 'url', 'URL Mode'},
        {nil, 'v', true, function() spoon.VimMode:enter() end, 'VIM Mode'},
        {{'cmd'}, 'v', true, 'volume', 'Volume Mode'},
        {nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'}
    },
    activate = {{'cmd'}, 'escape'}
}

local cheatsheet = {
    activate = {hyper_modifiers, 'c'},
    hotkeys = {
        { nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'},
        { {'shift'}, '/', false, function() spoon.KSheet:show() end, 'Show App Cheatsheet'},
        { nil, 'escape', true, function() spoon.KSheet:hide() end, 'Hide App Cheatsheet' },
    }
}

local application = dofile("./modes/application.lua")
local volume = dofile("./modes/volume.lua")
local url_mode = dofile("./modes/url_mode.lua")

local config = {
    normal = normal,
    application = application,
    volume = volume,
    url = url_mode,
    cheatsheet = cheatsheet,
}

return config
