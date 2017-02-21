local function run(msg, matches)
	if matches[1] == "admin" then
		if permissions(msg.from.id, msg.to.id, "promote_admin") then
			if msg.reply_id then
				redis:sadd('admins', msg.replied.id)
				redis:srem('mods:'..msg.to.id, msg.replied.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'newAdmin') .. ": @" .. (msg.replied.username or msg.replied.first_name), "html")
			elseif matches[2] then
				resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "promote_admin", command = "admin"})
			end
		end
	elseif matches[1] == "mod" then
		if permissions(msg.from.id, msg.to.id, "promote_mod") then
			if msg.reply_id then
				redis:sadd('mods:'..msg.to.id, msg.replied.id)
				if new_is_sudo(msg.from.id) then
					redis:srem('admins', msg.replied.id)
				end
				send_msg(msg.to.id, lang_text(msg.to.id, 'newMod') .. ": @" .. (msg.replied.username or msg.replied.first_name), "html")
			elseif matches[2] then
				resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "promote_mod", command = "mod"})
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
				send_msg(msg.to.id, "<code>></code> @" .. (msg.replied.username or msg.replied.first_name) .. "" ..  lang_text(msg.to.id, 'nowUser'), "html")
			elseif matches[2] then
				resolve_username(matches[2], resolve_cb, {chat_id = msg.to.id, superior = msg.from.id, plugin_tag = "promote_user", command = "user"})
			end
		end
	elseif matches[1] == "admins" then
		if permissions(msg.from.id, msg.to.id, "promote_user") then
			local text = "<b>Admins:</b>\n"
			for k, v in pairs(redis:smembers("admins")) do
				text = text .. "<code>></code> " .. redis:hget('bot:ids', v) .. " <code>(" .. v .. ")</code>\n"
			end
			send_msg(msg.to.id, text, 'html')
		end
	elseif matches[1] == "mods" then
		if permissions(msg.from.id, msg.to.id, "promote_user") then
			local text = "<b>Mods:</b>\n"
			for k, v in pairs(redis:smembers("mods:" .. msg.to.id)) do
				text = text .. "<code>></code> " .. redis:hget('bot:ids', v) .. " <code>(" .. v .. ")</code>\n"
			end
			send_msg(msg.to.id, text, 'html')
		end
	end
end

return {
  patterns = {
  	"^[!/#](admin)$",
	"^[!/#](admin) (.*)$",
    "^[!/#](mod)$",
	"^[!/#](mod) (.*)$",
    "^[!/#](user)$",
	"^[!/#](user) (.*)$",
    "^[!/#](admins)$",
    "^[!/#](mods)$"

  },
  run = run
}