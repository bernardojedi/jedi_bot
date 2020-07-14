if type(storage.sioPercent) ~= "table" then
    storage.sioPercent = {on=false, title="Sio-HP%", min=0, max=60}
end

macro(100, "Auto Sio", function()

    local sioPercent = storage.sioPercent
    local dimension = modules.game_interface.getMapPanel():getVisibleDimension()
    local spectators = g_map.getSpectatorsInRangeEx(player:getPosition(), false, math.floor(dimension.width / 2), math.floor(dimension.width / 2), math.floor(dimension.height / 2), math.floor(dimension.height / 2))
    for _, creature in ipairs(spectators) do
        if creature:isPlayer() and creature:isPartyMember() and sioPercent.max >= creature:getHealthPercent() and creature:getHealthPercent() >= sioPercent.min then
            say("exura sio \""..creature:getName())
            delay(500)
            break
        end
    end
end)

UI.DualScrollPanel(storage.sioPercent, function(widget, newParams) 
    storage.sioPercent = newParams
end)