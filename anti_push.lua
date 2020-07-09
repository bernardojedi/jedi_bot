local itemIds = {3031, 3725, 3035, 3492}
local fieldIds = {2123,2121,2126}
local stackQuantity = 6

macro(100, "Anti Push", function()
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