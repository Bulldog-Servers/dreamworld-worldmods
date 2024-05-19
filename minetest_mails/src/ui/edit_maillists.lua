-- translation
local S = minetest.get_translator("minetest_email")
local old_lists_names = {}

local FORMNAME = "minetest_email:editmaillist"

function mail.show_edit_maillist(playername, maillist_name, desc, players, illegal_name_hint)
	old_lists_names[playername] = maillist_name
	local formspec = [[
		size[6,7]
		no_prepend[]
		bgcolor[#7d7071]
		style_type[image_button;border=false]
		style_type[button;border=false;bgimg=email_button.png]
		button[4,6.25;2,0.5;back;]] .. S("Back") .. [[]
		field[0.25,0.5;4,1;name;]] .. S("Maillist name") .. [[:;%s]
		textarea[0.25,1.6;4,2;desc;]] .. S("Desc") .. [[:;%s]
		textarea[0.25,3.6;4,4.25;players;]] .. S("Players") .. [[:;%s]
		button[4,0.10;2,1;save;]] .. S("Save") .. [[]
		]]
	if illegal_name_hint == "collision" then
		formspec = formspec .. [[
				textarea[4.2,1.2;2,2;;;]] .. S("That name is already in your maillists.") .. [[]
			]]
	elseif illegal_name_hint == "empty" then
		formspec = formspec .. [[
				textarea[4.2,1.2;2,2;;;]] .. S("The maillist name cannot be empty.") .. [[]
			]]
	end
	formspec = formspec .. mail.theme
	formspec = string.format(formspec,
		minetest.formspec_escape(maillist_name or ""),
		minetest.formspec_escape(desc or ""),
		minetest.formspec_escape(players or ""))
	minetest.show_formspec(playername, FORMNAME, formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= FORMNAME then
		return
	end

	local name = player:get_player_name()
	if fields.save then
		mail.update_maillist(name, {
			owner = name,
			name = fields.name,
			desc = fields.desc,
			players = mail.parse_player_list(fields.players)
		}, old_lists_names[name])
		mail.show_maillists(name)

	elseif fields.back then
		mail.show_maillists(name)
	end

	return true
end)
