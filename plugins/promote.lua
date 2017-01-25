local function run(msg, matches)
	if matches[1] == "admin" then
		if permissions(msg.from.id, msg.to.id, "promote_admin") then
			if msg.reply_id then
				redis:sadd('admins', msg.replied.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'newAdmin') .. ": `@" .. (msg.replied.username or msg.replied.first_name) .. "`", "md")
			end
		end
	elseif matches[1] == "mod" then
		print(is_mod(msg.to.id, msg.from.id))
		if permissions(msg.from.id, msg.to.id, "promote_mod") then
			print(0)
			if msg.reply_id then
				print(1)
				redis:sadd('mods:'..msg.to.id, msg.replied.id)
				print(2)
				send_msg(msg.to.id, lang_text(msg.to.id, 'newMod') .. ": `@" .. (msg.replied.username or msg.replied.first_name) .. "`", "md")
				print(3)
			end
		end
	elseif matches[1] == "user" then
		if permissions(msg.from.id, msg.to.id, "promote_user") then
			if msg.reply_id then
				if new_is_sudo(msg.from.id) then
					redis:srem('mods:'..msg.to.id, msg.replied.id)
					redis:srem('admins', msg.replied.id)
				elseif is_admin(msg.to.id) then
					redis:srem('mods:'..msg.to.id, msg.replied.id)
				end
				send_msg(msg.to.id, "'>' `@" .. (msg.replied.username or msg.replied.first_name) .. "`" ..  lang_text(msg.to.id, 'nowUser'), "md")
			end
		end
	elseif matches[1] == "admins" then
		if permissions(msg.from.id, msg.to.id, "promote_user") then
			local text = "*Admins:*\n"
			for k, v in pairs(redis:smembers("admins")) do
				text = text .. "`>` `" .. redis:hget('bot:ids', v) .. "` (" .. v .. ")\n"
			end
			send_msg(msg.to.id, text, 'md')
		end
	elseif matches[1] == "mods" then
		if permissions(msg.from.id, msg.to.id, "promote_user") then
			local text = "*Mods:*\n"
			for k, v in pairs(redis:smembers("mods:" .. msg.to.id)) do

				text = text .. "`>` `" .. redis:hget('bot:ids', v) .. "` (" .. v .. ")\n"
			end
			send_msg(msg.to.id, text, 'md')
		end
	end
end

return {
  patterns = {
  	"^[!/#](admin)$",
    "^[!/#](mod)$",
    "^[!/#](user)$",
    "^[!/#](admins)$",
    "^[!/#](mods)$"
  },
  run = run
}