
local comboSDMacro = macro(50, "Combo SD", nil, function()

end)

UI.Label("Combo Leader:")
UI.TextEdit(storage.comboSDLeader or "Palpatine", function(widget, newText)
  storage.comboSDLeader = newText
end)

onMissle(function(missle)
  if comboSDMacro.isOn() and missle:getId() == 32 then
    if not storage.comboSDLeader or storage.comboSDLeader:len() == 0 then
      return
    end
    local src = missle:getSource()
    if src.z ~= posz() then
      return
    end
    local from = g_map.getTile(src)
    local to = g_map.getTile(missle:getDestination())
    if not from or not to then
      return
    end
    local fromCreatures = from:getCreatures()
    local toCreatures = to:getCreatures()
    if #fromCreatures ~= 1 or #toCreatures ~= 1 then
      return
    end
    local c1 = fromCreatures[1]
    local c2 = toCreatures[1]
    if c1:getName():lower() == storage.comboSDLeader:lower() then
      g_game.useInventoryItemWith(3155, c2, 0)
    end
  end
end)