-- lib ver 1.21
-- Author: Vithrax
-- contains mostly basic function shortcuts and code shorteners

function string.starts(String,Start)
 return string.sub(String,1,string.len(Start))==Start
end
  
function isAttSpell(expr)
  if string.starts(expr, "exori") or string.starts(expr, "exevo") then
    return true
  else 
    return false
  end
end

function getPlayerByName(name)
    if not name then
        return false
    end

    local creature
    for i, spec in pairs(getSpectators()) do
        if spec:isPlayer() and spec:getName():lower() == name:lower() then
            creature = spec
        end
    end

    if creature then
        return creature
    end
end

function getActiveItemId(id)
    if not id then
        return false
    end

    if id == 3049 then
        return 3086
    elseif id == 3050 then
        return 3087
    elseif id == 3051 then
        return 3088
    elseif id == 3052 then
        return 3089
    elseif id == 3053 then
        return 3090
    elseif id == 3091 then
        return 3094
    elseif id == 3092 then
        return 3095
    elseif id == 3093 then
        return 3096
    elseif id == 3097 then
        return 3099
    elseif id == 3098 then
        return 3100
    elseif id == 16114 then
        return 16264
    elseif id == 23531 then
        return 23532
    elseif id == 23533 then
        return 23534
    elseif id == 23529 then
        return  23530
    else
        return id
    end
end

function getInactiveItemId(id)
    if not id then
        return false
    end

    if id == 3086 then
        return 3049
    elseif id == 3087 then
        return 3050
    elseif id == 3088 then
        return 3051
    elseif id == 3089 then
        return 3052
    elseif id == 3090 then
        return 3053
    elseif id == 3094 then
        return 3091
    elseif id == 3095 then
        return 3092
    elseif id == 3096 then
        return 3093
    elseif id == 3099 then
        return 3097
    elseif id == 3100 then
        return 3098
    elseif id == 16264 then
        return 16114
    elseif id == 23532 then
        return 23531
    elseif id == 23534 then
        return 23533
    elseif id == 23530 then
        return  23529
    else
        return id
    end
end

function getMonstersInRange(pos, range)
    if not pos or not range then
        return false
    end
    local monsters = 0
    for i, spec in pairs(getSpectators()) do
        if spec:isMonster() and spec:getType() ~= 3 and getDistanceBetween(pos, spec:getPosition()) < range then
            monsters = monsters + 1
        end
    end
    return monsters
end

function distanceFromPlayer(coords)
    if not coords then
        return false
    end
    return getDistanceBetween(pos(), coords)
end

function getMonsters(range)
    if not range then
        range = 10
    end
    local mobs = 0;
    for _, spec in pairs(g_map.getSpectators(pos(), false)) do
      mobs = spec:getType() ~= 3 and spec:isMonster() and distanceFromPlayer(spec:getPosition()) <= range and mobs + 1 or mobs;
    end
    return mobs;
end

function getPlayers(range)
    if not range then
        range = 10
    end
    local specs = 0;
    for _, spec in pairs(g_map.getSpectators(pos(), false)) do
        specs = not spec:isLocalPlayer() and spec:isPlayer() and distanceFromPlayer(spec:getPosition()) <= range and not (spec:getShield() >= 3 or spec:getEmblem() == 1) and specs + 1 or specs;
    end
    return specs;
end

function getAllPlayers(range)
    if not range then
        range = 10
    end
    local specs = 0;
    for _, spec in pairs(g_map.getSpectators(pos(), false)) do
        specs = not spec:isLocalPlayer() and spec:isPlayer() and distanceFromPlayer(spec:getPosition()) <= range and specs + 1 or specs;
    end
    return specs;
end

function getNpcs(range)
    if not range then
        range = 10
    end
    local npcs = 0;
    for _, spec in pairs(g_map.getSpectators(pos(), false)) do
        npcs = spec:isNpc() and distanceFromPlayer(spec:getPosition()) <= range and npcs + 1 or npcs;
    end
    return npcs;
end

function itemAmount(id)
    local totalItemCount = 0
    for _, container in pairs(getContainers()) do
        for _, item in ipairs(container:getItems()) do
            totalItemCount = item:getId() == id and totalItemCount + item:getCount() or totalItemCount 
        end
    end
    return totalItemCount
end

function cordsToPos(x, y, z)
    if not x or not y or not z then
        return false
    end
    local tilePos = pos()
     tilePos.x = x
     tilePos.y = y
     tilePos.z = z
    return tilePos
end

function reachGroundItem(id)
    local targetTile
    for _, tile in ipairs(g_map.getTiles(posz())) do
        if tile:getTopUseThing():getId() == id then
            targetTile = tile:getPosition()
        end
    end
    if distanceFromPlayer(targetTile) > 1 then
        if autoWalk(targetTile, 10, {ignoreNonPathable = true, precision=1}) then
            delay(200)
        end
    else
        return true
    end
end

function useGroundItem(id)
    if not id then
        return false
    end
    local targetTile = nil
    for _, tile in ipairs(g_map.getTiles(posz())) do
        if tile:getTopUseThing():getId() == id then
            targetTile = tile:getPosition()
        end
    end
    if targetTile then
        if distanceFromPlayer(targetTile) > 1 then
            if autoWalk(targetTile, 20, {ignoreNonWalkable = true, ignoreNonPathable = true, precision=1}) then
                delay(200)
            end
        else
            g_game.use(g_map.getTile(targetTile):getTopUseThing())
         return true
        end
    else
        return "retry"
    end
end

function target()
    if not g_game.isAttacking() then
        return 
    else
        return g_game.getAttackingCreature()
    end
end

function getTarget()
    return target()
end

function targetPos(dist)
    if not g_game.isAttacking() then
        return
    end
    if dist then
        return distanceFromPlayer(target():getPosition())
    else
        return target():getPosition()
    end
end

-- for gunzodus
function reopenPurse()
    schedule(100, function() g_game.open(findItem(23721)) return true end)
    schedule(1400, function() g_game.open(findItem(23721)) return true end)
    delay(2000)
	return true
end