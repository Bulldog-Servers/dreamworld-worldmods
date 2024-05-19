--[[
GloopBlocks
Originally written by GloopMaster

Maintained by VanessaE.

--]]

gloopblocks = {}

local MP = minetest.get_modpath(minetest.get_current_modname())
local S = minetest.get_translator(minetest.get_current_modname())

dofile(MP.."/main.lua")
dofile(MP.."/crafts.lua")
dofile(MP.."/lava-handling.lua")

print(S("Gloopblocks Loaded!"))
