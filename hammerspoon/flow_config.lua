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
        {{'cmd'}, 'h', true, 'hammerspoon', 'Hammerspoon'},
        {{'cmd'}, 'u', true, 'url', 'URL Mode'},
        {nil, 'v', true, function() spoon.VimMode:enter() end, 'VIM Mode'},
        {{'cmd'}, 'v', true, 'volume', 'Volume Mode'},
        {{'cmd'}, 'w', true, 'window_mgmt', 'Window Management'},
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

local hammerspoon = {
    activate = {hyper_modifiers, 'h'},
    hotkeys = {
        { nil, 'escape', false, 'previous'},
        { nil, 'c', true, function() hs.console.hswindow():focus() end, 'Show console' },
        { nil, 'r', true, hs.reload, 'Reload Hammerspoon' },
    }
}

local application = dofile("./modes/application.lua")
local media = dofile("./modes/media.lua")
local url_mode = dofile("./modes/url_mode.lua")
local volume = dofile("./modes/volume.lua")
local window_mgmt = dofile("./modes/window_mgmt.lua")

local config = {
    normal = normal,
    application = application,
    cheatsheet = cheatsheet,
    hammerspoon = hammerspoon,
    media = media,
    url = url_mode,
    volume = volume,
    window_mgmt = window_mgmt,
}

return config
