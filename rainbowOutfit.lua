local outfit = {
    head = 0,
    body = 1,
    legs = 2,
    feet = 3,
    type = 143, -- outfit id
    auxType = 0,
    addons = 3, -- 1, 2, or 3 for all
    mount = 0, -- mount id
}

macro(100, "RainbowOutfit",  function()
    playerOutfit = player:getOutfit();
    outfit.head = (outfit.head + 1) % 133;
    outfit.body = (outfit.body + 1) % 133;
    outfit.legs = (outfit.legs + 1) % 133;
    outfit.feet = (outfit.feet + 1) % 133;
    outfit.type = playerOutfit.type;
    outfit.addons = playerOutfit.addons;
    setOutfit(outfit);
end)