UI.Label("Push")

local itemIds = {3031, 3492}
local fieldIds = {2123,2121,2126}
local stackQuantity = 3

local anti_push = macro(100, "Anti Push", "5", function()
  local containers = g_game.getContainers()
  local playerPos = player:getPosition()
  local tile = g_map.getTile(playerPos)
  local topItem = tile:getTopUseThing()
  local flagField = false
  for i, item in ipairs(tile:getItems()) do
    for f, fieldId in ipairs(fieldIds) do
      if item:getId() == fieldId and i < stackQuantity then
        flagField = true
      end
    end
  end
  if table.getn(tile:getItems()) < stackQuantity or flagField then
    for index, container in pairs(containers) do
      if not container.lootContainer then -- ignore monster containers
        for i, item in ipairs(container:getItems()) do
          if item:getCount() > 1 then
            for m, itemId in ipairs(itemIds) do
              if item:getId() ~= topItem:getId() and item:getId() == itemId then
                g_game.move(item, playerPos, 2)
                delay(200)
              end
            end
          end
        end
      end
    end
  end
end)

local auto_anti_push = macro(100, "Anti Push Near Enemy", function()
  local playerPos = player:getPosition()
  local flag = false
  for x=-1,1 do
    for y=-1,1 do
      local pos = {x=playerPos.x+x, y=playerPos.y+y, z=playerPos.z}
      local tile = g_map.getTile(pos)
      if tile then
        for _, creature in ipairs(tile:getCreatures()) do
          if creature:getEmblem() == 2 then
            flag = true
          end
        end
      end
    end
  end
  if flag then
    anti_push.setOn()
  else
    anti_push.setOff()
  end
end)

-- addExtraHotkey("toogleAntiPush", "Enable/disable anti-push", function(repeated)
--   if repeated then
--     return
--   end
--   if anti_push.isOn() then
--     anti_push.enabled = true
--   else
--     anti_push.enabled = false
--   end    
-- end)