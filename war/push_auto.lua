-- config
local pressedKey = nil
local parent = nil
local fieldIds = {2123, 2124, 2125, 2121, 2126}

-- script
local pushCreatureId = 0

local function getDistanceBetween(p1, p2)
  return math.max(math.abs(p1.x - p2.x), math.abs(p1.y - p2.y))
end

local auto_push = macro(100, "Auto Push - Distance", function()
  local attackingCreature = g_game.getAttackingCreature()
  local followingCreature = g_game.getFollowingCreature()
  local hasField = false
  if attackingCreature then
    pushCreatureId = attackingCreature:getId()
  end
  if followingCreature then
    pushCreatureId = followingCreature:getId()
  end
  if pushCreatureId > 0 then
    if pressedKey == '1' or pressedKey == '2' or pressedKey == '3' or pressedKey == '4' or pressedKey == '6' or pressedKey == '7' or pressedKey == '8' or pressedKey == '9' then
      local target = getCreatureById(pushCreatureId)
      if target then
        local targetPos = target:getPosition()
        local pos = {x=targetPos.x, y=targetPos.y, z=targetPos.z}
        local playerPos = player:getPosition()
        local path = nil
        if pressedKey == '1' or pressedKey == '4' or pressedKey == '7' then
          pos.x = pos.x - 1
        elseif pressedKey == '3' or pressedKey == '6' or pressedKey == '9' then
          pos.x = pos.x + 1
        end
        if pressedKey == '7' or pressedKey == '8' or pressedKey == '9' then
          pos.y = pos.y - 1
        elseif pressedKey == '1' or pressedKey == '2' or pressedKey == '3' then
          pos.y = pos.y + 1
        end
        local walkPos = {x=playerPos.x, y=playerPos.y, z=playerPos.z}
        if getDistanceBetween(playerPos, targetPos) == 1 then
          if playerPos.y < targetPos.y then
            walkPos.y = walkPos.y - 1
            path = findPath(playerPos, walkPos, 1, {})
          elseif playerPos.y > targetPos.y then
            walkPos.y = walkPos.y + 1
            path = findPath(playerPos, walkPos, 1, {})
          end
          if path == nil then
            walkPos = {x=playerPos.x, y=playerPos.y, z=playerPos.z}
            if playerPos.x < targetPos.x then
              walkPos.x = walkPos.x - 1
              path = findPath(playerPos, walkPos, 1, {})
            elseif playerPos.x > targetPos.x then
              walkPos.x = walkPos.x + 1
              path = findPath(playerPos, walkPos, 1, {})
            end
          end
          if path then
            walk(path[1])
          end
        end

        -- Destroy field if present
        local tile = g_map.getTile(pos)
        if tile then
          local topThing = tile:getTopUseThing()
          for i, fieldId in ipairs(fieldIds) do
            if topThing:getId() == fieldId then
              useWith(3148, topThing)
              delay(200)
            end
          end
        end

        g_game.move(target, pos, 1)
        delay(500)
      end
    end
  end
  pressedKey = nil
end)

onKeyPress(function(keys)
  if auto_push.isOn() and modules.game_walking.wsadWalking then
    if keys == '1' or keys == '2' or keys == '3' or keys == '4' or keys == '6' or keys == '7' or keys == '8' or keys == '9' then
      pressedKey = keys
    end
  end
end)