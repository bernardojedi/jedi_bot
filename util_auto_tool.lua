-- local ropes = {3003, 7731}
-- local shovels = {3457, 5710}
-- local machetes = {3308}
-- local scythes = {2550}
-- local squeezings = {10511, 10512, 10513, 10514, 10515, 10516}

-- local holeIds = {
--   384, 418, 8278, 8592,
-- 	294, 369, 370, 383, 392,
-- 	408, 409, 427, 428, 430,
-- 	462, 469, 470, 482, 484,
-- 	485, 489, 924, 3135, 3136,
-- 	7933, 7938, 8170, 8286, 8285,
-- 	8284, 8281, 8280, 8279, 8277,
-- 	8276, 8323, 8380, 8567, 8585,
-- 	8596, 8595, 8249, 8250, 8251,
-- 	8252, 8253, 8254, 8255, 8256,
-- 	8972, 9606, 9625
-- }

-- local shovelIds = {468, 481, 483, 7932, 8579}

-- local macheteIds = {2782, 3985, 7538, 7539}

-- local scytheIds = {2739}

-- --Insert squeezings to tool tables
-- for _,i in ipairs(squeezings) do 
--   table.insert(ropes, i)
--   table.insert(shovels, i)
--   table.insert(machetes, i)
--   table.insert(scythes, i)
-- end


-- local auto_use_tool = macro(100, "Auto Use Tool", function()

-- end)

-- local use_tool = function()

-- onUse(function(pos, itemId, stackPos, subType)
--   if auto_use_tool.isOn() then
--     -- Rope
--     for _, i in ipairs(holeIds) do
--       if itemId == i then

--       end
--     end
--   end
-- end)