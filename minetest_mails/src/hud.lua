local huddata = {}

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local data = {}

	data.imageid = player:hud_add({
		hud_elem_type = "image",
		name = "MailIcon",
		position = { x = 1, y = 1},
		offset = minetest_email_settings.position_icon_HUD_mail,
		text = "",
		alignment = {x = -1, y = -1},
		scale = {x = 3, y = 3},
	})

	data.textid = player:hud_add({
		hud_elem_type = "text",
		name = "MailText",
		position = { x = 1, y = 1},
		offset = minetest_email_settings.position_text_HUD_mail,
		text = "",--inbox_to_read .. " Mail",
		alignment = {x = -1, y = -1},
		scale = {x = 3, y = 3},
		number = "0xFFFFFF"	,
	})


	huddata[name] = data
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	huddata[name] = nil
end)


function mail.hud_update(playername, messages)
	local data = huddata[playername]
	local player = minetest.get_player_by_name(playername)

	if not data or not player then
		return
	end

	local unreadcount = 0
	for _, message in ipairs(messages) do
		if not message.read then
			unreadcount = unreadcount + 1
		end
	end

	if unreadcount == 0 then
		player:hud_change(data.imageid, "text", "")
		player:hud_change(data.textid, "text", "")
	else
		player:hud_change(data.imageid, "text", "email_mail.png")
		player:hud_change(data.textid, "text", unreadcount .. " /mail")
	end

end
