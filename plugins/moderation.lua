----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

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
	if redis:get("gban:" .. msg.from.id) then
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
	if matches[1] == "del" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				delete_msg(msg.to.id, msg.reply_id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'banUser'), "md")
			end
		end
	elseif matches[1] == "ban" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				kick_user(msg.to.id, msg.replied.id)
				redis:set("ban:" .. msg.to.id .. ":" .. msg.replied.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'banUser'), "md")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	kick_user(msg.to.id, matches[2])
		    	redis:set("ban:" .. msg.to.id .. ":" .. matches[2], true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'banUser'), "md")
		    end
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2], msg.from.id)
	    	redisban_resolve(msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'banUser'), "md")
	    end
	elseif matches[1] == "unban" then
		if not matches[2] and msg.reply_id ~= 0 then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				redis:del("ban:" .. msg.to.id .. ":" .. msg.replied.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'unbanUser'), "md")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	redis:del("ban:" .. msg.to.id .. ":" .. matches[2])
				send_msg(msg.to.id, lang_text(msg.to.id, 'unbanUser'), "md")
		    end
	    elseif not is_number(matches[2]) then
	    	redisunban_resolve(msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'unbanUser'), "md")
	    end
	elseif matches[1] == "kick" then
		if not matches[2] and msg.reply_id ~= 0 then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				kick_user(msg.to.id, msg.replied.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'kickUser'), "md")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	kick_user(msg.to.id, matches[2])
				send_msg(msg.to.id, lang_text(msg.to.id, 'kickUser'), "md")
		    end
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2], msg.from.id)
			send_msg(msg.to.id, lang_text(msg.to.id, 'kickUser'), "md")
	    end
	elseif matches[1] == "gban" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				kick_user(msg.to.id, msg.replied.id)
				redis:set("gban:" .. msg.replied.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'gbanUser'), "md")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	kick_user(msg.to.id, matches[2])
		    	redis:set("gban:" .. matches[2], true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'gbanUser'), "md")
		    end
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2], msg.from.id)
	    	redisgban_resolve(msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'gbanUser'), "md")
	    end
	elseif matches[1] == "ungban" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				kick_user(msg.to.id, msg.replied.id)
				redis:del("gban:" .. msg.replied.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'ungbanUser'), "md")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	kick_user(msg.to.id, matches[2])
		    	redis:set("gban:" .. matches[2], true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'ungbanUser'), "md")
		    end
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2])
	    	redisgban_resolve(msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'ungbanUser'), "md")
	    end
	elseif matches[1] == "mute" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				redis:set("muted:" .. msg.to.id .. ":" .. msg.replied.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'muteUser'), "md")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	redis:set("muted:" .. msg.to.id .. ":" .. matches[2], true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'muteUser'), "md")
		    end
	    elseif not is_number(matches[2]) then
	    	redismute_resolve(msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'muteUser'), "md")
	    end
	elseif matches[1] == "unmute" then
		if not matches[2] and msg.reply_id then
			if compare_permissions(msg.to.id, msg.from.id, msg.replied.id) then
				redis:del("muted:" .. msg.to.id .. ":" .. msg.replied.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'unmuteUser'), "md")
			end
	    elseif is_number(matches[2]) then
	    	if compare_permissions(msg.to.id, msg.from.id, matches[2]) then
		    	redis:del("muted:" .. msg.to.id .. ":" .. matches[2])
				send_msg(msg.to.id, lang_text(msg.to.id, 'unmuteUser'), "md")
		    end
	    elseif not is_number(matches[2]) then
	    	redisunmute_resolve(msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'unmuteUser'), "md")
	    end
	end
end

return {
  	patterns = {
		"^[!/#](del)$",
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
