mail = {
	-- version
	version = 3,

	-- mod storage
	storage = minetest.get_mod_storage(),

	-- ui theme prepend
	theme = "",

	-- ui forms
	ui = {},

	-- per-user ephemeral data
	selected_idxs = {
		inbox = {},
		sent = {},
		drafts = {},
		contacts = {},
		maillists = {},
		to = {},
		cc = {},
		bcc = {},
		boxtab = {}
	},

	message_drafts = {}
}

if minetest.get_modpath("default") then
	mail.theme = default.gui_bg .. default.gui_bg_img
end


-- sub files
local MP = minetest.get_modpath(minetest.get_current_modname())
local SP = MP .. "/src"

dofile(MP .. "/SETTINGS.lua")

dofile(SP .. "/api.lua")
dofile(SP .. "/chatcommands.lua")
dofile(SP .. "/gui.lua")
dofile(SP .. "/hud.lua")
dofile(SP .. "/onjoin.lua")
dofile(SP .. "/postman.lua")
dofile(SP .. "/privs.lua")
dofile(SP .. "/storage.lua")
-- ui
dofile(SP .. "/ui/compose.lua")
dofile(SP .. "/ui/contacts.lua")
dofile(SP .. "/ui/drafts.lua")
dofile(SP .. "/ui/edit_contact.lua")
dofile(SP .. "/ui/edit_maillists.lua")
dofile(SP .. "/ui/events.lua")
dofile(SP .. "/ui/inbox.lua")
dofile(SP .. "/ui/mail.lua")
dofile(SP .. "/ui/maillists.lua")
dofile(SP .. "/ui/message.lua")
dofile(SP .. "/ui/outbox.lua")
dofile(SP .. "/ui/select_contact.lua")
-- util
dofile(SP .. "/util/normalize.lua")
dofile(SP .. "/util/uuid.lua")

