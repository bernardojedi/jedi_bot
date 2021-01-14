macro(100, "Drag Anti Push", function()
  local playerPos = player:getPosition()
  for x=-1,1 do
    for y=-1,1 do
      local pos = {x=playerPos.x+x, y=playerPos.y+y, z=playerPos.z}
      local tile = g_map.getTile(pos)
      local item = tile:getTopUseThing()
      if table.getn(tile:getItems()) > 1 then
        g_game.move(item, playerPos, item:getCount())
        --delay(100)
      end
    end
  end
end)

UI.Separator()