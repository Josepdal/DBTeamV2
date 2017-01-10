----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function pre_process(msg)
	--redis:del("ban:" .. msg.to.id .. ":" .. msg.from.id)
	-- Check if user is banned
	if redis:get("ban:" .. msg.to.id .. ":" .. msg.from.id) then
		kick_user(msg.to.id, msg.from.id)
	end

	return msg
end

local function run(msg, matches)
	print(0)
	if matches[1] == "ban" then
		print(1)
		if not matches[2] and msg.reply_id then
			print(2)
			kick_user(msg.to.id, msg.replied.id)
			redis:set("ban:" .. msg.to.id .. ":" .. msg.replied.id, true)
			reply_msg(msg.to.id, "Este usuario ha sido *baneado*!", msg.reply_id, "md")
			print(3)
	    elseif is_number(matches[2]) then
	    	kick_user(msg.to.id, matches[2])
	    	redis:set("ban:" .. msg.to.id .. ":" .. matches[2], true)
	    	send_msg(msg.to.id, "El usuario con ID `" .. matches[2] .. "` ha sido *baneado*!", "md")
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2])
	    	redisban_resolve(msg.to.id, matches[2])
	    	send_msg(msg.to.id, "El usuario con nombre de usuario `" .. matches[2] .. "` ha sido *baneado*!", "md")
	    end
	elseif matches[1] == "unban" then
		if not matches[2] and msg.reply_id ~= 0 then
			redisunban_by_reply(msg.to.id, msg.reply_id)
			reply_msg(msg.to.id, "Este usuario ha sido *desbaneado*!", msg.reply_id, "md")
	    elseif is_number(matches[2]) then
	    	redis:del("ban:" .. msg.to.id .. ":" .. matches[2])
	    	send_msg(msg.to.id, "El usuario con ID `" .. matches[2] .. "` ha sido *desbaneado*!", "md")
	    elseif not is_number(matches[2]) then
	    	redisunban_resolve(msg.to.id, matches[2])
	    	send_msg(msg.to.id, "El usuario con nombre de usuario `" .. matches[2] .. "` ha sido *desbaneado*!", "md")
	    end
	elseif matches[1] == "kick" then
		if not matches[2] and msg.reply_id ~= 0 then
			kick_by_reply(msg.to.id, msg.reply_id)
			reply_msg(msg.to.id, "Este usuario ha sido *expulsado*!", msg.reply_id, "md")
	    elseif is_number(matches[2]) then
	    	kick_user(msg.to.id, matches[2])
	    	send_msg(msg.to.id, "El usuario con ID `" .. matches[2] .. "` ha sido *expulsado*!", "md")
	    elseif not is_number(matches[2]) then
	    	kick_resolve(msg.to.id, matches[2])
	    	send_msg(msg.to.id, "El usuario con nombre de usuario `" .. matches[2] .. "` ha sido *expulsado*!", "md")
	    end
	end
end

return {
  	patterns = {
	    "^[!/#](ban) (.*)$",
	    "^[!/#](ban)$",
	    "^[!/#](unban) (.*)$",
	    "^[!/#](unban)$",
	    "^[!/#](kick) (.*)$",
	    "^[!/#](kick)$",
	    "^[!/#](add) (.*)$",
        "^[!/#](add)$"
  	},
  	run = run,
  	pre_process = pre_process
}