----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------


local function run(msg, matches)
   if permissions(msg.from.id, msg.to.id, "gban") and redis:get("moderation_group: " .. msg.to.id) then
		if not matches[2] then
			local count =(redis:scard("gbans"))
			local text = lang_text(msg.to.id, 'gbans')..count.."<b>) :</b>\n"
			for k, v in pairs (redis:smembers("gbans")) do
				text = text .. "<code>></code> " .. v .. "\n"
			end
			send_msg(msg.to.id, text, "html")
			
		elseif matches[2] == "json" then
			local text = "[\n"
			for k, v in pairs (redis:smembers("gbans")) do
				text = text .. '\t' .. v .. ',\n'
			end
			text = text:sub(1, -3) .. "\n]\n"
			
			file = io.open("data/gbans.json", "w")
			file:write(text)
			file:close()
			send_document(msg.to.id, "./data/gbans.json")
					
		elseif matches[2] == "lua" then	
			local text = "return {\ngbans = {\n"
			for k, v in pairs (redis:smembers("gbans")) do
				text = text .. '\t' .. v .. ',\n'
			end		
			text = text:sub(1, -3) .. '\n  },\n\n}\n'
			
			file = io.open("data/gbans.lua", "w")
			file:write(text)
			file:close()
			send_document(msg.to.id, "./data/gbans.lua")
			
		elseif matches[2] == "install" then	
			t = scandir("data/")
			for k, v in pairs(t) do
				if string.match(v, "^gbans%.[Ll]ua$") then		
					local count = 0
					local gbanst = load_gbans("data/"..v)
					for k, v in pairs (gbanst) do
						count = count + 1
						redis:sadd("gbans", v)
					end
					send_msg(msg.to.id, count .. lang_text(msg.to.id, 'gbanLua'), "html")
					
				elseif string.match(v, "^gbans%.[Jj][sS][Oo][nN]$") then
					local count = 0
					local f = io.open("data/"..v, "r")
					repeat
						local line = f:read ("*l")
						if line then
							local user = (line:gsub('[%D/n]',''))
							if (string.len(user)) ~= 0 then
								count = count + 1
								redis:sadd("gbans", user)
							end
						end
					until not line	
					
					f:close()
					send_msg(msg.to.id, count .. lang_text(msg.to.id, 'gbanJson'), "html")
				end	
			end
			
		elseif matches[2] == "delete" then
			redis:del("gbans")
			send_msg(msg.to.id, lang_text(msg.to.id, 'gbanDel'), "html")
		end
   end
end

function load_gbans(file)
	local f = io.open(file, "r")
	local data = loadfile (file)()
	local t = {}
	for v,user in pairs(data.gbans) do
		t[v] = user
	end
	return t
end

return {
        patterns = {
                "^[!/#]([Gg]bans)$",
				"^[!/#]([Gg]bans) (.*)$"
					},
    run = run,
}
