local key = "/"

local ropes = {3003, 7731}
local shovels = {3457, 5710}
local machetes = {3308}
local scythes = {2550}
local squeezings = {10511, 10512, 10513, 10514, 10515, 10516}

local holeIds = {
  384, 418, 8278, 8592,
	294, 369, 370, 383, 392,
	408, 409, 427, 428, 430,
	462, 469, 470, 482, 484,
	485, 489, 924, 3135, 3136,
	7933, 7938, 8170, 8286, 8285,
	8284, 8281, 8280, 8279, 8277,
	8276, 8323, 8380, 8567, 8585,
	8596, 8595, 8249, 8250, 8251,
	8252, 8253, 8254, 8255, 8256,
	8972, 9606, 9625
}

local shovelIds = {468, 481, 483, 7932, 8579}

local macheteIds = {2782, 3985, 7538, 7539}

local scytheIds = {2739}

local sewerIds = {435}

--Insert squeezings to tool tables
for _,i in ipairs(squeezings) do 
  table.insert(ropes, i)
  table.insert(shovels, i)
  table.insert(machetes, i)
  table.insert(scythes, i)
end


local auto_use_tool = macro(100, "Auto Use Tool", function()

end)

local useToolOnPos = function(toolItemIds, pos)
  for _, container in pairs(g_game.getContainers()) do
    for __, item in ipairs(container:getItems()) do
      for ___, i in ipairs(toolItemIds) do
        if item:getId() == i then
          return g_game.useInventoryItemWith(i, g_map.getTile(pos):getTopUseThing())
        end
      end
    end
  end
end

onKeyPress(function(keys)
  if auto_use_tool.isOn() and modules.game_walking.wsadWalking and keys == key then
    local tile = getTileUnderCursor()
    if tile then
      local tileItems = tile:getItems()
      for _, ti in ipairs(tile:getItems()) do

    --Sewers
        for __, i in ipairs(sewerIds) do
          if i == ti:getId() then
            g_game.use(ti)
            return
          end
        end

      end
    end
  end
end)

-- onUse(function(pos, itemId, stackPos, subType)
--   if auto_use_tool.isOn() then
--     local tile = g_map.getTile(pos)
--     if tile then
--       local tileItems = tile:getItems()
--       for _, ti in ipairs(tile:getItems()) do

--     --Sewers
--         for __, i in ipairs(sewerIds) do
--           if i == ti:getId() then
--             g_game.use(ti)
--             return
--           end
--         end

--       end
--     end

--     -- Rope
--     -- for _, i in ipairs(holeIds) do
--     --   for _, ti in ipairs(g_map.getTile(pos):getItems()) do
--     --     if i:getId() == ti:getId() then
--     --       useToolOnPos(ropes, pos)
--     --     end
--     --   end
--     -- end

--   end
-- end)