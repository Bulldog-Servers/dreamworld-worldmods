

minetest.register_node("traffic_light:trafic_light", {
	description = "Trafic Light",
	tiles = {
		"tlight_tb.png",
		"tlight_tb.png",
		{name="tlight_1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=10}},
		{name="tlight_1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=10}},
		{name="tlight_2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=10}},
		{name="tlight_2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=10}},
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {cracky = 1},
	light_source = 8,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
			{-0.25, -0.4375, 0.125, -0.125, 0.4375, 0.25}, 
			{-0.25, -0.4375, -0.25, -0.125, 0.4375, -0.125},
			{0.125, -0.4375, 0.125, 0.25, 0.4375, 0.25}, 
			{0.125, -0.4375, -0.25, 0.25, 0.4375, -0.125}, 
			{-0.3125, 0.4375, -0.3125, 0.3125, 0.5, 0.3125}, 
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25}, 
			{-0.25, 0.125, -0.25, 0.25, 0.1875, 0.25}, 
			{-0.25, -0.1875, -0.25, 0.25, -0.125, 0.25}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "traffic_light:trafic_light 1",
		recipe = {
			{'default:obsidian','wool:red','default:obsidian'},
			{'default:torch','wool:yellow','default:torch'},
			{'default:obsidian','wool:green','default:obsidian'}
			}
})


