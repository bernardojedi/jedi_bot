UI.Label("Magic Wall")

-- config
local marked_tiles = {} -- Don't change anything here
local key = "PageUp" -- Change to the hotkey you would like to mark tiles with
local magicWallId = 2129

-- script
function tablefind(tab,el)
  for index, value in ipairs(tab) do
    if value == el then
      return index
    end
  end
end

local holdMWMacro = macro(10, "Hold Mwall", function()
  if table.getn(marked_tiles) ~= 0 then
    for i, tile in pairs(marked_tiles) do
      if getDistanceBetween(pos(), tile:getPosition()) > 7 then
        table.remove(marked_tiles, tablefind(marked_tiles, tile))
        tile:setText("")
      end
      local creatures = tile:getCreatures()
      if tile:getPosition().z == posz() then
        if tile and tile:getText() == "MWALL" and #creatures == 0 and (tile:isWalkable() or tile:getTimer()<=180) then
          useWith(3180, tile:getTopUseThing())
        end
      else
        table.remove(marked_tiles, tablefind(marked_tiles, tile))
      end
    end
  end
end)

onCreaturePositionChange(function(creature, newPos, oldPos)
  if holdMWMacro.isOn() and oldPos then
    local tile = g_map.getTile(oldPos)
    if tile and tile:getText() == "MWALL" and oldPos and oldPos.z == posz() then
      useWith(3180, tile:getTopUseThing())
    end
  end
end)

local resetTimer = 0
local resetTiles = false
onKeyDown(function(keys)
  if keys == key and resetTimer == 0 then
    resetTimer = now
  end
end)

onKeyPress(function(keys)
  if keys == key and (resetTimer - now) < -2500 then
    if table.getn(marked_tiles) ~= 0 then
      for i, tile in pairs(marked_tiles) do
        table.remove(marked_tiles, tablefind(marked_tiles, tile))
        tile:setText("")
      end
      resetTiles = true
    else
      resetTimer = 0
    end
  else
    resetTimer = 0
    resetTiles = false
  end
end)

onKeyUp(function(keys)
  if holdMWMacro.isOn() then
    if keys == key and not resetTiles then
      local tile = getTileUnderCursor()
      if tile then
        if tile:getText() == "MWALL" then
          tile:setText("")
          table.remove(marked_tiles, tablefind(marked_tiles, tile))
        else
          tile:setText("MWALL")
          table.insert(marked_tiles, tile)
        end
      end
    end
  end
end)

-- onCreaturePositionChange(function(creature, newPos, oldPos)
--   if table.getn(marked_tiles) ~= 0 then
--     for i, tile in pairs(marked_tiles) do
--       if tile:getPosition() == oldPos then
--         if tile and tile:getText() == "MWALL" then
--           useWith(3180, tile:getTopUseThing())
--         end
--       end
--     end
--   end
-- end)