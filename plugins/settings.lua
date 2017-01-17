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
			users = users .. " `@"..msg.added[i].username .."`"
		elseif msg.added[0].first_name then
			users = users .. " `@"..msg.added[i].username .."`"
		end
		if i == (#msg.added - 1) then
			users = users .. " and "
		elseif i ~= #msg.added then
			users = users .. ", "
		end
	end
	return users
end

local function pre_process(msg)
	--send_msg(msg.to.id, return_media(msg), 'md')
	if msg.added then
		if not redis:get("settings:welcome:"..msg.to.id) then
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
			send_msg(msg.to.id, welcomeText, 'md')
		end
	end
	if permissions(msg.from.id, msg.to.id, "settings") then
		return msg
	end
	if msg.text then
    	if redis:get("settings:spam:" .. msg.to.id) then
	    	local list = require("data/spam_data")
	    	local blacklist = redis:get("settings:setspam:" .. msg.to.id) or "default"
		    for number, pattern in pairs(list.blacklist[blacklist]) do
		        local matches = match_pattern(pattern, msg.text)
		        if matches then
		        	reply_msg(msg.to.id, lang_text(msg.to.id, 'user') .. " *" .. msg.from.username .. "* (" .. msg.from.id .. ") " .. lang_text(msg.to.id, 'isSpamming'), msg.id, 'md')
		            delete_msg(msg.to.id, msg.id)
		            msg.text = ""
		            return msg
		        end
		    end
		end
	elseif msg.photo then
        if redis:get("settings:photos:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.sticker then
        if redis:get("settings:stickers:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.audio then
        if redis:get("settings:audios:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.voice then
       	if redis:get("settings:voice:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.gif then
        if redis:get("settings:gifs:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.service then -- Only group creator can delete this messages
        if redis:get("settings:tgservices:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.video then
        if redis:get("settings:videos:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.document then
        if redis:get("settings:documents:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.id)
        end
    elseif msg.forward then
        if redis:get("settings:forward:" .. msg.to.id) then
        	delete_msg(msg.to.id, msg.forward.msg_id)
        end
    end
    if redis:get("settings:flood:" .. msg.to.id) then
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
	        --kick_user(msg.to.id, msg.from.id)
	        msg.text = ""
		    return msg
	    end
	    redis:setex(hash, floodTime, msgs+1)
	end
	return msg
end

local function run(msg, matches)
	if permissions(msg.from.id, msg.to.id, "settings") then
		if matches[1] == 'lang' then
		    if permissions(msg.from.id, msg.to.id, 'set_lang') then
		        hash = 'langset:'..msg.to.id
		        redis:set(hash, matches[2])
		        return lang_text(msg.to.id, 'langUpdated')..string.upper(matches[2])
		    else
		        return '🚫 '..lang_text(msg.to.id, 'require_sudo')
		    end
		elseif matches[1]:lower() == "settings" then
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
			-- Check Icon/Title
			--if redis:get("settings:icontitle:" .. msg.to.id) then
				--settings = settings .. "`>` *" .. lang_text(msg.to.id, 'icontitle') .. ":* `" .. lang_text(msg.to.id, 'noAllowed') .. "`\n"
			--else
				--settings = settings .. "`>` *" .. lang_text(msg.to.id, 'icontitle') .. ":* `" .. lang_text(msg.to.id, 'allowed') .. "`\n"
			--end
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
				settings = settings .. "`>` *" .. lang_text(msg.to.id, 'spam') .. ":* ` default `\n"
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
		elseif matches[1] == "tgservices" then
			if matches[2] == 'off' then
				redis:set("settings:tgservices:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noTgservicesT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:tgservices:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'tgservicesT'), 'md')
			end
		elseif matches[1] == "invite" then
			if matches[2] == 'off' then
				redis:set("settings:invite:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noInviteT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:invite:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'inviteT'), 'md')
			end
		--elseif matches[1] == "info" then
			--if matches[2] == 'off' then
				--redis:set("settings:icontitle:" .. msg.to.id, true)
				--send_msg(msg.to.id, lang_text(msg.to.id, 'noInfoT'), 'md')
			--elseif matches[2] == 'on' then
				--redis:del("settings:icontitle:" .. msg.to.id)
				--send_msg(msg.to.id, lang_text(msg.to.id, 'infoT'), 'md')
			--end
		elseif matches[1] == "photos" then
			if matches[2] == 'off' then
				redis:set("settings:photos:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noPhotosT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:photos:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'photosT'), 'md')
			end
		elseif matches[1] == "videos" then
			if matches[2] == 'off' then
				redis:set("settings:videos:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noVideosT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:videos:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'videosT'), 'md')
			end
		elseif matches[1] == "stickers" then
			if matches[2] == 'off' then
				redis:set("settings:stickers:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noStickersT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:stickers:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'stickersT'), 'md')
			end
		elseif matches[1] == "gifs" then
			if matches[2] == 'off' then
				redis:set("settings:gifs:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noGifsT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:gifs:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'gifsT'), 'md')
			end
		elseif matches[1] == "voice" then
			if matches[2] == 'off' then
				redis:set("settings:voice:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noVoiceT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:voice:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'voiceT'), 'md')
			end
		elseif matches[1] == "audios" then
			if matches[2] == 'off' then
				redis:set("settings:audios:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noAudiosT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:audios:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'audiosT'), 'md')
			end
		elseif matches[1] == "documents" then
			if matches[2] == 'off' then
				redis:set("settings:documents:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noDocumentsT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:documents:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'documentsT'), 'md')
			end
		elseif matches[1] == "location" then
			if matches[2] == 'off' then
				redis:set("settings:location:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noLocationT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:location:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'locationT'), 'md')
			end
		elseif matches[1] == "games" then
			if matches[2] == 'off' then
				redis:set("settings:games:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noGamesT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:games:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'gamesT'), 'md')
			end
		elseif matches[1] == "forward" then
			if matches[2] == 'off' then
				redis:set("settings:forward:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noForwardT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:forward:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'forwardT'), 'md')
			end
		elseif matches[1] == "spam" then
			if matches[2] == 'off' then
				redis:set("settings:spam:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noSpamT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:spam:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'spamT'), 'md')
			end
		elseif matches[1] == "setspam" and matches[2] then
			redis:set("settings:setspam:" .. msg.to.id, matches[2])
			send_msg(msg.to.id, lang_text(msg.to.id, 'setSpam') .. "*" .. matches[2] .. "*.", 'md')
		elseif matches[1] == "arabic" then
			if matches[2] == 'off' then
				redis:set("settings:arabic:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noArabicT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:arabic:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'arabicT'), 'md')
			end
		elseif matches[1] == "english" then
			if matches[2] == 'off' then
				redis:set("settings:english:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noEnglishT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:english:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'englishT'), 'md')
			end
		elseif matches[1] == "emojis" then
			if matches[2] == 'off' then
				redis:set("settings:emojis:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noEmojisT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:emojis:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'emojisT'), 'md')
			end
		elseif matches[1] == "flood" then
			if matches[2] == 'off' then
				redis:set("settings:flood:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'noFloodT'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:flood:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodT'), 'md')
			end
		elseif matches[1] == "welcome" then
			if matches[2] == 'off' then
				redis:set("settings:welcome:" .. msg.to.id, true)
				send_msg(msg.to.id, lang_text(msg.to.id, 'weloff'), 'md')
			elseif matches[2] == 'on' then
				redis:del("settings:welcome:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'welon'), 'md')
			end
		elseif matches[1] == "setwelcome" then
			if tonumber(matches[2]) == 0 then
				redis:del("settings:welcome:msg:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'defaultWelcomeT'), 'md')
			else
				redis:set("settings:welcome:msg:" .. msg.to.id, matches[2])
				send_msg(msg.to.id, lang_text(msg.to.id, 'setWelcomeT'), 'md')
			end
		elseif matches[1] == "max" and is_number(matches[2]) then
			if tonumber(matches[2]) == 0 then
				redis:del("settings:maxFlood:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodTime') .. ": `3`", 'md')
			else
				redis:set("settings:maxFlood:" .. msg.to.id, tonumber(matches[2]))
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodTime') .. ": `" .. matches[2] .. "`", 'md')
			end
		elseif matches[1] == "time" and is_number(matches[2]) then
			if tonumber(matches[2]) == 0 then
				redis:del("settings:floodTime:" .. msg.to.id)
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodMax') .. ": `5`", 'md')
			else
				redis:set("settings:floodTime:" .. msg.to.id, tonumber(matches[2]))
				send_msg(msg.to.id, lang_text(msg.to.id, 'floodMax') .. ": `" .. matches[2] .. "`", 'md')
			end
		end
	end
end

return {
  	patterns = {
		'^[!/#]([Ss]ettings)$',
		'^[!/#](lang) (.*)$',
		'^[!/#](tgservices) (.*)$',
		'^[!/#](invite) (.*)$',
		--'^[!/#](info) (.*)$',
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
		'^[!/#](arabic) (.*)$',
		'^[!/#](english) (.*)$',
		'^[!/#](emojis) (.*)$',
		'^[!/#](flood) (.*)$',
		'^[!/#](welcome) (.*)$',
		'^[!/#](setwelcome) (.*)$',
		'^[!/#](max) (.*)$',
		'^[!/#](time) (.*)$'
  	},
  	run = run,
  	pre_process = pre_process
}
