-- config
local parent = nil

-- script
local creatureId = 0
local itemId = 3155

macro(500, "Auto SD Attack", function()
	local creature = g_game.getAttackingCreature()
	subType = g_game.getClientVersion() >= 860 and 0 or 1
  if creature then
		g_game.useInventoryItemWith(itemId, creature, subType)
  end
end, parent)