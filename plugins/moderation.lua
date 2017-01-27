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
	--redis:del("ban:" .. msg.to.id .. ":" .. msg.from.id)

	if permissions(msg.from.id, msg.to.id, "moderation") then
		return msg
	end

	-- Check if user is chat-banned
	if redis:get("ban:" .. msg.to.id .. ":" .. msg.from.id) then
		kick_user(msg.to.id, msg.from.id)
	end

	-- Check if user is global-banned
	if redis:sismember("gbans", msg.from.id) then
		kick_user(msg.to.id, msg.from.id)
	end

	--Check if user is muted
	if redis:get("muted:" .. msg.to.id .. ":" .. msg.from.id) then
		delete_msg(msg.to.id, msg.id)
		if not redis:get("muted:alert:" .. msg.to.id .. ":" .. msg.from.id) then
			redis:setex("muted:alert:" .. msg.to.id .. ":" .. msg.from.id, 300, true)
			send_msg(msg.to.id, 'trying to speak', 'md')
		end
	end

	return msg
end

local function run(msg, matches)
	if matches[1] == "del" and not matches[2] then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				delete_msg(msg.to.id, msg.reply_id)
			end
		end
	elseif matches[1] == "ban" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				kick_user(msg.to.id, msg.replied.id)
				redis:set("ban:" .. msg.to.id .. ":" .. msg.replied.id, true)
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	kick_user(msg.to.id, matches[2])
		    	redis:set("ban:" .. msg.to.id .. ":" .. matches[2], true)
		    end
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2], msg.from.id)
	    	redisban_resolve(msg.to.id, matches[2])
	    end
	    send_msg(msg.to.id, lang_text(msg.to.id, 'banUser'), "md")
	elseif matches[1] == "unban" then
		if not matches[2] and msg.reply_id ~= 0 then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				redis:del("ban:" .. msg.to.id .. ":" .. msg.replied.id)
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	redis:del("ban:" .. msg.to.id .. ":" .. matches[2])
		    end
	    elseif not is_number(matches[2]) then
	    	redisunban_resolve(msg.to.id, matches[2])
	    end
	    send_msg(msg.to.id, lang_text(msg.to.id, 'unbanUser'), "md")
	elseif matches[1] == "kick" then
		if not matches[2] and msg.reply_id ~= 0 then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				kick_user(msg.to.id, msg.replied.id)
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	kick_user(msg.to.id, matches[2])
		    end
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2], msg.from.id)
	    end
	    send_msg(msg.to.id, lang_text(msg.to.id, 'kickUser'), "md")
	elseif matches[1] == "gban" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				kick_user(msg.to.id, msg.replied.id)
				redis:sadd("gbans", msg.replied.id)
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	kick_user(msg.to.id, matches[2])
		    	redis:sadd("gbans", matches[2])
		    end
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2], msg.from.id)
	    	redisgban_resolve(msg.to.id, matches[2])
	    end
	    send_msg(msg.to.id, lang_text(msg.to.id, 'gbanUser'), "md")
	elseif matches[1] == "ungban" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				kick_user(msg.to.id, msg.replied.id)
				redis:srem("gbans", msg.replied.id)
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	kick_user(msg.to.id, matches[2])
		    	redis:srem("gbans", matches[2])
		    end
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2])
	    	redisungban_resolve(msg.to.id, matches[2])
	    end
	    send_msg(msg.to.id, lang_text(msg.to.id, 'ungbanUser'), "md")
	elseif matches[1] == "mute" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				redis:set("muted:" .. msg.to.id .. ":" .. msg.replied.id, true)	
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	redis:set("muted:" .. msg.to.id .. ":" .. matches[2], true)
		    end
	    elseif not is_number(matches[2]) then
	    	redismute_resolve(msg.to.id, matches[2])
	    end
	    send_msg(msg.to.id, lang_text(msg.to.id, 'muteUser'), "md")
	elseif matches[1] == "unmute" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				redis:del("muted:" .. msg.to.id .. ":" .. msg.replied.id)
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	redis:del("muted:" .. msg.to.id .. ":" .. matches[2])
		    end
	    elseif not is_number(matches[2]) then
	    	redisunmute_resolve(msg.to.id, matches[2])
	    end
	    send_msg(msg.to.id, lang_text(msg.to.id, 'unmuteUser'), "md")
	elseif matches[1] == "delall" and not msg.reply_id then
		if permissions(msg.from.id, msg.to.id, "rem_history") then
			for k,v in pairs(redis:smembers('chat:' .. msg.to.id .. ':members')) do
				delete_msg_user(msg.to.id, v)
			end
			send_msg(msg.to.id, lang_text(msg.to.id, 'delAll'), 'md')
		end
	elseif matches[1] == "delall" and msg.reply_id then
		if permissions(msg.from.id, msg.to.id, "rem_history") then
			delete_msg_user(msg.to.id, msg.replied.id)
			delete_msg(msg.to.id, msg.id)
			send_msg(msg.to.id, lang_text(msg.to.id, 'delAll'), 'md')
		end
	elseif matches[1] == "del" and matches[2] and msg.reply_id then
		chat_history(msg.to.id, msg.reply_id, 0, tonumber(matches[2]), history_cb, msg.to.id)
		delete_msg(msg.to.id, msg.reply_id)
		delete_msg(msg.to.id, msg.id)
		send_msg(msg.to.id, lang_text(msg.to.id, 'delXMsg'):gsub("$user", msg.from.first_name):gsub("$num", matches[2]), 'md')
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
	    "^[!/#](unmute)$"
  	},
  	run = run,
  	pre_process = pre_process
}
