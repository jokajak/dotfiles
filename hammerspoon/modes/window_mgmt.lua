-- Window Management
local _lunette = spoon.Lunette

local sizes = {2, 3, 3/2}
local fullScreenSizes = {1, 4/3, 2}

local GRID = {w = 24, h = 24}

local function moveAndResize(option)
    if option == "maximize" then
        local win = hs.window.frontmostWindow()
        win:setFullscreen(not win:isFullscreen())
    elseif option == "expand" then
        spoon.WinWin:moveAndResize(option)
    else
        _lunette:exec(option)
    end
end

local function resizeRight()
    spectacle.nextStep('w', true, function(cell, nextSize)
        cell.x = GRID.w - GRID.w / nextSize
        cell.w = GRID.w / nextSize
    end)
end

local function resizeLeft()
    spectacle.nextStep('w', false, function(cell, nextSize)
        cell.x = 0
        cell.w = GRID.w / nextSize
    end)
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
        { nil, "left", true, resizeLeft, "Resize Left" },
        { nil, "right", true, resizeRight, "Resize Right" },
        { {"cmd"}, "right", true, function() moveAndResize("nextDisplay") end, "Next Display" },
        { {"cmd"}, "left", true, function() moveAndResize("prevDisplay") end, "Previous Display" },
    },
    activate = {hyper_modifiers, 'w'}
}

return mode
