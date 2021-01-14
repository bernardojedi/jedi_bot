local screenshotFolder = "/screenshots"
local screenshotDir = screenshotFolder

local takingScreenshots = false
local counter = 0
local randomNumber = 0
local creatureName = ''

macro(30, "Death Cam", function()
  if takingScreenshots and counter < 3 then
    local screenshotName = creatureName.."_"..randomNumber.."_"..counter..".png"
    doScreenshot(screenshotDir.."/"..screenshotName)
    counter = counter + 1
  end
end)

onCreatureHealthPercentChange(function(creature, healthPercent)
  if (not takingScreenshots or counter >= 3) and creature and creature:isPlayer() and healthPercent == 0 then
    takingScreenshots = true
    counter = 0
    randomNumber = math.random(99999)
    creatureName = creature:getName()
  end
end)