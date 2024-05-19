-- translation
local S = minetest.get_translator("minetest_email")

local sent_formspec = "size[10,10;]" .. mail.theme .. [[
	no_prepend[]
	bgcolor[#7d7071]
	style_type[image_button;border=false]
	style_type[button;border=false;bgimg=email_button.png]

	tabheader[0.3,1;boxtab;]] .. S("Inbox") .. "," .. S("Sent messages") .. [[;2;false;false]

	hypertext[0.5,8.2;9.7,1;warning;<global halign=center valign=middle><style color=#d7ded7>]] .. S("Mails are currently not encrypted. Beware of what you write if you don't trust the staff") .. [[]
	button[0,9.5;2,0.5;new;]] .. S("New Message") .. [[]
    button[3,9.5;2,0.5;reply;]] .. S("Reply") .. [[]
    button[6,9.5;2,0.5;delete;]] .. S("Delete") .. [[]
	image_button_exit[9.1,-0.2;1,1;email_x.png;quit;]

	tablecolumns[color;text;text;text]
	table[0,0.7;9.8,7.35;sent;#999,]] .. S("Date") .. "   ," .. S("To") .. "   ," .. S("Subject")


function mail.show_sent(name)
	local formspec = { sent_formspec }
	local entry = mail.get_storage_entry(name)
	local messages = entry.outbox

	mail.message_drafts[name] = nil

	if messages[1] then
		for _, message in ipairs(messages) do
			formspec[#formspec + 1] = ","
			formspec[#formspec + 1] = ","
            formspec[#formspec + 1] = minetest.formspec_escape(os.date("%Y-%m-%d %X", message.time))
			formspec[#formspec + 1] = ","
			formspec[#formspec + 1] = minetest.formspec_escape(message.to)
			formspec[#formspec + 1] = ","
			if message.subject ~= "" then
				if string.len(message.subject) > 30 then
					formspec[#formspec + 1] = minetest.formspec_escape(string.sub(message.subject, 1, 27))
					formspec[#formspec + 1] = "..."
				else
					formspec[#formspec + 1] = minetest.formspec_escape(message.subject)
				end
			else
				formspec[#formspec + 1] = S("(No subject)")
			end
		end
		if mail.selected_idxs.sent[name] then
			formspec[#formspec + 1] = ";"
			formspec[#formspec + 1] = tostring(mail.selected_idxs.sent[name] + 1)
		end
		formspec[#formspec + 1] = "]"
	else
		formspec[#formspec + 1] = "]label[2.25,4.5;" .. S("No mail") .. "]"
	end
	minetest.show_formspec(name, "minetest_email:sent", table.concat(formspec, ""))
end
