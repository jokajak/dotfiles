---
clickCircle = {}
types = {
  hs.eventtap.event.types['leftMouseDown'],
}
logger = hs.logger.new("circle")
logger.setLogLevel('debug')

function fn(event)
  local circle = clickCircle.circle
  local size = 40

  mousepoint = hs.mouse.absolutePosition()

  local color = {["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1}
  if nil == clickCircle.circle then
    clickCircle.circle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-(size/2), mousepoint.y-(size/2), size, size))
  else
    clickCircle.circle:setFrame(hs.geometry.rect(mousepoint.x-(size/2), mousepoint.y-(size/2), size, size))
  end
  clickCircle.circle:setStrokeColor(color)
  clickCircle.circle:setFill(false)
  clickCircle.circle:setStrokeWidth(5)
  clickCircle.circle:bringToFront(true)
  clickCircle.circle:setAlpha(1.0)
  if event:getType() == hs.eventtap.event.types.leftMouseDown then
    clickCircle.circle:hide(1)
  else
    clickCircle.circle:show(0)
  end

  return nil
end

-- from https://github.com/orosoiu/hammerspoon-scripts
local function fif(condition, if_true, if_false)
  if condition then return if_true else return if_false end
end

-- mouse pointer indicator: show a circle ripple effect around the mouse cursor
-- while clicking the left mouse button

-- config section
local animation = "sonar-out" -- valid values: sonar-out, sonar-in
local noOfCircles = 6 -- recommended to keep this below 10
local strokeColor = {
    ["rainbow"] = false, -- set to true to use random colors instead of colors defined below
    ["red"] = 192, -- between 0 and 255
    ["green"] = 41, -- between 0 and 255
    ["blue"] = 66, -- between 0 and 255
    ["alpha"] = 80 -- between 0 and 100
}
local fillColor = {
    ["enabled"] = false, -- set to true to enable color filling
    ["rainbow"] = false, -- set to true to use random colors instead of colors defined below
    ["red"] = 236, -- between 0 and 255
    ["green"] = 208, -- between 0 and 255
    ["blue"] = 120, -- between 0 and 255
    ["alpha"] = 20 -- between 0 and 100
}

function getAnimationSteps(animation)
    local animationConfig = {
        ["sonar-out"] = {
            ["start"] = 1,
            ["finish"] = noOfCircles,
            ["increment"] = 1
        },
        ["sonar-in"] = {
            ["start"] = noOfCircles,
            ["finish"] = 1,
            ["increment"] = -1
        },
        ["default"] = {
            ["start"] = 1,
            ["finish"] = noOfCircles,
            ["increment"] = 1
        }
    }
    if type(animationConfig[animation]) ~= nil then
        return animationConfig[animation]
    else
        return animationConfig.default
    end
end

local function showMousePointerIndicator()
    local mousepoint = hs.mouse.getAbsolutePosition()
    local animationSteps = getAnimationSteps(animation)
    local idx = 1
    for step = animationSteps.start, animationSteps.finish, animationSteps.increment do
        hs.timer.doAfter(.06 * idx, function()
            local diameter = 10 + (step * step * 2)
            local radius = diameter / 2
            local x = mousepoint.x - radius
            local y = mousepoint.y - radius
            local circle = hs.drawing.circle(hs.geometry.rect(x, y, diameter, diameter))
            circle:setStrokeColor({
                ["red"] = fif(strokeColor.rainbow, math.random(), strokeColor.red / 255),
                ["green"] = fif(strokeColor.rainbow, math.random(), strokeColor.green / 255),
                ["blue"] = fif(strokeColor.rainbow, math.random(), strokeColor.blue / 255),
                ["alpha"] = strokeColor.alpha / 100
            })
            circle:setStrokeWidth(step / 2)
            circle:setFill(fillColor.enabled)
            circle:setFillColor({
                ["red"] = fif(fillColor.rainbow, math.random(), fillColor.red / 255),
                ["green"] = fif(fillColor.rainbow, math.random(), fillColor.green / 255),
                ["blue"] = fif(fillColor.rainbow, math.random(), fillColor.blue / 255),
                ["alpha"] = fillColor.alpha / 100
            })
            circle:show()

            hs.timer.doAfter(.18, function()
                circle:delete()
            end)
        end)
        idx = idx + 1
    end
end

eventtapLeftMouseDown = hs.eventtap.new({ hs.eventtap.event.types.leftMouseDown },
    function(_)
        showMousePointerIndicator()
        return false
    end)
eventtapLeftMouseDown:stop()

clickCircle.eventTap = eventtapLeftMouseDown

return clickCircle
