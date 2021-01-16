local manaPotId = 238
local maxDistance = 1
local manaRecoveryPerSecond = 200
local potThreshold = 1000
local macroDelay = 200
local dmgExponentialDecay = 0.9791
local playerMinManaPer = 70

local dmgTable = {}
local dmgDecay = manaRecoveryPerSecond / (1000 / macroDelay)

function contains(table, element)
  for i, value in pairs(table) do
    if i == element then
      return true
    end
  end
  return false
end

local potFriend = macro(macroDelay, "Pot Friend", function()
	local target
	local targetDmg = 0
	for i, value in pairs(dmgTable) do
		if value ~= nil then
			local creature = getCreatureByName(i)
			if creature and value >= potThreshold and getDistanceBetween(pos(), creature:getPosition()) <= maxDistance then
				if value > targetDmg then
					targetDmg = value
					target = creature
				end
			end
			dmgTable[i] = (value - dmgDecay) * dmgExponentialDecay
			if value <= 0 then
				dmgTable[i] = nil
			end
		end
	end
	local playerMana = math.floor(100 * (player:getMana() / player:getMaxMana()))
	if target and playerMana > playerMinManaPer then
		g_game.useInventoryItemWith(manaPotId, target, 0)
		local targetName = target:getName()
		if dmgTable[targetName] ~= nil then
			dmgTable[targetName] = dmgTable[targetName] - dmgDecay
		end
	end
end)

onAnimatedText(function(thing, text)
	if potFriend.isOn() then
		local color = thing:getColor()
		if color["b"] == 255 and color["r"] == 0 and color["g"] == 0 then
			local tile = thing:getTile()
			local creatures = tile:getCreatures()
			if #creatures ~= 1 then return end
			local creature = creatures[1]
			if creature:isPlayer() and player:getId() ~= creature:getId() and (creature:isPartyMember() or creature:getEmblem() == 1) then
				local damage = tonumber(text)
				if damage then
					local name = creature:getName()
					if not contains(dmgTable, name) or dmgTable[name] == nil then
						dmgTable[name] = damage
					else
						dmgTable[name] = dmgTable[name] + damage
					end
				end
			end
		end
	end
end)

