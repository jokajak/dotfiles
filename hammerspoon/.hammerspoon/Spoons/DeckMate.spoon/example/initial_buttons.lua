--- Initial buttons for DeckMate

-- from https://stackoverflow.com/questions/59561776/how-do-i-insert-a-string-into-another-string-in-lua
function string.insert(str1, str2, pos)
    return str1:sub(1,pos)..str2..str1:sub(pos+1)
end

local function weatherButtonForLocation(location)
    return {
        ['name'] = 'Weather',
        ['imageProvider'] = function()
            local url = "wttr.in?format=1"
            if location ~= nil then
                url = "wttr.in/" .. location
                url = url .. "?format=1"
            end
            local _status_code, output, _response_headers = hs.http.get(url)
            if _status_code ~= 200 then
                output = "Unk"
            end
            local fontSize = 40
            if location ~= nil then
                output = location .. '\n' .. output
                fontSize = 24
            end
            local options = {
                ['fontSize'] = fontSize,
                ['textColor'] = hs.drawing.color.lists()['System']['textColor']
            }
            return streamdeck_imageFromText(output, options)
        end,
        ['updateInterval'] = 1800,
    }
end

local lockButton = {
    ['name'] = 'Lock',
    ['image'] = streamdeck_imageFromText('􀎡'),
    ['onClick'] = function()
        hs.caffeinate.lockScreen()
    end
}

initial_button_states = {
    ["default"] = {
        ['name'] = 'Root',
        ['buttons'] = {
            lockButton,
            weatherButtonForLocation("Atlanta")
        }
    }
}
