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

--Check Location
function locationChecker(posx, posy, posz, precision, func, label)
  local pos = player:getPosition()
  if math.abs(posx - pos.x) > precision or
      math.abs(posx - pos.x) > precision or
      posz ~= pos.z then
    func(label)
  end
  return true
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
    CaveBot.delay(1000)
    return "retry"
  end
  if not NPC.isTrading() then
    NPC.say("hi")
    NPC.say("trade")
    CaveBot.delay(500)
    return "retry"
  end
  
  while buyAmount > 100 do
    NPC.buy(itemId, 100)
    CaveBot.delay(1000)
    buyAmount = buyAmount - 100
  end
  NPC.buy(itemId, buyAmount)
  if (neededAmount - getSupplyAmount(itemId)) > 0 then
    return "retry"
  end

  return true
end

--Buy item from NPC
function buyFromNPCTalk(name, itemId, neededAmount, itemName)
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
    CaveBot.delay(1000)
    return "retry"
  end
  say("hi")
  CaveBot.delay(2000)
  while currentAmount > 100 do
    NPC.say("buy 100 "..itemName)
    CaveBot.delay(2000)
    NPC.say("yes")
    CaveBot.delay(2000)
    currentAmount = currentAmount - 100
  end
  say("buy "..currentAmount.." "..itemName)
  CaveBot.delay(2000)
  say("yes")
  if getSupplyAmount(itemId) > 0 then
    return "retry"
  end

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
    CaveBot.delay(1000)
    return "retry"
  end
  if not NPC.isTrading() then
    NPC.say("hi")
    NPC.say("trade")
    CaveBot.delay(500)
    return "retry"
  end
  while currentAmount > 100 do
    NPC.sell(itemId, 100)
    CaveBot.delay(1000)
    currentAmount = currentAmount - 100
  end
  NPC.sell(itemId, currentAmount)
  if getSupplyAmount(itemId) > 0 then
    return "retry"
  end

  return true
end

--Sell to NPC
function sellToNPCTalk(name, itemId, itemName)
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
    CaveBot.delay(1000)
    return "retry"
  end
  NPC.say("hi")
  CaveBot.delay(500)

  while currentAmount > 100 do
    NPC.say("sell 100 "..itemName)
    CaveBot.delay(500)
    NPC.say("yes")
    CaveBot.delay(500)
    currentAmount = currentAmount - 100
  end
  NPC.say("sell "..currentAmount.." "..itemName)
  CaveBot.delay(500)
  NPC.say("yes")
  if getSupplyAmount(itemId) > 0 then
    return "retry"
  end

  return true
end

--Travel to city
function travelTo(name, city)
  local npc = getCreatureByName(name)
  if not npc then 
    return false
  end
  local pos = player:getPosition()
  local npcPos = npc:getPosition()
  if math.max(math.abs(pos.x - npcPos.x), math.abs(pos.y - npcPos.y)) > 3 then
    autoWalk(npcPos, {precision=3})
    CaveBot.delay(1000)
    return "retry"
  end
  NPC.say("hi")
  NPC.say(city)
  NPC.say("yes")
  CaveBot.delay(1000)
  return true
end