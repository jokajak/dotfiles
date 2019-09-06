--

local mode = {
    trayColor = '#FE544D',
    hotkeys = {
        { nil, 'escape', false, 'previous'},
        { nil, 'tab', false, function() spoon.ModalMgr:toggleCheatsheet() end, 'Toggle Cheatsheet'},
        { nil, 'space', true, function() hs.spotify.playpause() end, 'Spotify: Play/pause' },
        { nil, 'n', true, function() hs.spotify.next() end, 'Spotify: Next' },
    },
    activate = {hyper_modifiers, 'm'}
}

return mode
