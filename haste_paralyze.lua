-- -- config
-- local parent = nil

-- -- script
-- local creatureId = 0
-- local itemId = 3165

-- local haste_spells = {"utani hur", "utani gran hur", "utani tempo hur", "utamo tempo san"}

-- if type(storage.paralyzePercent) ~= "table" then
--     storage.paralyzePercent = {on=false, title="MP%", min=50, max=100}
-- end

-- macro(100, "Paralyze on Haste", function()
--     onTalk(function(name, level, mode, text, channelId, pos)
--         local creature = g_game.getAttackingCreature()
--         local paraPer = storage.paralyzePercent
--         local mp = math.min(100, math.floor(100 * (player:getMana() / player:getMaxMana())))
--         for _, spell in ipairs(haste_spells) do
--             if creature and text:lower() == spell and creature:isPlayer() and creature:getName() == name and paraPer.max >= mp and mp >= paraPer.min then
--                 subType = g_game.getClientVersion() >= 860 and 0 or 1
--                 g_game.useInventoryItemWith(itemId, creature, subType)
--                 delay(500)
--                 break
--             end
--         end
--     end)
-- end, parent)

-- UI.DualScrollPanel(storage.paralyzePercent, function(widget, newParams) 
--     storage.paralyzePercent = newParams
-- end)