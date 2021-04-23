
key = ";"
local fieldIds = {2123, 2124, 2125, 2121, 2126}
local mwallIds = {2128, 2129, 2130}
local doorIds = {1672, 1673, 1651, 1652, 6249, 6250, 6251, 6252, 6253, 6254, 6262, 6263}

local targetTile

bugDoor = macro(10, "Bug Door", function()
    local flagDoor = false
    if targetTile and targetTile:getText() == "BUG DOOR" then
        for i, mwallId in ipairs(mwallIds) do
            if targetTile:getTopUseThing():getId() == mwallId then
                return
            end
        end
        for i, fieldId in ipairs(fieldIds) do
            if targetTile:getTopUseThing():getId() == fieldId then
                useWith(3148, targetTile:getTopUseThing()) -- destroy field
            end
        end
        for i, doorId in ipairs(doorIds) do
            if targetTile:getTopUseThing():getId() == doorId then
                flagDoor = true
            end
        end
        if flagDoor then
            use(targetTile:getTopUseThing()) -- use door
        else
            useWith(3197, targetTile:getTopUseThing()) -- desintegrate
        end
    end
end)

onKeyPress(function(keys)
    if bugDoor.isOn() then
        if keys == key then
            local tile = getTileUnderCursor()
            if tile then
                if tile:getText() == "BUG DOOR" then
                    tile:setText("")
                    targetTile = nil
                else
                    tile:setText("BUG DOOR")
                    targetTile = tile
                end
            end
        end
    end
end)