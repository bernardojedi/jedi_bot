-- script
local creatureId = 0

macro(100, "Keep Follow", key, function()
  if g_game.getAttackingCreature() then
    creatureId = 0
    return
  end
  local creature = g_game.getFollowingCreature()
  if creature then
    creatureId = creature:getId()
  elseif creatureId > 0 then
    local target = getCreatureById(creatureId)
    if target then
      follow(target)
      delay(500)
    end
  end
end)

onKeyPress(function(keys)
  if keys == "Escape" then
    creatureId = 0
  end
end)