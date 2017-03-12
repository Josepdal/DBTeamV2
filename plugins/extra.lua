----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------
--extra.lua
--by @iicc1
-- missing translations

local function run(msg, matches)
	if matches[1] ==  "extra" then
		if permissions(msg.from.id, msg.to.id, "mod_commands") then
			if matches[2] then
				local extra = {}
				extra = { string.match(matches[2], "^[!/#](%S+) (.*)$") }
				addCommand(msg.to.id, extra)
			else
				local list = "*Extra list in this chat:*\n"
				for command, text in pairs (redis:hgetall("extra".. msg.to.id)) do
					list = list .. "[#/!]" .. command .. "\n"
				end
				send_msg(msg.to.id, list, 'md')
			end
		end
	elseif matches[1] == "extradel" and matches[2] then
		if permissions(msg.from.id, msg.to.id, "mod_commands") then
			local extra = ''
			extra = string.match(matches[2], "^[!/#](%S+)$")
			if extra then
				redis:hdel("extra" .. msg.to.id, extra)
				send_msg(msg.to.id, "The command: [!/#]`" .. extra .."` *has been removed.*", 'md')
			else
				send_msg(msg.to.id, "*Error:* the extra command does not exist in this chat.", 'md')
			end
		end
	elseif matches[1] then
		for command, text in pairs (redis:hgetall("extra".. msg.to.id)) do
			if matches[1] == command then
				send_msg(msg.to.id, redis:hget("extra".. msg.to.id, command), 'md')
			end
		end
	end
end

function addCommand(chat_id, command)
	local pattern = command[1]
	local text = command[2]
	if redis:hget("extra".. msg.to.id, pattern) then
		redis:hset("extra" .. msg.to.id, pattern, text)
	else
		redis:hset("extra" .. msg.to.id, pattern, text)
	end
	send_msg(msg.to.id, "*New command:* [#/!]" ..pattern.."\nThat sends:\n".. redis:hget("extra" .. msg.to.id, pattern) , 'md')
end

return {
        patterns = {
				"^[!/#](%S+) (.*)$",
				"^[!/#](.*)$"				
				},
    run = run
}
