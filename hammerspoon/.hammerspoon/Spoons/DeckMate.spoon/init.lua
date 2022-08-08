--- === DeckMate ===
---
--- Stream Deck configuration manager
--- All credit goes to https://github.com/peterhajas/dotfiles/blob/master/hammerspoon/.hammerspoon/streamdeck.lua
---
--- Download:

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "DeckMate"
obj.version = "0.0.1"
obj.author = "jokajak <email>"
obj.homepage = ""
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new('deckmate', 'warning')

-- per https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md#code
StreamDeck = dofile(hs.spoons.resourcePath("stream_deck.lua"))

--- DeckMate:helloWorld()
--- Method
--- Hello World Spoon Sample
---
--- Parameters:
---  * name - A `string` value
---
--- Returns:
---  * None
---
--- Notes:
---  * None
function obj:helloWorld(name)
  print(string.format('Hello %s from %s', name, self.name))
end

--- DeckMate.initial_button_states
--- Variable
--- Initial button states
--- A table containing a list of initial button states. Each entry should be its own table in the format: `{ "scope", "initial button states" }`. Defaults to an empty table, which has the effect of not pushing any buttons. The scope can either be: "columnsxrows", a serialnumber, or default. DeckMate will choose the most specific matching entry when a StreamDeck is connected.
--- Each initial button state should be a table of button states with some values:
--- * image: the image
--- * stateProvider: optional state-providing function. `imageProvider` will only
---   be called when the state changes
--- * imageProvider: the function returning the image, taking context in a table:
---     * isPressed - whether the button is being pressed down
---     * location - table of `x` and `y` keys representing the button location
---         * zero-indexed
---     * size - table of `w` and `h` keys representing the deck size
---     * state - the state to act on, as returned by `stateProvider`
--- * onClick: the function to perform when being clicked
--- * onLongPress: the function to perform when being held down
---     - passed a boolean for if we're being held or released
--- * updateInterval: the desired update interval (if any) in seconds
--- * name: the name of the button
--- * children: function returning child buttons, which will be pushed
---
--- Internal values:
--- * _lastState: the last state we heard about for this button
--- * _lastImage: the last image we grabbed for this button
--- * _holdTimer: a timer for long-press events
--- * _isHolding: whether this button is being held down
obj.initial_button_states = { }

local function caffeinate_callback(event_type)
  if (event_type == hs.caffeinate.watcher.screensDidLock) then
    obj:lock()
  elseif (event_type == hs.caffeinate.watcher.screensDidUnlock) then
    obj:unlock()
  end
end


--- DeckMate:init()
--- Method
--- Initialize the module
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
---
--- Notes:
---  * None
function obj:init()
  --- perform module initialization

  -- keep an array of decks
  self.decks = {}

  -- keep track of machine state to prevent presses while locked
  self.machine_locked = false

  self.caffeinateWatcher = hs.caffeinate.watcher.new(caffeinate_callback)

  hs.streamdeck.init(function (...) return obj:streamdeck_discovery(...) end)
end

function obj:lock()
  self.logger.d("Locking decks")
  self.machine_locked = true
  for _, v in ipairs(self.decks) do
    self.logger.d("Locking: "..v.serial)
    v:lock()
  end
end

function obj:unlock()
  self.logger.d("Unlocking decks")
  self.machine_locked = false
  for _, v in ipairs(self.decks) do
    v:unlock()
  end
end

function obj:streamdeck_button_callback(deck, ...)
  local streamdeck = self:get_streamdeck(deck)
  streamdeck:button_callback(...)
end

function obj:streamdeck_discovery(connected, deck)
  self.logger.d("StreamDeck discovery callback")
  if connected and deck then
    -- deck has been connected, let's make sure we have a stream_deck object for it
    deck:buttonCallback(function(...) return obj:streamdeck_button_callback(...) end)
    local streamdeck = self:get_streamdeck(deck)
    streamdeck:connect(self.machine_locked, deck)
  else
    local streamdeck = self:get_streamdeck(deck)
    if streamdeck then streamdeck:disconnect() end
  end
end

function obj:get_streamdeck(deck)
  if not deck then return end
  local connected_serial_number = deck:serialNumber()
  for i, v in ipairs(self.decks) do
    if v.serial == connected_serial_number then
      return v
    end
  end
  local streamdeck = StreamDeck:new()
  streamdeck.serial = connected_serial_number
  streamdeck.deck = deck
  table.insert(self.decks, streamdeck)
  -- apply initial button state
  -- start from most generic to least generic
  local _initial_button_state = nil
  if self.initial_button_states["default"] ~= nil then
    _initial_button_state = cloneTable(self.initial_button_states["default"])
  end
  local columns, rows = deck:buttonLayout()
  if self.initial_button_states[columns .. "x".. rows] ~= nil then
    _initial_button_state = cloneTable(self.initial_button_states[columns .. "x" .. rows])
  end
  if self.initial_button_states[connected_serial_number] ~= nil then
    _initial_button_state = cloneTable(self.initial_button_states[connected_serial_number])
  end
  streamdeck.initial_button_state = (_initial_button_state or {})
  return streamdeck
end

function obj:start()
  self.logger.d("Starting DeckMate watchers")
  self.caffeinateWatcher:start()
end

function obj:stop()
  self.logger.d("Stopping DeckMate watchers")
  self.caffeinateWatcher:stop()
end

return obj
