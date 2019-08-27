-- Window Management
local _lunette = spoon.Lunette

local function moveAndResize(option)
    if option == "maximize" then
        local win = hs.window.frontmostWindow()
        win:setFullscreen(not win:isFullscreen())
    else
        _lunette:exec(option)
    end
end

local mode = {
    trayColor = '#FE544D',
    hotkeys = {
        {nil, 'escape', false, 'previous'},
        {nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'},
        { nil, 'c', true, function() moveAndResize("center") end, 'Center window'},
        { nil, 'f', true, function() moveAndResize("fullScreen") end, 'Fullscreen'},
        { nil, 'm', true, function() moveAndResize("maximize") end, 'Maximize'},
        { nil, "z", false, function() moveAndResize("undo") end, "Undo" },
        { {"shift"}, "z", false, function() moveAndResize("redo") end, "Redo" },
        { nil, "down", true, function() moveAndResize("shrink") end, "Shrink" },
        { nil, "up", true, function() moveAndResize("expand") end, "Expand" },
    },
    activate = {hyper_modifiers, 'w'}
}

return mode
