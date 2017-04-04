----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

function send_ID_by_reply(channel_id, message_id)
    get_msg_info(channel_id, message_id, getID_by_reply_cb, false)
end

function getID_by_reply_cb(arg, msg)
    send_msg(msg.chat_id_, lang_text(msg.to.id, 'userID') .. " " .. msg.sender_user_id_ .. "\n".. lang_text(msg.to.id, 'ChatID') .. " " .. msg.chat_id_, "md")
end



local function run(msg, matches)
    if not msg.reply_id then
    	send_msg(msg.to.id, lang_text(msg.to.id, 'userID') .. " " .. msg.from.id .. "\n" .. lang_text(msg.to.id, 'ChatID') .. " " .. msg.to.id, "md")
    else
    	send_ID_by_reply(msg.to.id, msg.reply_id)
    end
end

return {
  patterns = {
   '^[!/#]([Ii][Dd])$',
   '^[!/#](شناسه)$'--[[,
   '^[!/#](add command with your language)$']]--
  },
  run = run
}
