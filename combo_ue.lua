-- auto 100 listas 'Bye' | setcolor 800 3399 999 | foreach 'newmessages' $ue if [ $ue.content == 'Bye' && $ue.sender == 'LIDER-NAME'] say 'exevo gran mas frigo'


macro(100, "Combo UE", function()
  onTalk(function(name, level, mode, text, channelId, pos)
    if text == storage.comboUECmd and name == storage.comboUELeader then
      say(storage.comboUESpell)
      delay(1000)
    end
  end)
end, parent)

UI.Label("Combo Leader:")
UI.TextEdit(storage.comboUELeader or "Palpatine", function(widget, newText)
  storage.comboUELeader = newText
end)

UI.Label("Combo Spell:")
UI.TextEdit(storage.comboUESpell or "exevo gran mas frigo", function(widget, newText)
  storage.comboUESpell = newText
end)

UI.Label("Combo Cmd:")
UI.TextEdit(storage.comboUECmd or "Bye", function(widget, newText)
  storage.comboUECmd = newText
end)