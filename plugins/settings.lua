----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function get_added_users(msg)
	local users = ""
	for i = 1, #msg.added, 1 do
		if msg.added[i].username then
			users = users .. "@" .. msg.added[i].username
		elseif msg.added[i].first_name then
			users = users .. msg.added[i].first_name
		end
		if i == (#msg.added - 1) then
			users = users .. " & "
		elseif i ~= #msg.added then
			users = users .. ", "
		end
	end
	return users
end

function send_report(msg,reason)
	local user_id_ = ''
	if msg.from.username then
		 user_id_ = "@" .. msg.from.username
	end
    local text = '*Spam report:*\n*User:* '.. user_id_ ..'`(`'..msg.from.id..'`)-'..msg.from.first_name..'`\n*Message:* _'..msg.text..'_\n*Pattern:* _'..reason..'_' ---put translattions
    for v,user in pairs(_config.sudo_users) do
        send_msg(user, text, 'md')
    end
end

local function get_exported_link(arg, data)
	if data.message_ then
		send_msg(arg, lang_text(arg, 'linkError'), 'md')
	else
		redis:set("settings:link:" .. msg.to.id, data.invite_link_)
		send_msg(arg, lang_text(arg, 'linkSet'), 'md')
	end
end

local function getlink(arg,data)
	local link = data.invite_link_
	send_msg(msg.to.id, link, 'html')
end

local function pre_process(msg)
	if msg.added then
		if redis:get("moderation_group: " .. msg.to.id) then
			for k, user in pairs (msg.added) do 
				if is_gban(user.id)	then									-- checks if user is gbanned
					kick_user(msg.to.id, user.id)
				end
				if is_mod(msg.to.id, user.id) then 	                        -- checks if user is mod
					promoteToAdmin(msg.to.id, user.id)
				end
				if is_admin(user.id) then                                   -- checks if user is admin
					promoteToAdmin(msg.to.id, user.id)
				end
				if new_is_sudo(user.id) then                                 -- checks if user is sudo
					promoteToAdmin(msg.to.id, user.id)
				end
				if user.username then
					if string.find(user.username, "([Bb][oO][Tt])$") then		-- checks if it is a bot
						if redis:get("settings:bots:" .. msg.to.id) then
							kick_user(msg.to.id, user.id)
						end
					end
				end
				if user.first_name then
					if redis:get("settings:arabic:" .. msg.to.id) then        -- checks if name with arabic letters, removes the msg and kicks him
						if (string.find(user.first_name, "[\216-\219][\128-\191]")) then
							delete_msg(msg.to.id, user.id)
							kick_user(msg.to.id, user.id)
						end
						if user.last_name then
							if (string.find(user.last_name, "[\216-\219][\128-\191]")) then
								delete_msg(msg.to.id, user.id)
								kick_user(msg.to.id, user.id)
							end
						end	
					end
				end
			end
		end
		if redis:get("settings:welcome:"..msg.to.id) then
			local users
			if #msg.added > 0 then
				users = get_added_users(msg)
			else
				users = msg.added[1]
			end
			local welcomeText
			if redis:get("settings:welcome:msg:" .. msg.to.id) then
				welcomeText = redis:get("settings:welcome:msg:" .. msg.to.id):gsub("$users", users)
			else
				welcomeText = lang_text(msg.to.id, 'defaultWelcome'):gsub("$users", users)
			end
			send_msg(msg.to.id, welcomeText, 'html')
		end
	end
	if permissions(msg.from.id, msg.to.id, "settings", "silent") then
		return msg
	end
	if msg.text then
    	if redis:get("settings:spam:" .. msg.to.id) and redis:get("moderation_group: " .. msg.to.id) then
	    	local list = require("data/spam_data")
	    	local customlist = redis:get("settings:setspam:" .. msg.to.id) or "default"
		    for number, pattern in pairs(list.blacklist[customlist]) do
		        matches = match_pattern(pattern, msg.text)
				spam = true
		        if matches then	
					for number, pattern1 in pairs(list.whitelist[customlist]) do
						local matches1 = match_pattern(pattern1, msg.text)
						if matches1 then
							spam = false
						end
					end					
					if spam then
						if msg.from.username then
							user_ = msg.from.username
						else
							user_ = msg.from.first_name
						end
						reply_msg(msg.to.id, lang_text(msg.to.id, 'user') .. " *" .. user_ .. "* (" .. msg.from.id .. ") " .. lang_text(msg.to.id, 'isSpamming'), msg.id, 'md')
						delete_msg(msg.to.id, msg.id)
						if redis:get("settings:reports:" .. msg.to.id) then
							send_report(msg,pattern)
						end
					end
		        end
		    end
		end
		if redis:get("settings:arabic:" .. msg.to.id) then
			if string.find(msg.text, "[\216-\219][\128-\191]") then
				delete_msg(msg.to.id, msg.id)
				kick_user(msg.to.id, msg.from.id)
				send_msg(msg.to.id, "`>` *Arabic is not allowed* in this chat, user kicked.", 'md')
			end
		end
	elseif msg.photo and redis:get("moderation_group: " .. msg.to.id) then
        if redis:get("settings:photos:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.sticker and redis:get("moderation_group: " .. msg.to.id) then
        if redis:get("settings:stickers:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.audio and redis:get("moderation_group: " .. msg.to.id)then
        if redis:get("settings:audios:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.voice and redis:get("moderation_group: " .. msg.to.id)then
       	if redis:get("settings:voice:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.gif and redis:get("moderation_group: " .. msg.to.id) then
        if redis:get("settings:gifs:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.service and redis:get("moderation_group: " .. msg.to.id) then -- Only group creator can delete this messages
        if redis:get("settings:tgservices:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.video and redis:get("moderation_group: " .. msg.to.id) then
        if redis:get("settings:videos:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.document and redis:get("moderation_group: " .. msg.to.id) then
        if redis:get("settings:documents:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.forward and redis:get("moderation_group: " .. msg.to.id) then
        if redis:get("settings:forward:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.forward.msg_id)
        end		
    end
    if redis:get("settings:flood:" .. msg.to.id) and redis:get("moderation_group: " .. msg.to.id) then
	    local maxFlood = tonumber(redis:get("settings:maxFlood:" .. msg.to.id)) or 5
	    local floodTime = tonumber(redis:get("settings:floodTime:" .. msg.to.id)) or 3
	    local hash = 'flood:'..msg.from.id..':'..msg.to.id..':msg-num'
	    local msgs = tonumber(redis:get(hash) or 0)
	    if msgs > maxFlood then
	        local user = msg.from.id
	        local chat = msg.to.id
	        local username = msg.from.username or "username"
	        if not redis:get("settings:flood:user:" .. msg.from.id) then
	        	send_msg(msg.to.id, lang_text(chat, 'user')..' @'.. username ..' ('..msg.from.id..') ' .. lang_text(chat, 'isFlooding'), 'md')
	        end
	        redis:setex("settings:flood:user:" .. msg.from.id, 60, true)
	        kick_user(msg.to.id, msg.from.id)
	        msg.text = ""
		    return msg
	    end
	    redis:setex(hash, floodTime, msgs+1)
	end
	return msg
end

local function run(msg, matches)
		if matches[1] == 'lang' then
		    if permissions(msg.from.id, msg.to.id, 'set_lang') then
		        hash = 'langset:'..msg.to.id
		        redis:set(hash, matches[2])
		        return lang_text(msg.to.id, 'langUpdated')..string.upper(matches[2])
		    else
		        return '🚫 '..lang_text(msg.to.id, 'require_sudo')
		    end
		elseif matches[1]:lower() == "settings" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			local settings = "*" .. lang_text(msg.to.id, 'groupSettings') .. ":*\n"
			-- Check TgServices
			if redis:get("settings:tgservices:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'tgservices') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'tgservices') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Invite
			if redis:get("settings:invite:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'invite') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'invite') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Bots
			if redis:get("settings:bots:" .. msg.to.id) then
				settings = settings .. "`>` *Bots:* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *Bots:* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Language
			if redis:get("langset:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'language') .. ":* `" .. redis:get("langset:" .. msg.to.id) .. "`\n"
			else
				redis:set("langset:" .. msg.to.id, 'en')
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'language') .. ":* `" .. redis:get("langset:" .. msg.to.id) .. "`\n"
			end
			settings = settings.. "\n*" .. lang_text(msg.to.id, 'allowedMedia') .. " :*\n"
			-- Check Photos
			if redis:get("settings:photos:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'photos') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'photos') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Videos
			if redis:get("settings:videos:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'videos') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'videos') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Stickers
			if redis:get("settings:stickers:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'stickers') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'stickers') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Gifs
			if redis:get("settings:gifs:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'gifs') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'gifs') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Voice
			if redis:get("settings:voice:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'voice') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'voice') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Audios
			if redis:get("settings:audios:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'audios') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'audios') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Documents
			if redis:get("settings:documents:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'documents') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'documents') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Location
			if redis:get("settings:location:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'location') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'location') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Games
			if redis:get("settings:games:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'games') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'games') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end

			settings = settings.. "\n*" .. lang_text(msg.to.id, 'settingsText') .. ":*\n"

			-- Check Forward
			if redis:get("settings:forward:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'forward') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'forward') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Spam
			if redis:get("settings:spam:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'spam') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'spam') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Get Spam
			if redis:get("settings:spam:type" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'spam') .. ":* `" .. redis:get("settings:spam:type" .. msg.to.id) .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'spam') .. ":* `default `\n"
			end
			-- Send report
			if redis:get("settings:reports:" .. msg.to.id) then
				settings = settings .. "`>` *Reports:* `activated`\n" --translations
			else
				settings = settings .. "`>` *Reports:* `disabled`\n" --translations
			end
			-- Check Flood
			if redis:get("settings:flood:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'flood') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'flood') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check maxFlood
			if redis:get("settings:maxFlood:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'mFlood') .. ":* `" .. redis:get("settings:maxFlood:" .. msg.to.id) .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'mFlood') .. ":* `5`\n"
			end
			-- Check timeFlood
			if redis:get("settings:floodTime:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'tFlood') .. ":* `" .. redis:get("settings:floodTime:" .. msg.to.id) .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'tFlood') .. ":* `3`\n"
			end
			-- Check Arabic
			if redis:get("settings:arabic:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'arabic') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'arabic') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check English
			if redis:get("settings:english:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'english') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'english') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end
			-- Check Emojis
			if redis:get("settings:emojis:" .. msg.to.id) then
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'emojis') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			else
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'emojis') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			end

			send_msg(msg.to.id, settings, 'md')
		elseif matches[1] == "tgservices" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:tgservices:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noTgservicesT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:tgservices:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'tgservicesT'), 'md')
			end
		elseif matches[1] == "invite" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:invite:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noInviteT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:invite:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'inviteT'), 'md')
			end
		elseif matches[1] == "bots" then
			if matches[2] == 'off' then
				redis:set("settings:bots:" .. msg.to.id, true)
				send_msg(msg.to.id, "`>` *Bots* are now *not allowed* in this chat.", 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:bots:" .. msg.to.id)
				send_msg(msg.to.id, "`>` *Bots* are now *allowed* in this chat.", 'md')
			end
		elseif matches[1] == "photos" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:photos:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noPhotosT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:photos:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'photosT'), 'md')
			end
		elseif matches[1] == "videos" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:videos:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noVideosT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:videos:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'videosT'), 'md')
			end
		elseif matches[1] == "stickers" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:stickers:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noStickersT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:stickers:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'stickersT'), 'md')
			end
		elseif matches[1] == "gifs" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:gifs:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noGifsT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:gifs:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'gifsT'), 'md')
			end
		elseif matches[1] == "voice" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:voice:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noVoiceT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:voice:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'voiceT'), 'md')
			end
		elseif matches[1] == "audios" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:audios:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noAudiosT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:audios:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'audiosT'), 'md')
			end
		elseif matches[1] == "documents" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:documents:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noDocumentsT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:documents:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'documentsT'), 'md')
			end
		elseif matches[1] == "location" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:location:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noLocationT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:location:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'locationT'), 'md')
			end
		elseif matches[1] == "games" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:games:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noGamesT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:games:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'gamesT'), 'md')
			end
		elseif matches[1] == "forward" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:forward:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noForwardT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:forward:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'forwardT'), 'md')
			end
		elseif matches[1] == "spam" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:spam:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noSpamT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:spam:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'spamT'), 'md')
			end
		elseif matches[1] == "setspam" and permissions(msg.from.id, msg.to.id, "settings") and matches[2] and redis:get("moderation_group: " .. msg.to.id) then
			redis:set("settings:setspam:" .. msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'setSpam') .. "*" .. matches[2] .. "*.", 'md')
		elseif matches[1] == "reports" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'on' then
				redis:set("settings:reports:" .. msg.to.id, true)
				send_msg(msg.to.id, "`>` *Spam reports* are now *activated* in this chat.", 'md') -- translations
			elseif matches[2] == 'off' then
				redis:del("settings:reports:" .. msg.to.id)
				send_msg(msg.to.id, "`>` *Spam reports* are *disabled* in this chat.", 'md') -- translations
			end			
		elseif matches[1] == "arabic" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:arabic:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noArabicT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:arabic:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'arabicT'), 'md')
			end
		elseif matches[1] == "english" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:english:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noEnglishT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:english:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'englishT'), 'md')
			end
		elseif matches[1] == "emojis" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:emojis:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noEmojisT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:emojis:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'emojisT'), 'md')
			end
		elseif matches[1] == "flood" and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if matches[2] == 'off' then
				redis:set("settings:flood:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noFloodT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:flood:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodT'), 'md')
			end
		elseif matches[1] == "welcome" and permissions(msg.from.id, msg.to.id, "settings") then
			if matches[2] == 'off' then
				redis:del("settings:welcome:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noWelcomeT'), 'md')
			elseif matches[2] == 'on' then
				redis:set("settings:welcome:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'welcomeT'), 'md')
			end
		elseif matches[1] == "setwelcome" and permissions(msg.from.id, msg.to.id, "settings") then
			if tonumber(matches[2]) == 0 then
				redis:del("settings:welcome:msg:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'weldefault'), 'md')
			else
				redis:set("settings:welcome:msg:" .. msg.to.id, matches[2])
				send_msg(msg.to.id, lang_text(msg.to.id, 'welnew') .. matches[2], 'md')
			end
		elseif matches[1] == "max" and is_number(matches[2]) and permissions(msg.from.id, msg.to.id, "settings")and redis:get("moderation_group: " .. msg.to.id) then
			if tonumber(matches[2]) == 0 then
				redis:del("settings:maxFlood:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodTime') .. ": `3`", 'md')
			else
				redis:set("settings:maxFlood:" .. msg.to.id, tonumber(matches[2]))
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodTime') .. ": `" .. matches[2] .. "`", 'md')
			end
		elseif matches[1] == "time" and is_number(matches[2]) and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			if tonumber(matches[2]) == 0 then
				redis:del("settings:floodTime:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodMax') .. ": `5`", 'md')
			else
				redis:set("settings:floodTime:" .. msg.to.id, tonumber(matches[2]))
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodMax') .. ": `" .. matches[2] .. "`", 'md')
			end
		elseif matches[1]:lower() == "setlink" and matches[2] and permissions(msg.from.id, msg.to.id, "settings") then
				redis:set("settings:link:" .. msg.to.id, matches[2])
				send_msg(msg.to.id, lang_text(msg.to.id, 'linkSet'), 'md')
		elseif matches[1]:lower() == "newlink" and not matches[2] and permissions(msg.from.id, msg.to.id, "settings") then
			export_link(msg.to.id, get_exported_link, msg.to.id)
		elseif matches[1]:lower() == "link" and not matches[2] then
			local link = redis:get("settings:link:" .. msg.to.id)
			if link then
				send_msg(msg.to.id, link, 'html')
			else
				getChannelFull(msg.to.id,  getlink)
			end
		elseif matches[1]:lower() == "rules" and not matches[2] and redis:get("moderation_group: " .. msg.to.id) then
			if not redis:get("settings:norules:" .. msg.to.id) then
				if redis:get("settings:rules:" .. msg.to.id) then
					send_msg(msg.to.id, redis:get("settings:rules:" .. msg.to.id), 'md')
				else
					send_msg(msg.to.id, lang_text(msg.to.id, 'defaultRules'), 'md')
				end
			end
		elseif matches[1]:lower() == "setrules" and matches[2] and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			redis:set("settings:rules:" .. msg.to.id, matches[2])
			redis:del("settings:norules:" .. msg.to.id)
			send_msg(msg.to.id, lang_text(msg.to.id, 'newRules'), 'md')
		elseif matches[1]:lower() == "norules" and not matches[2] and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			redis:del("settings:rules:" .. msg.to.id, matches[2])
			redis:set("settings:norules:" .. msg.to.id, true)
			send_msg(msg.to.id, lang_text(msg.to.id, 'noRules'), 'md')
		elseif matches[1]:lower() == "remrules" and not matches[2] and permissions(msg.from.id, msg.to.id, "settings") and redis:get("moderation_group: " .. msg.to.id) then
			redis:del("settings:rules:" .. msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'rulesDefault'), 'md')
		end
	
end

return {
  	patterns = {
		'^[!/#]([Ss]ettings)$',
		'^[!/#](lang) (.*)$',
		'^[!/#](tgservices) (.*)$',
		'^[!/#](invite) (.*)$',
		'^[!/#](bots) (.*)$',
		'^[!/#](photos) (.*)$',
		'^[!/#](videos) (.*)$',
		'^[!/#](stickers) (.*)$',
		'^[!/#](gifs) (.*)$',
		'^[!/#](voice) (.*)$',
		'^[!/#](audios) (.*)$',
		'^[!/#](documents) (.*)$',
		'^[!/#](location) (.*)$',
		'^[!/#](games) (.*)$',
		'^[!/#](forward) (.*)$',
		'^[!/#](spam) (.*)$',
		'^[!/#](setspam) (.*)$',
		'^[!/#](reports) (.*)$',
		'^[!/#](arabic) (.*)$',
		'^[!/#](english) (.*)$',
		'^[!/#](emojis) (.*)$',
		'^[!/#](flood) (.*)$',
		'^[!/#](welcome) (.*)$',
		'^[!/#](setwelcome) (.*)$',
		'^[!/#](max) (.*)$',
		'^[!/#](time) (.*)$',
		'^[!/#]([Ss]et[Ll]ink) (.*)$',
		'^[!/#]([Nn]ew[Ll]ink)$',
		'^[!/#]([Ll]ink)$',
		'^[!/#]([Rr]ules)$',
		'^[!/#]([Ss]et[Rr]ules) (.*)$',
		'^[!/#]([Rr]em[Rr]ules)$',
		'^[!/#]([Nn]o[Rr]ules)$'
  	},
  	run = run,
  	pre_process = pre_process
}
