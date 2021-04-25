macro(1000, "Auto Res", function()
    local playerPos = player:getPosition()
    for x=-1,1 do
      for y=-1,1 do
        local pos = {x=playerPos.x+x, y=playerPos.y+y, z=playerPos.z}
        local tile = g_map.getTile(pos)
        for _,creature in ipairs(tile:getCreatures()) do
            if creature:isMonster() then
                say("exeta res")
                delay(1500)
                return
            end
        end
      end
    end
end)