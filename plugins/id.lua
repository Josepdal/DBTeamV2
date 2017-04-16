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
    send_msg(msg.chat_id_, lang_text(msg.to.id, 'userID') .. " " .. msg.sender_user_id_ .. "\n" .. lang_text(msg.to.id, 'chatID') .. " " .. msg.chat_id_, "md")
end

local function run(msg, matches)
  if not msg.reply_id then
    if not matches[2] then
      send_msg(msg.to.id, lang_text(msg.to.id, 'userID') .. " " .. msg.from.id ..  "\n" .. lang_text(msg.to.id, 'chatID') .. " " .. msg.to.id, "md")
    else
      if is_number(matches[2]) then
        resolve_id(matches[2], getIdUsername, msg.to.id)
      else
        resolve_username(matches[2], getUsernameId, msg.to.id)
      end
    end
  else
    send_ID_by_reply(msg.to.id, msg.reply_id)
  end
end

function getIdUsername(chat, data)
  if data.ID == "Error" then
    send_msg(chat, "*Error:* `" .. data.message_ .. "`", "md")
  else
    send_msg(chat, "*Alias:* @" .. data.user_.username_ , "md")
  end
end

function getUsernameId(chat, data)
  if data.ID == "Error" then
    send_msg(chat, "*Error:* `" .. data.message_ .. "`", "md")
  else
    send_msg(chat, "*ID:* `" .. data.id_ .. "`", "md")
  end
end

return {
  patterns = {
   '^[!/#]([Ii][Dd])$',
   '^[!/#]([Ii][Dd]) (.*)$' 
  },
  run = run
}
