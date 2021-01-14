if type(storage.uhPercent) ~= "table" then
    storage.uhPercent = {on=false, title="UH Friend HP%", min=0, max=60}
end

macro(100, function()
    if storage.uhPercent.on then
        local uhPercent = storage.uhPercent
        local dimension = modules.game_interface.getMapPanel():getVisibleDimension()
        local spectators = g_map.getSpectatorsInRangeEx(player:getPosition(), false, math.floor(dimension.width / 2), math.floor(dimension.width / 2), math.floor(dimension.height / 2), math.floor(dimension.height / 2))
        for _, creature in ipairs(spectators) do
            if creature:isPlayer() and
                player:getId() ~= creature:getId() and
                (creature:isPartyMember() or creature:getEmblem() == 1) and
                uhPercent.max >= creature:getHealthPercent() and
                creature:getHealthPercent() >= uhPercent.min 
            then
                g_game.useInventoryItemWith(3160, creature, subType)
                delay(500)
                break
            end
        end
    end
end)

UI.DualScrollPanel(storage.uhPercent, function(widget, newParams) 
    storage.uhPercent = newParams
end)
