globals = {
	"invsaw"
}

max_line_length = 180

read_globals = {
	-- Stdlib
	string = {fields = {"split", "trim"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"minetest",
	"vector", "ItemStack",
	"dump", "dump2",
	"AreaStore",
	"VoxelArea",

	-- deps
	"unified_inventory",
	"circular_saw"
}
