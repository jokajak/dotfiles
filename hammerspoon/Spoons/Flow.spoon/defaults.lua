--
local defaults = {
    normal = {
        trayColor = '#FFBD2E',
        hotkeys = {
            {nil, 'escape', false, 'exit'},
            {{'cmd'}, 'a', true, 'application'},
            {{'cmd'}, 'v', true, 'volume'},
        },
        activate = {{'cmd'}, 'escape'}
    },
    application = {
        trayColor = '#FE544D',
        hotkeys = {
            {nil, 'escape', false, 'previous'},
            {nil, 'c', true, function() hs.application.launchOrFocus('Chrome') end, 'Google Chrome' }
        },
        activate = {{'cmd','shift','ctrl'}, 'a'}
    }
}

return defaults
