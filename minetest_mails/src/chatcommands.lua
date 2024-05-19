local S = minetest.get_translator("minetest_email")

minetest.register_chatcommand("mail",{
	description = S("Open the mail interface"),
	func = function(name)
		mail.show_inbox(name)
	end
})

minetest.register_chatcommand("spawn_mailman", {
	description = S("Use this command to spawn the mailman at your coordinates."),
	privs = {mailman_admin = true},
	func = function(name)
		if minetest.check_player_privs(name, minetest_email_settings.permission_to_remove_mailman) then
			return mail.spawn_mailman(name)
		end
	end
})
