local S = minetest.get_translator("minetest_email")

local postman_model = "character.b3d"
if minetest.get_modpath("mcl_armor") and minetest.global_exists("mcl_skins") and mcl_skins.register_simple_skin then
	postman_model = "mcl_armor_character.b3d"
end

local postman = {
    initial_properties = {
        hp_max = 100,
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
		visual      = "mesh",
		mesh        = postman_model,
		visual_size = {x=1, y=1},
        textures = {"mailman.png"},
        spritediv = {x = 1, y = 1},
        nametag = S("Mailman"),
        initial_sprite_basepos = {x = 0, y = 0},
    },

    message = " ",
}

-- commented the if to show or not the nametag
--if minetest_email_settings.show_nametag_mailman then
--	 postman.nametag = S("Mailman")
--end

minetest.register_entity("minetest_email:mailman", postman)
local pos = { x = 1, y = 10, z = 30 }
local obj = minetest.add_entity(pos, "minetest_email:mailman", nil)

function postman:set_message(msg)
    self.message = msg
end

function postman:on_rightclick (hitter)
	mail.show_inbox(hitter:get_player_name())
end

function postman:on_punch (hitter)
	if hitter and hitter:is_player() then
		minetest.chat_send_player(hitter:get_player_name(), S("Hello! Right click me with your mouse to read and write mail!"))
		if (hitter:get_player_control().sneak == true or hitter:get_player_control().aux1 == true) and minetest.check_player_privs(hitter, minetest_email_settings.permission_to_remove_mailman) then
			self.object:set_yaw(self.object:get_yaw() +3.14159/4)
		end
        if not minetest.check_player_privs(hitter, minetest_email_settings.permission_to_remove_mailman) then
			return 0
        end
    end
end

function mail.spawn_mailman(name)
	local pname = minetest.get_player_by_name(name)
	local pos = pname:get_pos()
	local mailman_pos = { x = pos.x, y = pos.y, z = pos.z }
	local spawn_mailman_entity = minetest.add_entity(mailman_pos, "minetest_email:mailman", nil)
	return true
end
