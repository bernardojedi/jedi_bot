local fieldIds = {2123, 2124, 2125, 2121, 2126}
local aditionalDelay = 20

pushPanelName = "pushmax"

local ui = setupUI([[
Panel
  height: 19

  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('Auto Push - Close')

  Button
    id: push
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Setup

]])
ui:setId(pushPanelName)

if not storage[pushPanelName] then
  storage[pushPanelName] = {
    enabled = true,
    pushDelay = 1060,
    pushMaxRuneId = 3188,
    mwallBlockId = 2128,
    pushMaxKey = "PageDown"
  }
end

ui.title:setOn(storage[pushPanelName].enabled)
ui.title.onClick = function(widget)
storage[pushPanelName].enabled = not storage[pushPanelName].enabled
widget:setOn(storage[pushPanelName].enabled)
end

ui.push.onClick = function(widget)
  pushWindow:show()
  pushWindow:raise()
  pushWindow:focus()
end

rootWidget = g_ui.getRootWidget()
if rootWidget then
  pushWindow = g_ui.createWidget('PushMaxWindow', rootWidget)
  pushWindow:hide()

  pushWindow.closeButton.onClick = function(widget)
    pushWindow:hide()
  end

  local updateDelayText = function()
    pushWindow.delayText:setText("Push Delay: ".. storage[pushPanelName].pushDelay)
  end
  updateDelayText()
  pushWindow.delay.onValueChange = function(scroll, value)
    storage[pushPanelName].pushDelay = value
    updateDelayText()
  end
  pushWindow.delay:setValue(storage[pushPanelName].pushDelay)

  pushWindow.runeId.onItemChange = function(widget)
    storage[pushPanelName].pushMaxRuneId = widget:getItemId()
  end
  pushWindow.runeId:setItemId(storage[pushPanelName].pushMaxRuneId)
  pushWindow.mwallId.onItemChange = function(widget)
    storage[pushPanelName].mwallBlockId = widget:getItemId()
  end
  pushWindow.mwallId:setItemId(storage[pushPanelName].mwallBlockId)

  pushWindow.hotkey.onTextChange = function(widget, text)
    storage[pushPanelName].pushMaxKey = text
  end
  pushWindow.hotkey:setText(storage[pushPanelName].pushMaxKey)
end


function matchPosition(curX, curY, destX, destY)
  return (curX == destX and curY == destY)
end

local target
local targetTile
local targetOldPos

macro(10, function()
  if not storage[pushPanelName].enabled then return end
  local atkCreature = g_game.getAttackingCreature()
  local flwCreature = g_game.getFollowingCreature()
  if targetTile and targetTile:getTimer() <= 0 and targetTile:getText():find("^TARGET ") ~= nil then
    targetTile:setText("")
    targetTile = nil
  end
  if atkCreature then
    target = atkCreature
  end
  if flwCreature then
    target = flwCreature
  end
  if target ~= nil and targetTile then
    local tile = g_map.getTile(target:getPosition())
    targetOldPos = tile:getPosition()
    local field = false
    for i, fieldId in ipairs(fieldIds) do
      if targetTile:getTopUseThing():getId() == fieldId then
        field = true
      end
    end
    local flagAntiPush = tile:getTopUseThing():isPickupable() or not tile:getTopUseThing():isNotMoveable()
    local flagMW = false
    if target and targetTile:getText() == "TARGET MWALL IN: " then
      flagMW = true
    end
    if not matchPosition(target:getPosition().x, target:getPosition().y, targetTile:getPosition().x,  targetTile:getPosition().y) then
      if tile then
        local flagAntiPush = tile:getTopUseThing():isPickupable() or not tile:getTopUseThing():isNotMoveable()
        if targetTile:getTopThing():getId() == 2129 or targetTile:getTopThing():getId() == 2130 or targetTile:getTopThing():getId() == tonumber(storage[pushPanelName].mwallBlockId) then
          if targetTile:getTimer() <= tonumber(storage[pushPanelName].pushDelay) then
            if flagAntiPush then
              useWith(tonumber(storage[pushPanelName].pushMaxRuneId), target) -- 3197 desintigrate rune / 3188 firebomb rune
            end
            g_game.move(target, targetTile:getPosition())
            delay(tonumber(storage[pushPanelName].pushDelay))
            -- if flagMW then
            --   delay(500)
            --   useWith(3180, tile:getTopUseThing())
            -- end
            -- tile:setText("")
            -- targetTile:setText("")
            -- target = nil
            -- targetTile = nil
          end
        elseif field then  -- Destroy field if present
          useWith(3148, targetTile:getTopUseThing())
          delay(tonumber(storage[pushPanelName].pushDelay)+aditionalDelay)
          g_game.move(target, targetTile:getPosition())
          delay(storage[pushPanelName].pushDelay)
        elseif flagMW then
          g_game.move(target, targetTile:getPosition())
          delay(tonumber(storage[pushPanelName].pushDelay)+aditionalDelay)
          useWith(3180, tile:getTopUseThing())
        else
          if flagAntiPush then
            useWith(tonumber(storage[pushPanelName].pushMaxRuneId), target)
            delay(aditionalDelay)
          end
          g_game.move(target, targetTile:getPosition())
          delay(tonumber(storage[pushPanelName].pushDelay))
        end
      end
      if flagMW and target then
        if tile and #tile:getCreatures() == 0 and tile:isWalkable() and not (tile:getTopThing():getId() == 2129 or tile:getTopThing():getId() == 2130) then
          delay(500)
          useWith(3180, tile:getTopUseThing())
        end
      end
    else
      if targetOldPos then
        local tile = g_map.getTile(targetOldPos)
        if tile then
          tile:setText("")
          targetTile:setText("")
        end
      end
      target = nil
      targetTile = nil
    end
  end
end)

local resetTimer = now
local doubleClickTimer = now
onKeyDown(function(keys)
  if not target or not storage[pushPanelName].enabled then return end
  if keys == storage[pushPanelName].pushMaxKey and resetTimer == 0 then
     local tile = getTileUnderCursor()
     if tile and not tile:getCreatures()[1] then
      if targetTile then
        local tilePos = tile:getPosition()
        local targetTilePos = targetTile:getPosition()
        if tilePos.x ~= targetTilePos.x or tilePos.y ~= targetTilePos.y or tilePos.z ~= targetTilePos.z then
          targetTile:setText("")
        end
      end
      targetTile = tile
      if not (targetTile:getTopThing():getId() == 2129 or targetTile:getTopThing():getId() == 2130 or targetTile:getTopThing():getId() == tonumber(storage[pushPanelName].mwallBlockId)) then
        tile:setTimer(math.max(100,tonumber(storage[pushPanelName].pushDelay)))
      end
      if (now - doubleClickTimer) <= 1000 then
        tile:setText("TARGET MWALL IN: ")
      else
        tile:setText("TARGET IN: ")
        doubleClickTimer = now
      end
     end
   end
   resetTimer = now
end)

onKeyPress(function(keys)
  if not target or not storage[pushPanelName].enabled then return end
  if keys == storage[pushPanelName].pushMaxKey and (resetTimer - now) < -10 then
    for _, tile in ipairs(g_map.getTiles(posz())) do
      if getDistanceBetween(pos(), tile:getPosition()) < 3 then
        if tile:getText():find("^TARGET ") ~= nil then
          tile:setText("")
        end
      end
    end
    target = nil
    targetTile = nil
    resetTimer = 0
  else
    resetTimer = 0
  end
end)

onCreaturePositionChange(function(creature, newPos, oldPos)
  if target and storage[pushPanelName].enabled then
    if creature:getName() == target:getName() then
      targetTile = nil
      for _, tile in ipairs(g_map.getTiles(posz())) do
        if getDistanceBetween(pos(), tile:getPosition()) < 3 then
          if tile:getText():find("^TARGET ") ~= nil then
            tile:setText("")
            target = nil
            targetTile = nil
          end
        end
      end
    end
  end
end)