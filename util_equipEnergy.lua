--[[
  1. Start the script with your normal ring on 
  2. make sure the backpack with e-rings
     are always open
]]
local energy_ring = 3051; -- Your energy ring
local energy_ring_equiped = 3088; -- Ring changes id when equiped
local original_ring = getFinger(); -- Your original ring
local healthp_for_energy = 60;
local healthp_for_original = 90;
local manap_for_original = 10;

macro(20, "Auto E-ring", function()
    
    local manaPercent = math.floor(100 * (player:getMana() / player:getMaxMana()))
    if (manaPercent <= manap_for_original or player:getHealthPercent() >= healthp_for_original) and getFinger() and getFinger():getId() == energy_ring_equiped then
        if original_ring then
            local ring = findItem(original_ring:getId())
            g_game.move(ring, {x=65535, y=9, z=0}, 1)
        else
            g_game.move(getFinger(), {x=65535, y=3, z=0}, 1)
        end
        delay(200)
    elseif (player:getHealthPercent() <= healthp_for_energy and manaPercent >= manap_for_original and (not getFinger() or getFinger():getId() ~= energy_ring_equiped)) then
        local ring = findItem(energy_ring);
        if (ring) then
            original_ring = getFinger();
            g_game.move(ring, {x=65535, y=9, z=0}, 1)
            delay(200)
        end
    end
end)