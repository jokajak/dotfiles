--- Initial buttons for DeckMate
local buttonWidth = 96
local buttonHeight = 96

-- Shared cached canvas
local sharedCanvas = hs.canvas.new{ w = buttonWidth, h = buttonHeight }
local tintColor = hs.drawing.color.lists()['System']['systemOrangeColor']
local systemBackgroundColor = hs.drawing.color.lists()['System']['windowBackgroundColor']

local function randomColor()
    return {
        ['hue'] = math.random(255.0) / 255.0,
        ['saturation'] = math.random(2, 10) / 10,
        ['brightness'] = 1.0,
        ['alpha'] = 1.0
    }
end

-- Returns an image with the specified canvas contents
-- Canvas contents are a table of canvas commands
function streamdeck_imageWithCanvasContents(contents)
    sharedCanvas:replaceElements(contents)
    return sharedCanvas:imageFromCanvas()
end

-- Returns an image with the specified text, color, and background color
function streamdeck_imageFromText(text, options)
    local options = options or { }
    textColor = options['textColor'] or tintColor
    backgroundColor = options["backgroundColor"] or systemBackgroundColor
    font = options['font'] or ".AppleSystemUIFont"
    fontSize = options['fontSize'] or 70
    local elements = { }
    table.insert(elements, {
        action = "fill",
        frame = { x = 0, y = 0, w = buttonWidth, h = buttonHeight },
        fillColor = backgroundColor,
        type = "rectangle",
    })
    table.insert(elements, {
        frame = { x = 0, y = 0, w = buttonWidth, h = buttonHeight },
        text = hs.styledtext.new(text, {
            font = { name = font, size = fontSize },
            paragraphStyle = { alignment = "center" },
            color = textColor,
        }),
        type = "text",
    })
    return streamdeck_imageWithCanvasContents(elements)
end

local function weatherButtonForLocation(location)
    return {
        ['name'] = 'Weather',
        ['imageProvider'] = function()
            local url = "https://wttr.in/"
            if location ~= nil then url = url .. location end
            url = url .. "?format=1"

            local _status_code, output, _response_headers = hs.http.get(url)
            if _status_code ~= 200 then
                output = "Err"
            end
            local fontSize = 40
            if location ~= nil then
                output = location .. '\n' .. output
                fontSize = 24
            end
            local options = {
                ['fontSize'] = fontSize,
                ['textColor'] = hs.drawing.color.lists()['System']['textColor']
            }
            return streamdeck_imageFromText(output, options)
        end,
        ['updateInterval'] = 1800,
    }
end

local function peekButtonFor(bundleID)
    return {
        ['name'] = "Peek " .. bundleID,
        ['image'] = hs.image.imageFromAppBundle(bundleID),
        ['onClick'] = function()
            local app = hs.application.get(bundleID)
            if app == nil then
                hs.application.open(bundleID)
            end
            if app:isRunning() then
                if app:isFrontmost() then
                    app:hide()
                else
                    hs.application.open(bundleID)
                    app:activate()
                end
            else
                hs.application.open(bundleID)
            end
            return "pop"
        end,
        ['onLongPress'] = function(holding)
            local app = hs.application.get(bundleID)
            if app == nil then
                hs.application.open(bundleID)
                return
            end
            if holding then
                hs.application.open(bundleID)
                if app:isRunning() then
                    app:activate()
                end
            else
                if app:isRunning() then
                    app:hide()
                end
            end
        end
    }
end

local _hidden_apps = {
    bundleID = {
        ["Citrix.ServiceRecords"] = true,
        ["com.citrix.receiver.helper"] = true,
        ["com.zscaler.Zscaler"] = true,
    },
    path = {
        ["/Applications/Firefox.app/Contents/MacOS/plugin-container.app"] = true,
        ["/Applications/Microsoft Defender.app/Contents/MacOS/Microsoft Defender Helper.app"] = true,
        ["/Library/Manufacturer/Endpoint Agent/Symantec.app"] = true,
        ["/Applications/Microsoft Teams.app/Contents/Frameworks/Microsoft Teams Helper (Renderer).app"] = true,
        ["/Applications/BetterTouchTool.app/Contents/Resources/BTTRelaunch.app"] = true,
    }
}

local function appSwitcher()
    return {
        ['name'] = "App Switcher",
        ['image'] = streamdeck_imageFromText("􀮖"),
        ['children'] = function()
            local out = { }
            for _, app in pairs(hs.application.runningApplications()) do
                local bundleID = app:bundleID()
                if bundleID == nil then goto continue end
                local path = app:path()
                -- Strip out apps we don't want to pick from
                if path == nil then goto continue end
                if string.find(path, '/System/Library') then goto continue end
                if string.find(path, 'appex') then goto continue end
                if string.find(path, 'XPCServices') then goto continue end
                if _hidden_apps["bundleID"][bundleID] then goto continue end
                if _hidden_apps["path"][path] then goto continue end
                appButton = peekButtonFor(app:bundleID())
                out[#out+1] = appButton
                ::continue::
            end
            return out
        end
    }
end

local function windowSwitcher()
    return {
        ['name'] = "Window Switcher",
        ['image'] = streamdeck_imageFromText("􀏜"),
        ['children'] = function()
            local out = { }
            for _, window in pairs(hs.window.allWindows()) do
                local app = window:application()
                if app == nil then goto continue end
                local bundleID = app:bundleID()
                if bundleID == nil then goto continue end
                appButton = {
                    ['imageProvider'] = function()
                        local snap = window:snapshot()
                        local icon = hs.image.imageFromAppBundle(bundleID)
                        local elements = {}
                        table.insert(elements, {
                            type = "image",
                            image = snap,
                            imageScaling = "shrinkToFit"
                        })
                        table.insert(elements, {
                            type = "image",
                            image = icon,
                            frame = { x = 5, y = 5, w = 30, h = 30 }
                        })
                        return streamdeck_imageWithCanvasContents(elements)
                    end,
                    ['onClick'] = function()
                        window:unminimize()
                        window:becomeMain()
                        window:focus()
                        return "pop"
                    end
                }
                out[#out+1] = appButton
                ::continue::
            end
            return out
        end
    }
end

local lockButton = {
    ['name'] = 'Lock',
    ['image'] = streamdeck_imageFromText('🔒'),
    ['onClick'] = function()
        hs.caffeinate.lockScreen()
    end
}

local function repo_button(label, repo)
    return {
        ['name'] = "Repo Chooser",
        ['imageProvider'] = function()
            local output = label
            local options = {
                ['fontSize'] = fontSize,
                ['textColor'] = hs.drawing.color.lists()['System']['textColor']
            }
            return streamdeck_imageFromText(output, options)
        end,
        ['onClick'] = function()
            hs.execute("/usr/local/bin/code "..repo)
        end
    }
end

initial_button_states = {
    ["default"] = {
        ['name'] = 'Root',
        ['buttons'] = {
            weatherButtonForLocation("Atlanta"),
            appSwitcher(),
            windowSwitcher(),
            repo_button("amtrak_ansible", "~/git/amtrak/amtrak_ansible"),
            repo_button("portal", "~/git/amtrak/amtrak_portal"),
            repo_button("sws", "~/git/ceso/sws"),
            peekButtonFor("com.microsoft.teams"),
            peekButtonFor("org.mozilla.firefox"),
            peekButtonFor("com.microsoft.outlook"),
            peekButtonFor("com.spotify.client"),
            peekButtonFor("com.microsoft.edgemac"),
            lockButton,
        }
    }
}
