---
clickCircle = {}
types = {
  hs.eventtap.event.types['leftMouseDown'],
  hs.eventtap.event.types['mouseMoved'],
}
logger = hs.logger.new("circle")
logger.setLogLevel('debug')

function fn(event)
  local circle = clickCircle.circle
  local size = 40

  mousepoint = hs.mouse.getAbsolutePosition()

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

clickCircle.eventTap = hs.eventtap.new(types, fn)

return clickCircle
