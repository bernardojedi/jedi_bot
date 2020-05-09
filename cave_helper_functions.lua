--Supply Checker
function getSupplyAmount(itemId)
    local totalItem = 0
    for _, container in pairs(getContainers()) do
        for _, item in ipairs(container:getItems()) do
      --Item1
            if item:getId() == itemId then
          totalItem = totalItem + item:getCount()
            end
        end
    end
    return totalItem
end

--Check Supply
function supplyChecker(itemId, amount, func, label)
  local currentAmount = getSupplyAmount(itemId)
  if currentAmount < amount then
    func(label)
    return true
  else
    return true
  end
end

--Buy item from NPC
function buyFromNPC(name, itemId, neededAmount)
  local npc = getCreatureByName(name)
  local currentAmount = getSupplyAmount(itemId)
  local buyAmount = neededAmount - currentAmount
  if buyAmount <= 0 then
    return true
  end
  if not npc then 
    return false
  end
  local pos = player:getPosition()
  local npcPos = npc:getPosition()
  if math.max(math.abs(pos.x - npcPos.x), math.abs(pos.y - npcPos.y)) > 3 then
    autoWalk(npcPos, {precision=3})
    delay(1000)
    return "retry"
  end
  if not NPC.isTrading() then
    NPC.say("hi")
    NPC.say("trade")
    delay(500)
    return "retry"
  end
  
  while buyAmount > 100 do
    NPC.buy(itemId, 100)
    delay(1000)
    buyAmount = buyAmount - 100
  end
  NPC.buy(itemId, buyAmount)

  return true
end

--Sell to NPC
function sellToNPC(name, itemId)
  local npc = getCreatureByName(name)
  local currentAmount = getSupplyAmount(itemId)
  if currentAmount <= 0 then
    return true
  end
  if not npc then 
    return false
  end
  local pos = player:getPosition()
  local npcPos = npc:getPosition()
  if math.max(math.abs(pos.x - npcPos.x), math.abs(pos.y - npcPos.y)) > 3 then
    autoWalk(npcPos, {precision=3})
    delay(1000)
    return "retry"
  end
  if not NPC.isTrading() then
    NPC.say("hi")
    NPC.say("trade")
    delay(500)
    return "retry"
  end
  while currentAmount > 100 do
    NPC.sell(itemId, 100)
    delay(1000)
    currentAmount = currentAmount - 100
  end
  NPC.sell(itemId, currentAmount)

  return true
end
