
local spell_radius = 5
local n_monsters = 3

local autoUE = macro(1000, "Auto UE", function()
  local creatures = g_map.getSpectatorsInRange(player:getPosition(), false, spell_radius, spell_radius)
  local playersAround = false
  local monsters = 0
  for _, creature in ipairs(creatures) do
    if not creature:isLocalPlayer() and creature:isPlayer() and not creature:isPartyMember() then
      playersAround = true
    elseif creature:isMonster() then
      monsters = monsters + 1
    end
  end
  if monsters >= n_monsters and not playersAround then
    say(storage.autoUESpell)
  end
end, parent)

UI.Label("Spell:")
UI.TextEdit(storage.autoUESpell or "exevo gran mas vis", function(widget, newText)
  storage.autoUESpell = newText
end)

-- UI.Label("Spell Radius:")
-- if type(storage.autoUEradius) ~= "table" then
--   storage.autoUEradius = {on=false, title="Spell Radius", min=1, max=10}
-- end
-- UI.DualScrollPanel(storage.autoUEradius, function(widget, newParams) 
--   storage.autoUEradius = newParams
-- end)

-- UI.Label("Monsters:")
-- if type(storage.autoUEmonsters) ~= "table" then
--   storage.autoUEradius = {on=false, title="Monsters", min=1, max=10}
-- end
-- UI.DualScrollPanel(storage.autoUEmonsters, function(widget, newParams) 
--   storage.autoUEmonsters = newParams
-- end)

-- UI.Separator()