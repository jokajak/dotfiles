local function openURLEvent(url)
    return function()
        return hs.urlevent.openURL(url)
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
        -- Define custom entity workflows
        local entityEvents = {
            { nil, "g", GoogleChrome, { "Entities", "Google Chrome" }},
            { nil, "f", Firefox, { "Entities", "Firefox" }},
            { nil, "v", VSCode, { "Entities", "VSCode" }},
        }
        -- Use relevant application entities that can have multiple windows to be available in select mode
        local selectEntityEvents = {
            { nil, "g", GoogleChrome, { "Entities", "Google Chrome" }},
            { nil, "f", Firefox, { "Entities", "Firefox" }},
            { nil, "v", VSCode, { "Entities", "VSCode" }},
        }
        local urlEvents = {
            { nil, "j", openURLEvent("https://jira.ctisl.gtri.gatech.edu/"), { "URL Events", "GTRI JIRA" } },
            { nil, "b", openURLEvent("https://bitbucket.hawkeyecloud.org/"), { "URL Events", "CESO Bitbucket" } },
        }
        s.workflowEvents = {
            url = urlEvents,
            entity = entityEvents,
            select = selectEntityEvents,
        }
        s.defaultEntities = {}
        s:start()
    end
})

