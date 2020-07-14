-- Auto MWall Target
--[[
Description: Script will auto block current target you're attacking on the press of a hotkey

How to use: When you have a target, press the hotkey to shoot mwall infront of target

Author: Frosty
]]--

-- config
local key = "0" -- Hotkey to shoot mwall
local mwallId = 3180 -- Mwall ID
local squaresThreshold = 2 -- Amount of tiles to shoot infront of player

mwall_target = macro(100, "Mwall Target", function()

end)
-- script

onKeyDown(function(keys)
  if mwall_target.isOn() and modules.game_walking.wsadWalking and keys == key then
    local target = g_game.getAttackingCreature()
    if target then
      local targetPos = target:getPosition()
      local targetDir = target:getDirection()
      local mwallTile
      if targetDir == 0 then -- north
        targetPos.y = targetPos.y - squaresThreshold
        mwallTile = g_map.getTile(targetPos)
        useWith(mwallId, mwallTile:getTopUseThing())
      elseif targetDir == 1 then -- east
        targetPos.x = targetPos.x + squaresThreshold
        mwallTile = g_map.getTile(targetPos)
        useWith(mwallId, mwallTile:getTopUseThing())
      elseif targetDir == 2 then -- south
        targetPos.y = targetPos.y + squaresThreshold
        mwallTile = g_map.getTile(targetPos)
        useWith(mwallId, mwallTile:getTopUseThing())
      elseif targetDir == 3 then -- west
        targetPos.x = targetPos.x - squaresThreshold
        mwallTile = g_map.getTile(targetPos)
        useWith(mwallId, mwallTile:getTopUseThing())
      end
    end
  end
end)

UI.Separator()