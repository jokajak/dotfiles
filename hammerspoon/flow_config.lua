-- Configuration for Flow.spoon
local actions = {}

hyper_modifiers = {'ctrl','shift','alt','cmd'}

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

local clickCircle = dofile("./modes/click.lua")

function clickCircle_toggle()
  eventTap = clickCircle.eventTap
  if eventTap:isEnabled() then
    hs.notify.show('Flow', 'Click Tracking', 'Stopped')
    eventTap:stop()
    clickCircle.circle:hide()
  else
    hs.notify.show('Flow', 'Click Tracking', 'Started')
    eventTap:start()
  end
end

local normal = {
    trayColor = '#FFBD2E',
    hotkeys = {
        {nil, 'escape', false, 'exit'},
        {{'cmd'}, 'a', true, 'application', 'Application Mode'},
        {{'cmd'}, 'c', true, 'cheatsheet', 'Cheatsheet'},
        {{'cmd'}, 'e', true, 'expose', 'Exposé'},
        {{'cmd'}, 'h', true, 'hammerspoon', 'Hammerspoon'},
        {nil, 'm', true, clickCircle_toggle, 'Toggle Mouse Click Highlights'},
        {{'cmd'}, 'u', true, 'url', 'URL Mode'},
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
expose = hs.expose.new()
local expose_mode = {
    activate = {hyper_modifiers, 'e'},
    hotkeys = {
        { nil, 'escape', false, 'previous'},
        { nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'},
        { nil, 'e', true, function() expose:toggleShow() end, 'Toggle Expose'},
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
    expose = expose_mode,
    hammerspoon = hammerspoon,
    media = media,
    url = url_mode,
    volume = volume,
    window_mgmt = window_mgmt,
}

return config
