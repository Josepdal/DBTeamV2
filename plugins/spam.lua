----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------
--- Remember to activate this plugin in data/config.lua
--- Change here if you want the bot to say in the chat when somebody spams (true, false) and if you want the user to be kicked(true,false):
local notification_on_chat = true
local kick_user_spam = false

local function run(msg, matches)
    if not permissions(msg.from.id, msg.to.id, "spam", "silent") then
		if notification_on_chat then
		end
		if kick_user_spam then
			kick_user(msg.to.id, msg.from.id)
		end
        delete_msg(msg.to.id, msg.id)
        send_report(msg,matches[1])
    end
end

function send_report(msg,reason)
    for v,user in pairs(_config.sudo_users) do
        send_msg(user, text, 'md')
    end
end


return {
patterns = {
    -- You can add much as patterns you want to stop all spam traffic
	"[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Mm][Ee]",
	"[Tt]%.[Mm][Ee]",
	"[Aa][Dd][Ff]%.[Ll][Yy]",
	"[Bb][Ii][Tt]%.[Ll][Yy]"
}, run = run}
