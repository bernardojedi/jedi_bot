local warTab = "War"


setDefaultTab(warTab)
War = {} -- global namespace
--importStyle("/war/combo.otui")
--dofile("/war/#vlib.lua")
--dofile("/war/combo.lua")
--dofile("/war/magebomb.lua")
--dofile("/war/kill steal.lua")

dofile("/war/push_anti.lua")
dofile("/war/mwalls.lua")
importStyle("/war/pushmax.otui")
dofile("/war/pushmax.lua")
dofile("/war/push_auto.lua")
dofile("/war/push_collect.lua")
dofile("/war/push_max.lua")
dofile("/war/comboLeader.lua")
dofile("/war/pot_friend.lua")
dofile("/war/combo_sd.lua")
dofile("/war/combo_ue.lua")
--dofile("/war/antipush.lua")



