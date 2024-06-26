local buttonWidth = 96
local buttonHeight = 96

-- A nonce button
local function randomColor()
  return {
    ["hue"] = math.random(255.0) / 255.0,
    ["saturation"] = math.random(2, 10) / 10,
    ["brightness"] = 1.0,
    ["alpha"] = 1.0,
  }
end

local systemBackgroundColor = hs.drawing.color.lists()["System"]["windowBackgroundColor"]

local function randomButton()
  return {
    ["name"] = "Nonce",
    ["imageProvider"] = function(context)
      local inset = 24
      local radius = 8
      local color = randomColor()
      local background = systemBackgroundColor
      if context["isPressed"] then
        background = color
        color = systemBackgroundColor
      end

      local elements = {}
      table.insert(elements, {
        action = "fill",
        frame = { x = 0, y = 0, w = buttonWidth, h = buttonHeight },
        fillColor = background,
        type = "rectangle",
      })
      table.insert(elements, {
        action = "fill",
        frame = { x = inset, y = inset, w = buttonWidth - 2 * inset, h = buttonHeight - 2 * inset },
        type = "rectangle",
        fillColor = color,
        roundedRectRadii = { ["xRadius"] = radius, ["yRadius"] = radius },
      })
      return streamdeck_imageWithCanvasContents(elements)
    end,
    ["updateInterval"] = 5,
  }
end

local function blankButton()
  return {
    ["name"] = "Nonce",
    ["imageProvider"] = function(context)
      local color = systemBackgroundColor
      local background = systemBackgroundColor
      if context["isPressed"] then
        background = color
        color = systemBackgroundColor
      end

      local elements = {}
      table.insert(elements, {
        action = "fill",
        frame = { x = 0, y = 0, w = buttonWidth, h = buttonHeight },
        fillColor = background,
        type = "rectangle",
      })
      return streamdeck_imageWithCanvasContents(elements)
    end,
    ["updateInterval"] = 10,
  }
end

function nonceButton()
  return randomButton()
end
