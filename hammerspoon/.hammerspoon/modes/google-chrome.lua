-- Google Chrome chooser
local chrome = {}
local tab_titles_applescript = [===[
-- AppleScript template for returning a record of application tab titles keyed by window id
-- `application` - name of any tabbable application (with AppleScript support)
tell application "Google Chrome"
	set windowTabTitles to {}
	set windowList to every window

	repeat with appWindow in windowList
		set ok to true
		set tabTitles to {}
		set appId to (id of appWindow as number)

		try
			set tabList to every tab of appWindow
		on error errorMessage
			set ok to false
		end try

		if ok then
			repeat with tabItem in tabList
				set tabURL to URL of tabItem
				set escapedTabTitle to my replaceString(name of tabItem, "\"", "\\\"")
				set tabTitles to tabTitles & ("\"" & (escapedTabTitle) & " (" & tabURL & ")" & "\"" as string)
			end repeat
		end if

		set AppleScript's text item delimiters to ", "
		set delimitedTitles to tabTitles as string
		set AppleScript's text item delimiters to ""

		set titles to run script "{|" & appId & "|:{" & (delimitedTitles as string) & "}}"
		set windowTabTitles to windowTabTitles & titles
	end repeat

	return windowTabTitles
end tell

on replaceString(targetText, searchString, replacementString)
	set AppleScript's text item delimiters to the searchString
	set the itemList to every text item of targetText
	set AppleScript's text item delimiters to the replacementString
	set targetText to the itemList as string
	set AppleScript's text item delimiters to ""
	return targetText
end replaceString
]===]

local function getSelectionItems()
    local choices = {}
    -- local script = "~/.hammerspoon/osascripts/chrome-tab-titles.applescript"
    local isOk, tabList, rawTable = hs.osascript.applescript(tab_titles_applescript)

    if not isOk then
        spoon.Flow.logger:e("Error fetching browser tab information", hs.inspect.inspect(rawTable.NSLocalizedFailureReason))
        hs.notify.show('Flow', 'Error fetching browser tab information', hs.inspect.inspect(rawTable.NSLocalizedFailureReason))
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

-- com.google.Chrome

function chrome.choice_handler(choice)
    if choice then
        local viewModel = fmt("window id %s to %s", choice.windowId, choice.tabIndex)
        spoon.Flow.logger:i(hs.inspect.inspect(viewModel))
        local script = fmt('tell application "Google Chrome" to set active tab index of %s', viewModel)
        spoon.Flow.logger:i(script)
        local isOk, _, rawTable = hs.osascript.applescript(script)

        if not isOk then
            spoon.Flow.logger:e("Error activating Google Chrome tab")
            hs.notify.show('Flow', 'Error activating Google Chrome tab', rawTable.NSLocalizedFailureReason)
        end
    end
    local app = hs.application.get('com.google.Chrome')
    if app then
        app:activate()
    end
end

function chrome.choose()
    chrome.chooser:choices(getSelectionItems)
end

chrome.chooser = hs.chooser.new(chrome.choice_handler)
chrome.chooser:showCallback(chrome.choose)

-- Miscellaneous google chrome tweaks
local ctrlTab = hs.hotkey.new({"ctrl"}, "tab", nil, function()
    hs.eventtap.keyStroke({"alt"}, "s")
end)

chromeWatcher = hs.application.watcher.new(function(name, eventType, app)
    if eventType ~= hs.application.watcher.activated then return end
    if name == "Google Chrome" then
        ctrlTab:enable()
    else
        ctrlTab:disable()
    end
end)

chromeWatcher:start()

return chrome
