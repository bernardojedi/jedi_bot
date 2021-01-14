local dist = 5

local upKey = 'W'
local downKey = 'S'
local leftKey = 'A'
local rightKey = 'D'

local bugMap = macro(10, "Bug Map", function()

end)

onKeyPress(function(keys)
  if bugMap.isOn() and modules.game_walking.wsadWalking then
    if keys == upKey or keys == rightKey or keys == downKey or keys == leftKey then
      local playerPos = player:getPosition()
      for d = dist, 1, -1 do
        local walkPos = {x=playerPos.x, y=playerPos.y, z=playerPos.z}
        if keys == upKey then
          walkPos.y = walkPos.y-d
        end
        if keys == rightKey then
          walkPos.x = walkPos.x+d
        end
        if keys == downKey then
          walkPos.y = walkPos.y+d
        end
        if keys == leftKey then
          walkPos.x = walkPos.x-d
        end
        local path = findPath(playerPos, walkPos, d+5, {})
        if path then
          walk(path[1])
          delay(200)
          return
        end
      end
    end
  end
end)