hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.jokajak = {
    url = "https://github.com/jokajak/mySpoons",
    desc = "jokajak's spoon repository",
}
spoon.SpoonInstall.repos.ki = {
    url = "https://github.com/jokajak/ki",
    desc = "jokajak's ki spoon repository",
}

spoon.SpoonInstall.repos.lunette = {
    url = "https://github.com/jokajak/lunette",
    desc = "jokajak's lunette spoon repository",
}

spoon.SpoonInstall.use_syncinstall = true
spoon.SpoonInstall:updateAllRepos()

Install=spoon.SpoonInstall

Install:andUse("Caffeine", {
    start = true,
})

-- network speed menubar entry
-- Install:andUse("SpeedMenu", { })
-- keybinding cheat sheet for current application
Install:andUse("KSheet", {})
-- window manipulation tools
Install:andUse("WinWin", {})
-- Push to talk functionality
Install:andUse("MicMute", {
  fn = function(s)
    s:bindHotkeys({ toggle = {nil, 'end'}}, 0.75)
  end
})
-- Manage modal hotkeys
Install:andUse("ModalMgr", { })

Install:andUse("ClipboardWatcher", {
  repo = "jokajak",
  fn = function(s)
    s:watch(
      -- matcher function. when it returns true, a correction will be suggested via notification
      function(data)
        return (string.match(data, "https?://smile%.amazon%.com") or string.match(data, "https?://www%.amazon%.com"))
      end,

      -- suggestion function. returned value will be applied if the notification is clicked
      function(original)
        local parsed_url = url.parse(original)
        -- Remove Amazon referral links
        parsed_url:setQuery({})

        local path_parts = split(parsed_url.path, "/")
        local new_path_parts = {}

        -- Remove extra url segments. Need to keep:
        -- ASIN length = 10
        -- weird url prefix length = 2 (dp, gp, etc)
        for _, part in pairs(path_parts) do
          local length = string.len(part)
          if length == 10 or length == 2 or part == "product" then
            table.insert(new_path_parts, part)
          end
        end

        parsed_url.path = table.concat(new_path_parts, "/")
        return parsed_url:build()
      end
    )
    s:start()
  end
})

-- horizontal calendar on desktop
Install:andUse("HCalendar", {
  config = {
    showProgress = true
  }
})

-- window management
Install:andUse("Lunette", {
    repo = "lunette"
})

Install:andUse("URLDispatcher", {
    config = {
      url_patterns = {
        { "https?://.*.www.amazon.com", "org.mozilla.firefox" },
        { "https?://.*.smile.amazon.com", "org.mozilla.firefox" },
        { "https?://smile.amazon.com", "org.mozilla.firefox" },
        { "https?://.*.kayses.us", "org.mozilla.firefox" },
        { "https?://.*.twitter.com", "org.mozilla.firefox" },
        { "https?://.*.facebook.com", "org.mozilla.firefox" },
        { "https://dod.teams.microsoft.us", "org.microsoft.edgemac" },
        { "https://jira.hawkeyecloud.org", "com.apple.Safari" },
        { "https://.*.sharepoint.us", "com.microsoft.edgemac" },
        { "https://accenturefederal.servicenowservices.com", "com.microsoft.edgemac" },
        { "https://afs365.sharepoint.com", "com.microsoft.edgemac" },
        { "msteams:", "com.microsoft.teams" },
      },
      url_redir_decoders = {
        -- Send MS Teams URLs directly to the app
        { "MS Teams URLs", "(https://gov.teams.microsoft.us/.*)", "msteams:%1", true },
      },
      default_handler = "org.mozilla.firefox",
    },
    start = true
})

flow_config = dofile("flow_config.lua")

Install:andUse("Flow", {
  config = {
    config = flow_config
  },
  fn = function(s)
    s:start()
    spoon.ModalMgr.supervisor:enter()
  end,
  loglevel = "debug",
  repo = "jokajak",
})

local localfile = hs.configdir .. "/init-local.lua"
if hs.fs.attributes(localfile) then
  dofile(localfile)
end

Install:andUse("DeckMate", {
  config = {
    initial_button_states = initial_button_states
  },
  loglevel = "debug",
  repo = "jokajak",
  start = true
})

local myGrid = { w = 6, h = 4 }
Install:andUse("WindowGrid",
               {
                 config = { gridGeometries =
                              { { myGrid.w .."x" .. myGrid.h } } },
                 start = true
               }
)

-- spoon to allow easy resize/movement
local SkyRocket = hs.loadSpoon("SkyRocket")

sky = SkyRocket:new({
  -- Opacity of resize canvas
  opacity = 0.3,

  -- Which modifiers to hold to move a window?
  moveModifiers = {'cmd', 'shift'},

  -- Which mouse button to hold to move a window?
  moveMouseButton = 'left',

  -- Which modifiers to hold to resize a window?
  resizeModifiers = {'ctrl', 'shift'},

  -- Which mouse button to hold to resize a window?
  resizeMouseButton = 'left',
})

pcall(require, "scoops.recursive_binder")

Install:andUse("FadeLogo", {
    config = {
      default_run = 0.5,
    },
    start = true
})
