local itemIds = {3507, 3031, 3492, 3035, 3029, 3725}

macro(10, "Collect Anti-Push", function()
  local containers = g_game.getContainers()
  for index, container in pairs(containers) do
    if not container.lootContainer then -- ignore monster containers
      local playerPos = player:getPosition()
      local tile = g_map.getTile(playerPos)
      local topItem = tile:getTopUseThing()
      local playerPos = player:getPosition()
      for x=-1,1 do
        for y=-1,1 do
          if not (y==0 and x==0) then
            for m, itemId in ipairs(itemIds) do
              local pos = {x=playerPos.x+x, y=playerPos.y+y, z=playerPos.z}
              local tile = g_map.getTile(pos)
              local item = tile:getTopUseThing()
              if item:getId() == itemId then
                g_game.move(item, container:getSlotPosition(container:getItemsCount()), item:getCount())
              end
            end
          end
        end
      end
      return
    end
  end
end)