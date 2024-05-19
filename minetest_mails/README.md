# Minetest Mails
Send messages as e-mails between players!

This mod can be used with a NPC (entity) that is the MailMan who will send your message to the players.
Also can be used by commands.

### Commands
here the list of commands:

`/mailbox`: Open the Inbox of the player
`/spawn_mailman`: Spawn the mailman entity at the exactly yours coords


This mod is a fork of this [mod](https://github.com/rubenwardy/email) made by [rubenwardy](https://github.com/rubenwardy)


### How to use it?
To use this mod, first of all you need to checkout the file `config.lua` where there are 3 configurations variable that you need to check and (maybe if you need) modify:

1) `position_icon_HUD_mail`: This is the coords of the icon of the mail alert, when a user receive an email. Change these coords if you want to change them
2) `position_text_HUD_mail`: This is the coords of the text of the mail alert said before. Change these coords if you want to change them
3) `permission_to_remove_mailman`: This is the permission that the player need to have if want to remove the mailman. If the user that punch the mail man (left button mouse) has this permission can decrease the HP of the mailman and so remove the entity. If the user doesn't have this permission the mailman HP won't decrease.
4) `show_nametag_mailman`: This configuration will allow you to show or hide the mailman nametag (default is: true)

Another thing, if the player has this permission could change the angle of the entity, just keep press the `sneak button` (usually left shift) and punch the mail main with the left button of mouse, and the mailman will rotate.

After these config, you only need to spawn the "mailman" entity inside your world with this command in the chat:
`/spawn_mailman`, this command will spawn your Postman at the exactly coords where you are when you type that command.

After that, you need simply right-click on this entity and will open your Inbox and then you are ready to write and read your mails:)

Are you far away from the postman and you need to open your inbox? Don't worry, simply type in the chat the command `/mailbox` and your inbox will be opened!

### Want to help?
Feel free to:
* open an [issue](https://gitlab.com/mrfreeman_works/minetest_mails/-/issues)
* submit a merge request. In this case, PLEASE, do follow milestones and my [coding guidelines](https://cryptpad.fr/pad/#/2/pad/view/-l75iHl3x54py20u2Y5OSAX4iruQBdeQXcO7PGTtGew/embed/). I won't merge features for milestones that are different from the upcoming one (if it's declared), nor messy code