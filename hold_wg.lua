-- config
local marked_wg_tiles = {} -- Don't change anything here
local key = "PageDown" -- Change to the hotkey you would like to mark tiles with
local magicWallId = 2129
local magicWallTime = 20000

-- script
function tablefind(tab,el)
  for index, value in ipairs(tab) do
    if value == el then
      return index
    end
  end
end

local holdWGMacro = macro(10, "Hold WG", function()
  if table.getn(marked_wg_tiles) ~= 0 then
    for i, tile in pairs(marked_wg_tiles) do
      if getDistanceBetween(pos(), tile:getPosition()) > 7 then
        table.remove(marked_wg_tiles, tablefind(marked_wg_tiles, tile))
        tile:setText("")
      end
      if tile:getPosition().z == posz() then
        if tile and tile:getText() == "WG" and tile:getTimer() <= 275 or (tile:getTopThing():getId() ~= 2128 and tile:getTopThing():getId() ~= 2129 and tile:getTopThing():getId() ~= 2130) then
          useWith(3156, tile:getTopUseThing())
        end
      else
        table.remove(marked_wg_tiles, tablefind(marked_wg_tiles, tile))
      end
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
    if table.getn(marked_wg_tiles) ~= 0 then
      for i, tile in pairs(marked_wg_tiles) do
        table.remove(marked_wg_tiles, tablefind(marked_wg_tiles, tile))
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
  if holdWGMacro.isOn() then
    if keys == key and not resetTiles then
      local tile = getTileUnderCursor()
      if tile then
        if tile:getText() == "WG" then
          tile:setText("")
          table.remove(marked_wg_tiles, tablefind(marked_wg_tiles, tile))
        else
          tile:setText("WG")
          table.insert(marked_wg_tiles, tile)
        end
      end
    end
  end
end)