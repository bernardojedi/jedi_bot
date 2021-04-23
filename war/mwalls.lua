local mwall_step = macro(1000, "MW Step", "[", function() end)

onPlayerPositionChange(function(newPos, oldPos)
    if oldPos.z ~= posz() then return end
    if oldPos then
        local tile = g_map.getTile(oldPos)
        if mwall_step.isOn() and tile and tile:isWalkable() then
            useWith(3180, tile:getTopUseThing())
            mwall_step.setOff()
        end
    end
end)

local wg_step = macro(1000, "WG Step", "]", function() end)

onPlayerPositionChange(function(newPos, oldPos)
    if oldPos.z ~= posz() then return end
    if oldPos then
        local tile = g_map.getTile(oldPos)
        if wg_step.isOn() and tile and tile:isWalkable() then
            useWith(3156, tile:getTopUseThing())
            wg_step.setOff()
        end
    end
end)

-- local mwall_walk = macro(1000, "Mwall Target on Walk", "[", function() end)

-- onCreaturePositionChange(function(creature, newPos, oldPos)
--   if creature == g_game.getAttackingCreature() or creature == g_game.getFollowingCreature() then
--     if oldPos and oldPos.z == posz() then
--       local tile2 = g_map.getTile(oldPos)
--       if mwall_walk.isOn() and tile2:isWalkable() then
--         useWith(3180, tile2:getTopUseThing())
--         mwall_walk.setOff()
--       end 
--     end
--   end
-- end)

-- local function getDistanceBetween(p1, p2)
--   return math.max(math.abs(p1.x - p2.x), math.abs(p1.y - p2.y))
-- end

-- local marked_tile = nil
-- local key = "Pause" -- Change to the hotkey you would like to mark tiles with
-- local delay = 180

-- local win_mw = macro(10, "Win MW", function()
--   if marked_tile and pos().z == marked_tile:getPosition().z then
--     local timer = marked_tile:getTimer()
--     if timer and timer <= delay then
--       local pos = pos()
--       local tile_pos = marked_tile:getPosition()
--       local path = findPath(pos, tile_pos, {ignoreNonPathable = true, ignoreNonWalkable = true})
--       if path then
--         walk(path[1])
--       end
--       if pos.x == tile_pos.x and pos.y == tile_pos.y then
--         marked_tile:setText("")
--         marked_tile = nil
--       end
--     end
--   end
-- end)

-- onKeyUp(function(keys)
--   if win_mw.isOn() then
--     if keys == key then
--     local tile = getTileUnderCursor()
--       if tile and tile:getPosition().z == pos().z then
--         if tile:getText() == "Win MW" then
--           tile:setText("")
--           marked_tile = nil
--         elseif tile:getTopUseThing():getId() == 2128 or tile:getTopUseThing():getId() == 2129 then -- and getDistanceBetween(tile:getPosition(), pos()) == 1 then
--           tile:setText("Win MW")
--           marked_tile = tile
--         end
--       end
--     end
--   end
-- end)