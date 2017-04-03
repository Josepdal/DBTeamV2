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
	if matches[1] ==  "extra" and not msg.reply_id then	
		if matches[2] then
			if permissions(msg.from.id, msg.to.id, "mod_commands") then
				local extra = {}
				extra = { string.match(matches[2], "^[!/#](%S+) (.*)$") }
				addCommand(msg.to.id, extra)
			end
		else
			local list = "<b>Extra list in this chat:</b>\n"
			for command, text in pairs (redis:hgetall("extra".. msg.to.id)) do
				list = list .. "[#/!]" .. command .. "\n"
			end
			send_msg(msg.to.id, list, 'html')
		end
	elseif matches[1] ==  "extra" and  msg.reply_id then
		if permissions(msg.from.id, msg.to.id, "mod_commands") then
			get_msg_info(msg.to.id, msg.reply_id, infofile, matches[2])			
		end
	elseif matches[1] == "extradel" and matches[2] then
		if permissions(msg.from.id, msg.to.id, "mod_commands") then
			local extra = ''
			extra = string.match(matches[2], "^[!/#](%S+)$")
			if extra then
				redis:hdel("extra" .. msg.to.id, extra)
				send_msg(msg.to.id, "The command: [!/#]" .. extra .." <b>has been removed.</b>", 'html')
			else
				send_msg(msg.to.id, "<b>Error:</b> the extra command does not exist in this chat.", 'html')
			end
		end
	elseif matches[1] then
		for command, text in pairs (redis:hgetall("extra".. msg.to.id)) do
			if matches[1] == command then
				local data = redis:hget("extra".. msg.to.id, command)
				if string.find(data, "%$") then
					local extra = {}
					if string.find(data, "nil") then
						extra = {string.match(data, "^[%$](%S+) (%S+)")}
					else
						extra = {string.match(data, "^[%$](%S+) (%S+) (.*)")}
					end
					if extra[1] == "sticker" then
						sendSticker(msg.to.id, extra[2])
					elseif extra[1] == "photo" then
						sendPhoto(msg.to.id, extra[2], extra[3])	
					elseif extra[1] == "audio" then
						sendAudio(msg.to.id, extra[2], extra[3])
					elseif extra[1] == "voice" then
						sendVoice(msg.to.id, extra[2], extra[3])
					elseif extra[1] == "gif" then
						sendAnimation(msg.to.id, extra[2], extra[3])
					elseif extra[1] == "video" then
						sendVideo(msg.to.id, extra[2], extra[3])
					elseif extra[1] == "document" then
						sendDocument(msg.to.id, extra[2], extra[3])
					end
				else
					send_msg(msg.to.id, data, 'html')
				end
			end
		end
	end
end

function infofile(matches,msginfo)
	local data = {}
	data.message_ = msginfo
	msg = oldtg(data)
	if msg.file_id then
		if msg.sticker then
			local extra = {}
			extra = { string.match(matches, "^[!/#](%S+) (.*)$") }
			if not extra[1] then
				extra = { string.match(matches, "^[!/#](%S+)$") }
			end
			local persistent = "$sticker " .. msg.file_id
			addCommand(msg.to.id, extra, true, persistent)
		elseif msg.photo then
			local extra = {}
			extra = { string.match(matches, "^[!/#](%S+) (.*)$") }
			if not extra[1] then
				extra = { string.match(matches, "^[!/#](%S+)$") }
			end
			local persistent = "$photo " .. msg.file_id
			addCommand(msg.to.id, extra, true, persistent)		
		elseif msg.audio then
			local extra = {}
			extra = { string.match(matches, "^[!/#](%S+) (.*)$") }
			if not extra[1] then
				extra = { string.match(matches, "^[!/#](%S+)$") }
			end
			local persistent = "$audio " .. msg.file_id
			addCommand(msg.to.id, extra, true, persistent)		
		elseif msg.voice then
			local extra = {}
			extra = { string.match(matches, "^[!/#](%S+) (.*)$") }
			if not extra[1] then
				extra = { string.match(matches, "^[!/#](%S+)$") }
			end
			local persistent = "$voice " .. msg.file_id
			addCommand(msg.to.id, extra, true, persistent)		
		elseif msg.gif then
			local extra = {}
			extra = { string.match(matches, "^[!/#](%S+) (.*)$") }
			if not extra[1] then
				extra = { string.match(matches, "^[!/#](%S+)$") }
			end
			local persistent = "$gif " .. msg.file_id
			addCommand(msg.to.id, extra, true, persistent)		
		elseif msg.video then
			local extra = {}
			extra = { string.match(matches, "^[!/#](%S+) (.*)$") }
			if not extra[1] then
				extra = { string.match(matches, "^[!/#](%S+)$") }
			end
			local persistent = "$video " .. msg.file_id
			addCommand(msg.to.id, extra, true, persistent)		
		elseif msg.document then
			local extra = {}
			extra = { string.match(matches, "^[!/#](%S+) (.*)$") }
			if not extra[1] then
				extra = { string.match(matches, "^[!/#](%S+)$") }
			end
			local persistent = "$document " .. msg.file_id
			addCommand(msg.to.id, extra, true, persistent)
		end
	end	
end

function addCommand(chat_id, command, file, persistent)
	local pattern = command[1]
	local text = ''
	if file == true then
		if command[2] then
			text = persistent .. " " .. command[2]
		else
			text = persistent .. " nil"
		end
	else
		text = command[2]
	end
	print(pattern)
	if redis:hget("extra".. msg.to.id, pattern) then
		redis:hset("extra" .. msg.to.id, pattern, text)
	else
		redis:hset("extra" .. msg.to.id, pattern, text)
	end
	send_msg(msg.to.id, "<b>New command:</b> [#/!]" ..pattern.."\nThat sends:\n".. redis:hget("extra" .. msg.to.id, pattern) , 'html')
end

return {
        patterns = {
				"^[!/#](%S+) (.*)$",
				"^[!/#](.*)$"				
				},
    run = run
}
