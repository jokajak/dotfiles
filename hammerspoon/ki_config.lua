local function openURLEvent(url)
    return function()
        return hs.urlevent.openURL(url)
    end
end

local _lunette = spoon.Lunette

local function moveAndResize(option, exit_mode)
    if option == "maximize" then
        local win = hs.window.frontmostWindow()
        win:setFullscreen(not win:isFullscreen())
        hyper.triggered = true
    else
        _lunette:exec(option)
    end
    if exit_mode then
        spoon.Ki.state:exitMode()
    end
end

Install:andUse('Ki', {
    repo = "ki",
    fn = function(s)
        -- Create new Ki applications
        local Application = s.Application
        local GoogleChrome = Application:new("Google Chrome")
        local Firefox = Application:new("Firefox")
        local VSCode = Application:new("Visual Studio Code")
        local iTerm = Application:new("iTerm2")
        local Stickies = Application:new("Stickies")
        local XMind = Application:new("XMind")
        -- Define normal mode workflows
        local normalEvents = {
            { nil, "g", GoogleChrome, { "Entities", "Google Chrome" }},
            { nil, "f", Firefox, { "Entities", "Firefox" }},
            { nil, "v", VSCode, { "Entities", "Code" }},
            { nil, "i", iTerm, { "Entities", "iTerm2" }},
            { nil, "s", Stickies, { "Entities", "Stickies" }},
            { nil, "x", XMind, { "Entities", "XMind" }},
        }
        -- Define custom entity workflows
        local entityEvents = {
            { nil, "g", GoogleChrome, { "Entities", "Google Chrome" }},
            { nil, "f", Firefox, { "Entities", "Firefox" }},
            { nil, "v", VSCode, { "Entities", "Code" }},
            { nil, "i", iTerm, { "Entities", "iTerm2" }},
            { nil, "s", Stickies, { "Entities", "Stickies" }},
            { nil, "x", XMind, { "Entities", "XMind" }},
        }
        -- Use relevant application entities that can have multiple windows to be available in select mode
        local selectEntityEvents = {
            --{ nil, "g", GoogleChrome, { "Entities", "Google Chrome" }},
            --{ nil, "f", Firefox, { "Entities", "Firefox" }},
            { nil, "v", VSCode, { "Entities", "Code" }},
            { nil, "i", iTerm, { "Entities", "iTerm2" }},
        }
        local urlEvents = {
            { nil, "j", openURLEvent("https://jira.ctisl.gtri.gatech.edu/"), { "URL Events", "GTRI JIRA" } },
            { nil, "b", openURLEvent("https://bitbucket.hawkeyecloud.org/"), { "URL Events", "CESO Bitbucket" } },
            { {"shift"}, "b", openURLEvent("https://bitbucket.hawkeyecloud.org/"), { "URL Events", "Amtrak Bitbucket" } },
        }
        local actionEvents = {
            { nil, "c", function() moveAndResize("center", true) end, { "Action Events", "Center"} },
            { nil, "f", function() moveAndResize("fullScreen", true) end, { "Action Events", "Fullscreen"} },
            { nil, "m", function() moveAndResize("maximize", true) end, { "Action Events", "Maximize"} },
            { nil, "z", function() moveAndResize("undo") end, { "Action Events", "Undo"} },
            { {"shift"}, "z", function() moveAndResize("redo") end, { "Action Events", "Undo"} },
            { nil, "down", function() moveAndResize("shrink") end, { "Action Events", "Shrink"} },
            { nil, "up", function() moveAndResize("expand") end, { "Action Events", "Expand"} },
            { {'shift'}, "r", function() hs.reload() end, { "Action Events", "Reload Hammerspoon"} },
        }

        s.workflowEvents = {
            action = actionEvents,
            normal = normalEvents,
            url = urlEvents,
            entity = entityEvents,
            select = selectEntityEvents,
        }
        s.defaultEntities = {}
        s:start()
    end
})

