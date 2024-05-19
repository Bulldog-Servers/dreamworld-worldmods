local S = minetest.get_translator("minetest_email")

local FORMNAME = "minetest_email:message"

function mail.show_message(name, id)
	local message = mail.get_message(name, id)

	local formspec = [[
		size[6.2,9]
			
		no_prepend[]
		bgcolor[#7d7071]
		style_type[image_button;border=false]
		style_type[button;border=false;bgimg=email_button.png]

		box[0,1;6,1.9;#C6916E]

		image_button[5.3,-0.1;1,1;email_x.png;back;]

		label[0.2,1.1;]] .. S("From") .. [[: %s]
		label[0.2,1.7;]] .. S("To") .. [[: %s]
		label[0.2,2.3;]] .. S("Date") .. [[: %s]
		label[0.1,3.1;]] .. S("Subject") .. [[: %s]
		textarea[0.35,3.6;6,5.0;;;%s]

		button[0,8.25;2,1;reply;]] .. S("Reply") .. [[]
		button[4.15,8.25;2,1;delete;]] .. S("Delete") .. [[]
		]] .. mail.theme

	local from = minetest.formspec_escape(message.from) or ""
	local to = minetest.formspec_escape(message.to) or ""
	local date = type(message.time) == "number"
		and minetest.formspec_escape(os.date("%Y-%m-%d %X", message.time)) or ""
	local subject = minetest.formspec_escape(message.subject) or ""
	local body = minetest.formspec_escape(message.body) or ""
	formspec = string.format(formspec, from, to, date, subject, body)

	if not message.read then
		-- mark as read
		mail.mark_read(name, id)
	end

	minetest.show_formspec(name, FORMNAME, formspec)
end

function mail.reply(name, message)
	local replyfooter = "" .. "\n\n" .. S("--Original message follows--") .. "\n" ..message.body
	mail.show_compose(name, message.from, "Re: "..message.subject, replyfooter)
end

function mail.forward(name, message)
	local fwfooter = "" .. "\n\n" .. S("--Original message follows--") .. "\n" .. (message.body or "")
	mail.show_compose(name, "", "Fw: " .. (message.subject or ""), fwfooter)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= FORMNAME then
		return
	end

	local name = player:get_player_name()
	local entry = mail.get_storage_entry(name)

	local messagesInbox = entry.inbox
	local messagesSent = entry.outbox

	if fields.back then
		mail.show_mail_menu(name)
		return true	-- don't uselessly set messages

	elseif fields.reply then
		local message = ""
		if messagesInbox[mail.selected_idxs.inbox[name]] then
			message = messagesInbox[mail.selected_idxs.inbox[name]]
		elseif messagesSent[mail.selected_idxs.sent[name]] then
			message = messagesSent[mail.selected_idxs.sent[name]]
		end
		mail.reply(name, message)

	elseif fields.forward then
		local message = ""
		if messagesInbox[mail.selected_idxs.inbox[name]] then
			message = messagesInbox[mail.selected_idxs.inbox[name]]
		elseif messagesSent[mail.selected_idxs.sent[name]] then
			message = messagesSent[mail.selected_idxs.sent[name]]
		end
		mail.forward(name, message)

	elseif fields.delete then
		if messagesInbox[mail.selected_idxs.inbox[name]] then
			mail.delete_mail(name, messagesInbox[mail.selected_idxs.inbox[name]].id)
		elseif messagesSent[mail.selected_idxs.sent[name]] then
			mail.delete_mail(name, messagesSent[mail.selected_idxs.sent[name]].id)
		end
		mail.show_mail_menu(name)
	end

	return true
end)
