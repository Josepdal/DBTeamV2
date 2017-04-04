----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function delete_messages(chat_id, messages_ids)
	tdcli_function ({
		ID = "DeleteMessages",
		chat_id_ = chat_id,
		message_ids_ = message_ids
	}, dl_cb, nil)
end

local function history_cb(chat_id, data)
	local message_ids = {}
	for i = 0, #data.messages_, 1 do
		delete_msg(msg.to.id, data.messages_[i].id_)
	end
end

local function pre_process(msg)

	-- Check if user is chat-banned
	if redis:get("ban:" .. msg.to.id .. ":" .. msg.from.id) then
		if redis:get("moderation_group: " .. msg.to.id) then
			kick_user(msg.to.id, msg.from.id)
		end
	end

	-- Check if user is global-banned
	if redis:sismember("gbans", msg.from.id) then
		if redis:get("moderation_group: " .. msg.to.id) then
			kick_user(msg.to.id, msg.from.id)
		end
	end

	--Check if user is muted
	if redis:get("muted:" .. msg.to.id .. ":" .. msg.from.id) then
		if redis:get("moderation_group: " .. msg.to.id) then
			delete_msg(msg.to.id, msg.id)
			if not redis:get("muted:alert:" .. msg.to.id .. ":" .. msg.from.id) then
				redis:setex("muted:alert:" .. msg.to.id .. ":" .. msg.from.id, 300, true)
				send_msg(msg.to.id, 'Trying to speak...', 'md')
			end
		end
	end
	--Check if chat is muted
	if redis:get("muteall:" .. msg.to.id) then
		if redis:get("moderation_group: " .. msg.to.id) then
			if not permissions(msg.from.id, msg.to.id, "moderation", "silent") then
				delete_msg(msg.to.id, msg.id)
			end
		end
	end
	
	return msg
end

local function run(msg, matches)
  if redis:get("moderation_group: " .. msg.to.id) then
	if matches[1] == "del" and not matches[2] then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				delete_msg(msg.to.id, msg.reply_id)
				delete_msg(msg.to.id, msg.id)
			end
		end
	elseif matches[1] == "ban" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'banUser'), "md")
				kick_user(msg.to.id, msg.replied.id)
				redis:set("ban:" .. msg.to.id .. ":" .. msg.replied.id, true)
			else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif is_number(matches[2]) and not msg.reply_id then
		   	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'banUser'), "md")
		    	kick_user(msg.to.id, matches[2])
		    	redis:set("ban:" .. msg.to.id .. ":" .. matches[2], true)
		    else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif not is_number(matches[2]) and matches[2] then
			resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "moderation", command = "ban"})
		elseif is_number(matches[2]) and msg.reply_id then
			send_msg(msg.to.id, "`>` The user has been *banned* for `" .. matches[2] .. "` secs." , "md")
		    kick_user(msg.to.id, msg.replied.id)
		    redis:setex("ban:" .. msg.to.id .. ":" .. msg.replied.id, matches[2], true)
		    removeFromBanList(msg.to.id, msg.replied.id)
		end
	elseif matches[1] == "unban" then
		if not matches[2] and msg.reply_id ~= 0 then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'unbanUser'), "md")
				redis:del("ban:" .. msg.to.id .. ":" .. msg.replied.id)
				removeFromBanList(msg.to.id, msg.replied.id)
			else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'unbanUser'), "md")
		    	redis:del("ban:" .. msg.to.id .. ":" .. matches[2])
		    	removeFromBanList(msg.to.id, matches[2])
			else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif not is_number(matches[2]) and matches[2] then
			resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "moderation", command = "unban"})
		end
	elseif matches[1] == "kick" then
		if not matches[2] and msg.reply_id ~= 0 then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'kickUser'), "md")
				kick_user(msg.to.id, msg.replied.id)
			else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	send_msg(msg.to.id, lang_text(msg.to.id, 'kickUser'), "md")
				kick_user(msg.to.id, matches[2])
		    else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif not is_number(matches[2]) and matches[2] then
	    	resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "moderation", command = "kick"})
	    end	    
	elseif matches[1] == "gban" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'gbanUser'), "md")
				kick_user(msg.to.id, msg.replied.id)
				redis:sadd("gbans", msg.replied.id)
			else
				permissions(msg.from.id, msg.to.id, "gban")
			end
	    elseif is_number(matches[2]) then
		   	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'gbanUser'), "md")
		    	kick_user(msg.to.id, matches[2])
		    	redis:sadd("gbans", msg.replied.id)
		    else
				permissions(msg.from.id, msg.to.id, "gban")
			end
	    elseif not is_number(matches[2]) and matches[2] then
			resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "moderation", command = "gban"})
		end
	elseif matches[1] == "ungban" then
		if not matches[2] and msg.reply_id ~= 0 then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'ungbanUser'), "md")
				redis:srem("gbans", msg.replied.id)
			else
				permissions(msg.from.id, msg.to.id, "gban")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'ungbanUser'), "md")
		    	redis:srem("gbans", matches[2])
			else
				permissions(msg.from.id, msg.to.id, "gban")
			end
	    elseif not is_number(matches[2]) and matches[2] then
			resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "moderation", command = "ungban"})
		end
	elseif matches[1] == "mute" then	
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'muteUser'), "md")
				redis:set("muted:" .. msg.to.id .. ":" .. msg.replied.id, true)	
			else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
		elseif is_number(matches[2]) and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'muteUserSec') .. matches[2] .. " *secs.*", "md")
				redis:setex("muted:" .. msg.to.id .. ":" .. msg.replied.id, matches[2], true)
			else
				permissions(msg.from.id, msg.to.id, "moderation")
			end			
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'muteUser'), "md")
		    	redis:set("muted:" .. msg.to.id .. ":" .. matches[2], true)
		    else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif not is_number(matches[2]) and matches[2] then
	    	resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "moderation", command = "mute"})
	    end	
	elseif matches[1] == "unmute" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'unmuteUser'), "md")
				redis:del("muted:" .. msg.to.id .. ":" .. msg.replied.id)
			else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
				send_msg(msg.to.id, lang_text(msg.to.id, 'unmuteUser'), "md")
		    	redis:del("muted:" .. msg.to.id .. ":" .. matches[2])
		    else
				permissions(msg.from.id, msg.to.id, "moderation")
			end
	    elseif not is_number(matches[2]) and matches[2] then
	    	resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "moderation", command = "unmute"})
	    end
	elseif matches[1] == "muteall" then
		if is_number(matches[2]) then
			if permissions(msg.from.id, msg.to.id, "moderation") then
				send_msg(msg.to.id, lang_text(msg.to.id, 'muteChatSec') .. matches[2] .. " *secs.*", "md")
				redis:setex("muteall:" .. msg.to.id, matches[2], true)
			end
		else
			if permissions(msg.from.id, msg.to.id, "moderation") then
				send_msg(msg.to.id, lang_text(msg.to.id, 'muteChat'), "md")
				redis:set("muteall:" .. msg.to.id, true)
			end
		end
	elseif matches[1] == "unmuteall" then
		if permissions(msg.from.id, msg.to.id, "moderation") then
			send_msg(msg.to.id, lang_text(msg.to.id, 'unmuteChat'), "md")
			redis:del("muteall:" .. msg.to.id)
		end
	elseif matches[1] == "delall" and not msg.reply_id then
		if permissions(msg.from.id, msg.to.id, "rem_history") then
			for k,v in pairs(redis:smembers('chat:' .. msg.to.id .. ':members')) do
				delete_msg_user(msg.to.id, v)
			end
			send_msg(msg.to.id, lang_text(msg.to.id, 'delAll'), 'md')
		end
	elseif matches[1] == "delall" and msg.reply_id then
		if permissions(msg.from.id, msg.to.id, "rem_history") then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				delete_msg_user(msg.to.id, msg.replied.id)
				delete_msg(msg.to.id, msg.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'delAll'), 'md')
			end
		end
	elseif matches[1] == "del" and matches[2] and msg.reply_id then
		if permissions(msg.from.id, msg.to.id, "rem_history") then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				chat_history(msg.to.id, msg.reply_id, 0, tonumber(matches[2]), history_cb, msg.to.id)
				delete_msg(msg.to.id, msg.reply_id)
				delete_msg(msg.to.id, msg.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'delXMsg'):gsub("$user", msg.from.first_name):gsub("$num", matches[2]), 'md')
			end
		end
	end
  else
	print("\27[32m> Not moderating this group.\27[39m")
  end
end

return {
  	patterns = {
		"^[!/#](del)$",
		"^[!/#](del) (.*)$",
		"^[!/#](delall)$",
	    "^[!/#](ban) (.*)$",
	    "^[!/#](ban)$",
	    "^[!/#](gban) (.*)$",
	    "^[!/#](gban)$",
	    "^[!/#](ungban) (.*)$",
	    "^[!/#](ungban)$",
	    "^[!/#](unban) (.*)$",
	    "^[!/#](unban)$",
	    "^[!/#](kick) (.*)$",
	    "^[!/#](kick)$",
	    "^[!/#](mute)$",
		"^[!/#](mute) (.*)$",
	    "^[!/#](unmute)$",
		"^[!/#](unmute) (.*)$",
		"^[!/#](muteall)$",
		"^[!/#](unmuteall)$",
		"^[!/#](muteall) (.*)$"
  	},
  	run = run,
  	pre_process = pre_process
}
