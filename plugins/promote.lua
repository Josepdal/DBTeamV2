local function run(msg, matches)
	if matches[1] == "admin" then
		if permissions(msg.from.id, msg.to.id, "promote_admin") then
			if msg.reply_id then
				redis:set('admin:' .. msg.replied.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'newAdmin') .. ": @" .. msg.replied.username, "md")
			end
		end
	elseif matches[1] == "mod" then
		if permissions(msg.from.id, msg.to.id, "promote_mod") then
			if msg.reply_id then
				redis:set('mod:'..msg.to.id..':'..msg.replied.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'newMod') .. ": @" .. msg.replied.username, "md")
			end
		end
	elseif matches[1] == "user" then
		if permissions(msg.from.id, msg.to.id, "promote_user") then
			if msg.reply_id then
				if new_is_sudo(msg.from.id) then
					redis:del('mod:' .. msg.to.id .. ':' .. msg.replied.id)
					redis:del('admin:' .. msg.replied.id)
				elseif is_admin(msg.to.id) then
					redis:del('mod:' .. msg.to.id .. ':' .. msg.replied.id)
				end
				send_msg(msg.to.id, lang_text(msg.to.id, '>') .. " @" .. msg.replied.username .. lang_text(msg.to.id, 'nowUser'), "md")
			end
		end
	end
end

return {
  patterns = {
  	"^[!/#](admin)$",
    "^[!/#](mod)$",
    "^[!/#](user)$"
  },
  run = run
}