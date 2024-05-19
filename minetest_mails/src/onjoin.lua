local S = minetest.get_translator("minetest_email")

minetest.register_on_joinplayer(function(player)
	minetest.after(1, function(name)
		local entry = mail.get_storage_entry(name)
		local messages = entry.inbox
		mail.hud_update(name, messages)

		local unreadcount = 0

		for _, message in pairs(messages) do
			if not message.read then
				unreadcount = unreadcount + 1
			end
		end

		if unreadcount > 0 then
			minetest.chat_send_player(name,
				minetest.colorize("#00f529", S("(@1) You have mail! Type /mail to read", unreadcount)))
			minetest.sound_play('notification', {
				to_player = name,
				gain = 2.0,
			})


		end
	end, player:get_player_name())
end)
