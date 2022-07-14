---
-- Represent a stream deck object for state tracking
local StreamDeck = {
    -- the deck for which we are tracking the state
    deck = nil,

    logger = hs.logger.new('stream_deck', 'debug')
}

dofile(hs.spoons.resourcePath("button_images.lua"))
dofile(hs.spoons.resourcePath("nonce.lua"))

-- From https://www.lua.org/pil/16.1.html
function StreamDeck:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.asleep = false
    o.brightness = 30
    o.connected = false

    -- The currently visible button state
    -- Keys:
    -- - 'buttons' - the buttons
    -- - 'name' - the name
    -- - 'scrollOffset' - the scroll offset, which may wrap around, in rows
    if (not o.currentButtonState) then
        o.currentButtonState = {}
    end

    -- The stack of button states behind this one
    -- This is an array
    if (not o.buttonStateStack) then
        o.buttonStateStack = { }
    end

    -- Currently active update timers
    if (not o.currentUpdateTimers) then
        o.currentUpdateTimers = { }
    end

    -- Initial button state
    if (not o.initial_button_state) then
        o.initial_button_state = {}
    end
    return o
end

function StreamDeck:lock()
    -- self.logger.d("Locking "..self.serial)
    -- It's more secure to lock unconditionally
    self.asleep = true
    if (not self.connected) then
        -- self.logger.d("Not connected: "..self.serial.." therefore aborting.")
        return
    end
    self.asleep = true
    self:updateTimers()
    self.deck:setBrightness(0)
end

function StreamDeck:unlock()
    -- self.logger.d("Unlocking "..self.serial)
    -- We should only unlock the deck if it is connected
    if (not self.connected) then
        -- self.logger.d("Not connected: "..self.serial.." therefore aborting.")
        return
    end
    self.asleep = false
    self:updateTimers()
    self.deck:setBrightness(self.brightness)
    self:updateStreamdeckButtons()
end

-- Returns an update timer for button, if appropriate, and start it
function StreamDeck:updateTimerForButton(button, updateFunction)
    local updateInterval = button['updateInterval']
    if updateInterval == nil then return nil end
    local timer = hs.timer.new(updateInterval, updateFunction)
    timer:start()
    return timer
end

-- Updates `button`
function StreamDeck:updateButton(button, context)
    -- nil-checking
    if button == nil then return end
    -- self.logger.d("Updating " ..hs.inspect(button))
    -- self.logger.d("with " ..hs.inspect(context))
    local isStatic = button['image'] ~= nil
    local currentState = {}
    if isStatic then
        button['_lastImage'] = button['image']
    else
        local isDirty = false
        local stateProvider = button['stateProvider']
        if stateProvider == nil then
            isDirty = true
        else
            currentState = stateProvider() or { }
            local lastState = button['_lastState'] or { }
            isDirty = not equals(currentState, lastState, false)
            button['_lastState']  = currentState
        end
        if isDirty then
            local context = context or { }
            context['state'] = currentState
            local image = button['imageProvider'](context)
            button['_lastImage'] = image
        end
    end
end

function StreamDeck:updateTimers()
    self:disableTimers()
    if self.asleep or self.deck == nil or not self.connected then
        return
    end

    local current_buttons = self:currentlyVisibleButtons()
    for index, button in pairs(current_buttons) do
        local desiredUpdateInterval = button['updateInterval']
        if desiredUpdateInterval ~= nil then
            local timer = self:updateTimerForButton(button, function()
                self:updateStreamdeckButton(index)
            end)
            table.insert(self.currentUpdateTimers, timer)
        end
    end
end

-- Updates button update timers for all buttons
function StreamDeck:updateStreamdeckButtons()
    -- No StreamDeck? No update
    if self.deck == nil then return end

    local columns, rows = self.deck:buttonLayout()
    for i=1,columns*rows+1,1 do
        self:updateStreamdeckButton(i)
    end
end

-- Pops back to the last button state
function StreamDeck:popButtonState()
    -- Don't pop back past the first state
    if #self.buttonStateStack <= 1 then
        return
    end

    -- Grab new state
    local newState = self.buttonStateStack[#self.buttonStateStack]
    -- Remove from stack
    self.buttonStateStack[#self.buttonStateStack] = nil
    -- Empty the buttons
    self.currentButtonState = { }
    -- Replace
    self.currentButtonState = newState
    -- Update
    if self.deck ~= nil then
        self:updateStreamdeckButtons()
        self:updateTimers()
    end
end

function StreamDeck:scrollToTop()
    self.currentButtonState['scrollOffset'] = 0
    self:updateStreamdeckButtons()
end

function StreamDeck:scrollBy(amount)
    local currentScrollAmount = self.currentButtonState['scrollOffset'] or 0
    currentScrollAmount = currentScrollAmount + amount
    currentScrollAmount = math.max(0, currentScrollAmount)
    self.currentButtonState['scrollOffset'] = currentScrollAmount
    self:updateStreamdeckButtons()
end

-- Pushes `newState` onto the stack of buttons
function StreamDeck:pushButtonState(newState)
    -- Push current buttons back
    self.buttonStateStack[#self.buttonStateStack+1] = self.currentButtonState
    -- Empty the buttons
    self.currentButtonState = { }
    -- Replace
    self.currentButtonState = newState
    -- Update
    self:updateStreamdeckButtons()
    self:updateTimers()
end

-- Returns the currently visible buttons
function StreamDeck:currentlyVisibleButtons()
    local providedButtons = (self.currentButtonState['buttons'] or { })

    local currentButtons = cloneTable(providedButtons)
    local effectiveScrollAmount = self.currentButtonState['scrollOffset'] or 0
    local columns, rows = self.deck:buttonLayout()
    if effectiveScrollAmount > 0 then
        for i = 1,effectiveScrollAmount,1 do
            -- Drop columns-1 buttons
            for j = 1,columns-1,1 do
                table.remove(currentButtons, 1)
            end
        end
    end

    local totalButtons = columns * rows

    -- If we have a pushed button state, then add a back button
    if tableLength(self.buttonStateStack) > 1 then
        local closeButton = {
            ['image'] = streamdeck_imageFromText('􀯶'),
            ['onClick'] = function() self:popButtonState() end
        }
        table.insert(currentButtons, 1, closeButton)
    end

    -- Pad with nonces
    while tableLength(currentButtons) < totalButtons do
        table.insert(currentButtons, nonceButton())
    end

    -- If we need to scroll, then insert buttons at the right indices
    -- This should be the far left, under the top left button
    if tableLength(providedButtons) > totalButtons then
        local scrollUp = {
            ['image'] = streamdeck_imageFromText('􀃾'),
            ['onClick'] = function()
                self:scrollBy(-1)
            end,
            ['onLongPress'] = function()
                self:scrollToTop()
            end
        }
        local scrollDown = {
            ['image'] = streamdeck_imageFromText('􀄀'),
            ['onClick'] = function()
                self:scrollBy(1)
            end
        }
        -- Add scroll up, scroll down, and a nonce to pad
        table.insert(currentButtons, columns + 1, scrollUp)
        table.insert(currentButtons, columns * 2 + 1, scrollDown)
        table.insert(currentButtons, columns * 3 + 1, nonceButton())
    end

    -- Remove until we're at the desired length
    while tableLength(currentButtons) > totalButtons do
        table.remove(currentButtons)
    end

    return currentButtons
end

function StreamDeck:updateStreamdeckButton(i, pressed)
    -- No StreamDeck? No update
    if self.deck == nil then return end

    local button = self:currentlyVisibleButtons()[i]

    local context = self:contextForIndex(i)
    if pressed ~= nil then
        context['isPressed'] = pressed
    end

    self:updateButton(button, context)

    if button ~= nil then
        local image = button['_lastImage']
        if image ~= nil then
            self.deck:setButtonImage(i, image)
        end
    end
end

function StreamDeck:contextForIndex(i)
    local columns, rows = self.deck:buttonLayout()

    local deckSize = {
        ['w'] = columns,
        ['h'] = rows,
    }
    local locationIndex = i - 1
    local location = {
        ['x'] = locationIndex % columns,
        ['y'] = math.floor(locationIndex / columns),
    }

    local context = {
        ['location'] = location,
        ['size'] = deckSize,
        ['isPressed'] = false,
    }

    return context
end

function StreamDeck:button_callback(buttonID, pressed)
    -- Don't allow commands while the machine is asleep / locked
    if self.asleep then
        return
    end

    -- Grab the button
    local buttonForID = self:currentlyVisibleButtons()[buttonID]
    if buttonForID == nil then
        self:updateStreamdeckButton(buttonID, pressed)
        return
    end

    local context = self:contextForIndex(buttonID)

    -- Grab its actions
    local click = buttonForID['onClick'] or function() end
    local hold = buttonForID['onLongPress'] or function() end

    -- Dispatch
    if pressed then
        self:updateStreamdeckButton(buttonID, true)
        buttonForID['_holdTimer'] = hs.timer.new(0.3, function()
            hold(true)
            buttonForID['_isHolding'] = true
            stopTimer(buttonForID['_holdTimer'])
        end)
        buttonForID['_holdTimer']:start()
    else
        self:updateStreamdeckButton(buttonID, false)
        if buttonForID['_isHolding'] ~= nil then
            hold(false)
        else
            local _ret = click(context)
            if _ret == "pop" then
                self:popButtonState()
            end

            local pushedState = self:buttonStateForPushedButton(buttonForID)
            if pushedState ~= nil then
                self:pushButtonState(pushedState)
            end
        end

        stopTimer(buttonForID['_holdTimer'])
        buttonForID['_isHolding'] = nil
    end
end

-- Returns a buttonState for pushing pushButton's children onto the stack
function StreamDeck:buttonStateForPushedButton(pushedButton)
    local children = pushedButton['children']
    if children == nil then return nil end

    local columns, rows = self.deck:buttonLayout()
    local deckSize = {
        ['w'] = columns,
        ['h'] = rows,
    }
    local context = {
        ['size'] = deckSize,
    }

    children = children(context)

    local outState = {
        ['name'] = pushedButton['name'],
        ['buttons'] = children
    }

    return outState
end

-- Handle when the deck is connected
function StreamDeck:connect(is_asleep, deck)
    if self.deck == nil then return end
    self.deck = deck

    self.connected = true
    self.asleep = is_asleep

    self.deck:reset()
    self:updateStreamdeckButtons()
    self:updateTimers()

    -- reset button state stack
    self.buttonStateStack = {}

    self:pushButtonState(self.initial_button_state)
end

-- Handle when the deck is disconnected
function StreamDeck:disconnect()
    if self.deck == nil then return end
    self.connected = false
    self:updateTimers()
end

-- Disable all timers for all buttons
function StreamDeck:disableTimers()
    for _, timer in pairs(self.currentUpdateTimers) do
        stopTimer(timer)
    end

    -- forget about all previous timers
    self.currentUpdateTimers = { }

    for _, state in pairs(self:allButtonStates()) do
        for _, button in pairs(state['buttons'] or {}) do
            stopTimer(button['_holdTimer'])
            button['_holdTimer'] = nil
        end
    end
end

-- Returns all the button states managed by the system
function StreamDeck:allButtonStates()
    local allStates = cloneTable(self.buttonStateStack)
    table.insert(allStates, 1, self.currentButtonState)
    return allStates
end

return StreamDeck
