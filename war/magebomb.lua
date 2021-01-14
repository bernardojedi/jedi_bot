-- config
local channel = "palpzDeathMagnetic" -- you need to edit this to any random string

local panelName = "magebomb"
local ui = setupUI([[
Panel
  height: 65

  BotSwitch
    id: title
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    text-align: center
    text: MageBomb

  OptionCheckBox
    id: mageBombLeader
    anchors.left: prev.left
    text: MageBomb Leader
    margin-top: 3

  BotLabel
    id: bombLeaderNameInfo
    anchors.left: parent.left
    anchors.top: prev.bottom
    text: Leader Name:
    margin-top: 3

  BotTextEdit
    id: bombLeaderName
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: prev.bottom
    margin-top: 3
  ]], mageBombTab)
ui:setId(panelName)

local useThings = {
  1948, 5542, 16693, 16692, 8065, 8263, 1968, 435
}

if not storage[panelName] then
  storage[panelName] = {
    mageBombLeader = false
  }
end
storage[panelName].mageBombLeader = false
ui.title:setOn(storage[panelName].enabled)
ui.title.onClick = function(widget)
  storage[panelName].enabled = not storage[panelName].enabled
  widget:setOn(storage[panelName].enabled)
end
ui.mageBombLeader.onClick = function(widget)
  storage[panelName].mageBombLeader = not storage[panelName].mageBombLeader
  widget:setChecked(storage[panelName].mageBombLeader)
  ui.bombLeaderNameInfo:setVisible(not storage[panelName].mageBombLeader)
  ui.bombLeaderName:setVisible(not storage[panelName].mageBombLeader)
end
ui.bombLeaderName.onTextChange = function(widget, text)
  storage[panelName].bombLeaderName = text
end
ui.bombLeaderName:setText(storage[panelName].bombLeaderName)

local oldPosition = nil
onPlayerPositionChange(function(newPos, oldPos)
  newTile = g_map.getTile(newPos)
  oldPosition = oldPos
  if newPos.z ~= oldPos.z then
    BotServer.send("goto", {pos=oldPos})
  end
end)
onAddThing(function(tile, thing)
  if not storage[panelName].mageBombLeader or not storage[panelName].enabled then
    return
  end
  if tile:getPosition().x == posx() and tile:getPosition().y == posy() and tile:getPosition().z == posz() and thing and thing:isEffect() then
    if thing:getId() == 11 then
      BotServer.send("goto", {pos=oldPosition})
    end
  end
end)

onUse(function(pos, itemId, stackPos, subType)
  for _, id in ipairs(useThings) do
    if itemId == id then
      BotServer.send("useItem", {pos=pos, itemId = itemId})
    end
  end
end)

onUseWith(function(pos, itemId, target, subType)
  if itemId == 3003 then
    BotServer.send("useItemWith", {itemId=itemId, pos = pos})
  elseif itemId == 3155 then
    BotServer.send("useItemWith", {itemId=itemId, targetId = target:getId()})
  end
end)

macro(300, function()
  if not storage[panelName].enabled and not storage[panelName].mageBombLeader then
    return
  end
  local target = g_game.getAttackingCreature()
  if target == nil then
    BotServer.send("attack", { targetId = 0 })
  else
    BotServer.send("attack", { targetId = target:getId() })
  end
end, mageBombTab)

macro(100, function()
  if not storage[panelName].enabled or name() == storage[panelName].bombLeaderName then
    return
  end
  local leader = getPlayerByName(storage[panelName].bombLeaderName)
  
  if leader then
    local leaderPos = leader:getPosition()
    local offsetX = posx() - leaderPos.x
    local offsetY = posy() - leaderPos.y
    local distance = math.max(math.abs(offsetX), math.abs(offsetY))
    if (distance > 1) then
      if not autoWalk(leaderPos, 10, {  minMargin=1, maxMargin=1, allowOnlyVisibleTiles = true}) then
        if not autoWalk(leaderPos, 10, { ignoreNonPathable = true, minMargin=1, maxMargin=1, allowOnlyVisibleTiles = true}) then
          if not autoWalk(leaderPos, 10, { ignoreNonPathable = true, ignoreCreatures = true, minMargin=1, maxMargin=1, allowOnlyVisibleTiles = true}) then
            return
          end
        end
      end
    end
  end
end, mageBombTab)

BotServer.init(name(), channel)

BotServer.listen("goto", function(senderName, message)
  if storage[panelName].enabled and name() ~= senderName and senderName == storage[panelName].bombLeaderName then
    position = message["pos"]

    if position.x ~= posx() or position.y ~= posy() or position.z ~= posz() then
      distance = getDistanceBetween(position, pos())
      autoWalk(position, distance, { ignoreNonPathable = true, precision = 1 })
    end
  end
end)

BotServer.listen("useItem", function(senderName, message)
  if storage[panelName].enabled and name() ~= senderName and senderName == storage[panelName].bombLeaderName then
    position = message["pos"]

    itemTile = g_map.getTile(position)
    for _, thing in ipairs(itemTile:getThings()) do
      if thing:getId() == message["itemId"] then
        g_game.use(thing)
      end
    end
  end
end)

BotServer.listen("useItemWith", function(senderName, message)
  if storage[panelName].enabled and name() ~= senderName and senderName == storage[panelName].bombLeaderName then
    if message["pos"] then
      tile = g_map.getTile(message["pos"])
      if tile then
        topThing = tile:getTopUseThing()
        if topThing then
          useWith(message["itemId"], topThing)
        end
      end
    else
      target = getCreatureById(message["targetId"])
      if target then
        usewith(message["itemId"], target)
      end
    end
  end
end)

BotServer.listen("attack", function(senderName, message)
  if storage[panelName].enabled and name() ~= senderName and senderName == storage[panelName].bombLeaderName then
    targetId = message["targetId"]
    if targetId == 0 then
      g_game.cancelAttackAndFollow()
    else
      leaderTarget = getCreatureById(targetId)

      target = g_game.getAttackingCreature()
      if target == nil then
        if leaderTarget then
          g_game.attack(leaderTarget)
        end
      else
        if leaderTarget and target:getId() ~= leaderTarget:getId() then
          g_game.attack(leaderTarget)
        end
      end
    end
  end
end)
