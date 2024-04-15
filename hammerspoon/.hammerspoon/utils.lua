-- https://stackoverflow.com/a/32660766
-- ignore_mt means ignore metatables
function equals(o1, o2, ignore_mt)
  if o1 == o2 then
    return true
  end
  local o1Type = type(o1)
  local o2Type = type(o2)
  if o1Type ~= o2Type then
    return false
  end
  if o1Type ~= "table" then
    return false
  end

  if not ignore_mt then
    local mt1 = getmetatable(o1)
    if mt1 and mt1.__eq then
      --compare using built in method
      return o1 == o2
    end
  end

  local keySet = {}

  for key1, value1 in pairs(o1) do
    local value2 = o2[key1]
    if value2 == nil or equals(value1, value2, ignore_mt) == false then
      return false
    end
    keySet[key1] = true
  end

  for key2, _ in pairs(o2) do
    if not keySet[key2] then
      return false
    end
  end
  return true
end

-- https://stackoverflow.com/questions/2705793/how-to-get-number-of-entries-in-a-lua-table
function tableLength(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

-- Clones a table
function cloneTable(oldTable)
  local newTable = {}
  for k, v in pairs(oldTable) do
    newTable[k] = v
  end
  return newTable
end

-- Stops a timer from running
function stopTimer(timer)
  if timer ~= nil then
    timer:stop()
  end
end
