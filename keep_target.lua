-- config
local key = nil
local parent = nil

-- script
local creatureId = 0

macro(100, "Keep Attack", key, function()
  if g_game.getFollowingCreature() then
    creatureId = 0
    return
  end
  local creature = g_game.getAttackingCreature()
  if creature then
    creatureId = creature:getId()
  elseif creatureId > 0 then
    local target = getCreatureById(creatureId)
    if target then
      attack(target)
      delay(500)
    end
  end
end, parent)