-- translation
local S = minetest.get_translator("minetest_email")

local FORMNAME = "minetest_email:compose"
local msg_id = {}

function mail.show_compose(name, to, subject, body, cc, bcc, id)
	local formspec = [[
			size[8,9]
            no_prepend[]
            bgcolor[#7d7071]
            style_type[image_button;border=false]
            style_type[button;border=false;bgimg=email_button.png]
			image_button[0,0.1;0.8,0.8;email_contacts.png;tocontacts;]
			field[1.26,0.3;3.2,1;to;;%s]
			field[0.25,1.9;8,1;subject;]] .. S("Subject") .. [[:;%s]
			textarea[0.25,2.5;8,6;body;;%s]
			button[5.4,8;2.5,1;cancel;]] .. S("Cancel") .. [[]
			button[0,8;2.5,1;send;]] .. S("Send") .. [[]
		]] .. mail.theme

	formspec = string.format(formspec,
		minetest.formspec_escape(to) or "",

        --  START [WIP 2023_08_22] At the moment, i have commented these 2 lines that contais 2 params (cc and bcc) that they are sent to the function mail.show_compose to put inside the formspec the cc and bcc.
        -- as you can see, at the moment you don't have in the formspec these 2 fields because it's a work in progress feature so i commented these params because are not used at the moment to close this issue:
        -- https://gitlab.com/zughy-friends-minetest/minetest_mails/-/issues/14
        -- in the future (i hope soon) maybe this feature will be insert in this mod, at the moment you can just put only the receiver of the mail only in the TO field :) Thanks <3


		-- minetest.formspec_escape(cc) or "",
		-- minetest.formspec_escape(bcc) or "",


        --  START [WIP 2023_08_22]
		minetest.formspec_escape(subject) or "",
		minetest.formspec_escape(body) or "")

    if id then
        msg_id[name] = id
    end

	minetest.show_formspec(name, FORMNAME, formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= FORMNAME then
		return
	end

	local name = player:get_player_name()
    if fields.send then
        local id = mail.new_uuid()
        if msg_id[name] then
            id = msg_id[name]
        end
        if (fields.to == "" and fields.cc == "" and fields.bcc == "") or fields.body == "" then
            -- if mail is invalid then store it as a draft
            mail.save_draft({
                id = id,
                from = name,
                to = fields.to,
                cc = fields.cc,
                bcc = fields.bcc,
                subject = fields.subject,
                body = fields.body
            })
            -- mail.show_mail_menu(name)
           
            return
        end
        local success, err = mail.send({
            id = id,
            from = name,
            to = fields.to,
            cc = fields.cc,
            bcc = fields.bcc,
            subject = fields.subject,
            body = fields.body,
            date = os.date("%Y-%m-%d %H:%M"),
        })
        if not success then
            minetest.chat_send_player(name, err)
            return
        end

        -- add new contacts if some receivers aren't registered
        local contacts = mail.get_contacts(name)
        local recipients = mail.parse_player_list(fields.to)
        local isNew = true
        for _,recipient in ipairs(recipients) do
            if recipient:sub(1,1) == "@" then -- in case of maillist -- check if first char is @
                isNew = false
            else
                for _,contact in ipairs(contacts) do
                    if contact.name == recipient then
                        isNew = false
                        break
                    end
                end
            end
            if isNew then
                mail.update_contact(name, {name = recipient, note = ""})
            end
        end

        minetest.after(0.5, function()
            -- mail.show_mail_menu(name)
            minetest.close_formspec(name, "minetest_email:compose", nil)
        end)

    elseif fields.tocontacts or fields.cccontacts or fields.bcccontacts then
        mail.message_drafts[name] = {
            to = fields.to,
            cc = fields.cc,
            bcc = fields.bcc,
            subject = fields.subject,
            body = fields.body,
            date = os.date("%Y-%m-%d %H:%M"),
        }
        mail.show_select_contact(name, fields.to, fields.cc, fields.bcc)

    elseif fields.cancel then
        mail.message_drafts[name] = nil

        mail.show_mail_menu(name)

    elseif fields.draft then
        local id = mail.new_uuid()
        if msg_id[name] then
            id = msg_id[name]
        end
        mail.save_draft({
            id = id,
            from = name,
            to = fields.to,
            cc = fields.cc,
            bcc = fields.bcc,
            subject = fields.subject,
            body = fields.body,
            date = os.date("%Y-%m-%d %H:%M")
        })

        mail.show_mail_menu(name)
    end

    return true
end)
