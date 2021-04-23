local gravId = 2130
local macheteId = 3308

setDefaultTab("Tools")
local m = macro(1000, "Auto Cut Grav", function() end)

onUse(function(pos, itemId, stackPos, subType)
  if m.isOff() then return end
  if itemId == 2130 then
    local tile = g_map.getTile(pos)
    local topThing = tile:getTopThing()
    g_game.useInventoryItemWith(macheteId, topThing, 0)
  end
end)

-- function checkForGrav(pos)
--   local tile = g_map.getTile(pos)
--   if tile then
--     local topThing = tile:getTopThing()
--     if topThing and table.find(gravIds, topThing:getId()) then
--       g_game.useInventoryItemWith(macheteId, topThing, 0)
--       delay(200)
--     end
--   end
-- end

-- onKeyPress(function(keys)
--   if m.isOff() then return end
--   local wsadWalking = modules.game_walking.wsadWalking
--   local pos = player:getPosition()
--   if keys == 'Up' or (wsadWalking and keys == 'W') then
--     pos.y = pos.y - 1
--   elseif keys == 'Down' or (wsadWalking and keys == 'S') then
--     pos.y = pos.y + 1
--   elseif keys == 'Left' or (wsadWalking and keys == 'A') then
--     pos.x = pos.x - 1
--   elseif keys == 'Right' or (wsadWalking and keys == 'D') then
--     pos.x = pos.x + 1
--   elseif (wsadWalking and keys == "Q") or (keys == "Up" and keys == "Left") then
--     pos.y = pos.y - 1
--     pos.x = pos.x - 1
--   elseif wsadWalking and keys == "E" then
--     pos.y = pos.y - 1
--     pos.x = pos.x + 1
--   elseif wsadWalking and keys == "Z" then
--     pos.y = pos.y + 1
--     pos.x = pos.x - 1
--   elseif wsadWalking and keys == "C" then
--     pos.y = pos.y + 1
--     pos.x = pos.x + 1
--   end
--   checkForGrav(pos)
-- end)