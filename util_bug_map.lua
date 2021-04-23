local dist = 4

local upKey = 'T'
local downKey = 'G'
local leftKey = 'F'
local rightKey = 'H'

local bugMap = macro(1000, "Bug Map", function()

end)

onKeyPress(function(keys)
  if bugMap.isOn() and modules.game_walking.wsadWalking then
    if keys == upKey or keys == rightKey or keys == downKey or keys == leftKey then
      local playerPos = player:getPosition()
      --for d = dist, 1, -1 do
        local walkPos = {x=playerPos.x, y=playerPos.y, z=playerPos.z}
        if keys == upKey then
          walkPos.y = walkPos.y-dist
        end
        if keys == rightKey then
          walkPos.x = walkPos.x+dist
        end
        if keys == downKey then
          walkPos.y = walkPos.y+dist
        end
        if keys == leftKey then
          walkPos.x = walkPos.x-dist
        end
        local path = findPath(playerPos, walkPos, dist, { ignoreNonPathable = true, precision = dist })
        if path then
          autoWalk(path)
          delay(200)
          return
        end
      --end
    end
  end
end)