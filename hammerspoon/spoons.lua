hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.jokajak = {
    url = "https://github.com/jokajak/mySpoons",
    desc = "jokajak's spoon repository",
}

spoon.SpoonInstall.use_syncinstall = true

Install=spoon.SpoonInstall

Install:andUse("Caffeine", {
    start = true,
})

-- network speed menubar entry
Install:andUse("SpeedMenu", { })
-- keybinding cheat sheet for current application
Install:andUse("KSheet", {})
-- horizontal calendar on desktop
Install:andUse("HCalendar", {})
-- circular clock on desktop
Install:andUse("CircleClock", {})
-- window manipulation tools
Install:andUse("WinWin", {})

-- alfred like tool
Install:andUse("Seal",
               {
                 hotkeys = { show = { {"cmd","alt","ctrl"}, "space" } },
                 fn = function(s)
                   s:loadPlugins({"apps", "calc", "screencapture", "useractions"})
                   s.plugins.useractions.get_favicon = true
                   s.plugins.useractions.actions =
                     {
                        ["Hammerspoon docs webpage"] = {
                            url = "https://hammerspoon.org/docs/",
                            icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
                          },
                        ["Create RAM Disk"] = {
                            keyword = "ramdisk",
                            fn = function(size)
                                if (size) then
                                    sectors = 1024*2048*size
                                    hs.alert.show('Creating RAM disk size: ' .. size .. '(' .. sectors ..')')
                                    disk_id, status, type, rc = hs.execute('hdiutil attach -nomount ram://'..sectors)
                                    hs.execute('diskutil erasevolume HFS+ "RAM disk" '.. disk_id)
                                else
                                    hs.alert.show('Must provide a size for the RAM disk.')
                                end
                            end,
                        },
                        ["Ansible Documentation"] = {
                            keyword = "ansible",
                            icon = 'favicon',
                            url = "https://docs.ansible.com/ansible/latest/modules/${query}_module.html"
                        }
                     }
                   s:refreshAllCommands()
                 end,
                 start = true,
               }
)

-- application menu
Install:andUse("MenuHammer", {
    repo = "jokajak",
    fn = function(s)
        s:enter()
    end
})

local localfile = hs.configdir .. "/init-local.lua"
if hs.fs.attributes(localfile) then
  dofile(localfile)
end

Install:andUse("FadeLogo",
               {
                 config = {
                   default_run = 1.0,
                 },
                 start = true
               }
)
