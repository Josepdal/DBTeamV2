function send_msg(chat_id, text, parse)
    tdcli_function ({
    	ID="SendMessage",
    	chat_id_ = chat_id,
    	reply_to_message_id_ = 0,
    	disable_notification_ = 0,
    	from_background_ = 1,
    	reply_markup_ = nil,
    	input_message_content_ = {
    		ID="InputMessageText",
    		text_ = text,
    		disable_web_page_preview_ = 1,
    		clear_draft_ = 0,
    		parse_mode_ = getParse(parse),
    		entities_ = {}
    	}
    }, dl_cb, nil)
end

function reply_msg(chat_id, text, msg_id, parse)
    tdcli_function ({
    	ID = "SendMessage",
    	chat_id_ = chat_id,
    	reply_to_message_id_ = msg_id,
    	disable_notification_ = 0,
    	from_background_ = 1,
    	reply_markup_ = nil,
    	input_message_content_ = {
    		ID = "InputMessageText",
    		text_ = text,
    		disable_web_page_preview_ = 1,
    		clear_draft_ = 0,
    		parse_mode_ = getParse(parse),
    		entities_ = {}
    	}
    }, dl_cb, nil)
end

function createNewGroupChat(user_ids, title, cb, cmd)
  tdcli_function ({
    ID = "CreateNewGroupChat",
    user_ids_ = user_ids, -- vector
    title_ = title
  }, cb or dl_cb, cmd)
end

function migrateGroupChatToChannelChat(chat_id, cb, cmd)
  tdcli_function ({
    ID = "MigrateGroupChatToChannelChat",
    chat_id_ = chat_id
  }, cb or dl_cb, cmd)
end

function changeChatMemberStatus(chat_id, user_id, status, cb, cmd)
  tdcli_function ({
    ID = "ChangeChatMemberStatus",
    chat_id_ = chat_id,
    user_id_ = user_id,
    status_ = {
      ID = "ChatMemberStatus" .. status
    },
  }, cb or dl_cb, cmd)
end

function delete_msg(chat_id, msg_id)
	msg_id = {[0] = msg_id}
    tdcli_function ({
    	ID = "DeleteMessages",
    	chat_id_ = chat_id,
    	message_ids_ = msg_id
    }, dl_cb, nil)
end

function getParse(parse)
	if parse  == 'md' then
		return {ID = "TextParseModeMarkdown"}
	elseif parse == 'html' then
		return {ID = "TextParseModeHTML"}
	else
		return nil
	end
end

function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra)
  tdcli_function ({
    ID = request_id,
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    reply_markup_ = reply_markup,
    input_message_content_ = input_message_content,
  }, callback or dl_cb, extra)
end

function add_user(chat_id, user_id)
  	tdcli_function ({
    	ID = "AddChatMember",
    	chat_id_ = chat_id,
    	user_id_ = user_id,
    	forward_limit_ = 0
  	}, dl_cb, extra)
end

function mark_as_read(chat_id, message_ids)
  	tdcli_function ({
    	ID = "ViewMessages",
    	chat_id_ = chat_id,
    	message_ids_ = message_ids
  	}, dl_cb, extra)
end

function get_msg_info(chat_id, message_id, cb_function, extra)
  	tdcli_function ({
    	ID = "GetMessage",
    	chat_id_ = chat_id,
    	message_id_ = message_id
  	}, cb_function, extra)
end

function getChats(offset_order, offset_chat_id, limit, cb, cmd)
  if not limit or limit > 20 then
    limit = 20
  end

  tdcli_function ({
    ID = "GetChats",
    offset_order_ = offset_order or 9223372036854775807,
    offset_chat_id_ = offset_chat_id or 0,
    limit_ = limit
  }, cb or dl_cb, cmd)
end

function getMe(cb, cmd)
  tdcli_function ({
    ID = "GetMe",
  }, cb or dl_cb, cmd)
end

function getMeCb(extra, result)
	our_id = result.id_
	print("Our id: "..our_id)
	file = io.open("./data/config.lua", "r")
	config = ''
	repeat
		line = file:read ("*l")
		if line then
			line = string.gsub(line, "0", our_id)
			config = config.."\n"..line
		end
	until not line
		
	file:close()
	file = io.open("./data/config.lua", "w")
	file:write(config)
	file:close()	
end

function changeAbout(about, cb, cmd)
  tdcli_function ({
    ID = "ChangeAbout",
    about_ = about
  }, cb or dl_cb, cmd)
end

function pin_msg(channel_id, message_id, disable_notification)
  	tdcli_function ({
    	ID = "PinChannelMessage",
    	channel_id_ = getChatId(channel_id).ID,
    	message_id_ = message_id,
    	disable_notification_ = disable_notification
  	}, dl_cb, nil)
end

function openChat(chat_id, cb, cmd)
  tdcli_function ({
    ID = "OpenChat",
    chat_id_ = chat_id
  }, cb or dl_cb, cmd)
end

function kick_user(chat_id, user_id)
  	tdcli_function ({
    	ID = "ChangeChatMemberStatus",
    	chat_id_ = chat_id,
    	user_id_ = user_id,
    	status_ = {
      		ID = "ChatMemberStatusKicked"
    	},
  	}, dl_cb, nil)
end

function promoteToAdmin(chat_id, user_id)
  	tdcli_function ({
    	ID = "ChangeChatMemberStatus",
    	chat_id_ = chat_id,
    	user_id_ = user_id,
    	status_ = {
      		ID = "ChatMemberStatusModerator"
    	},
  	}, dl_cb, nil)
end

function removeFromBanList(chat_id, user_id)
    tdcli_function ({
      ID = "ChangeChatMemberStatus",
      chat_id_ = chat_id,
      user_id_ = user_id,
      status_ = {
          ID = "ChatMemberStatusLeft"
      },
    }, dl_cb, nil)
end

function resolve_username(username, cb_function, cb_extra)
    tdcli_function ({
        ID = "SearchPublicChat",
        username_ = username
    }, cb_function, cb_extra)
end

function resolve_cb(extra, user)
	if compare_permissions(extra.chat_id, extra.superior, user.id_) then
		if extra.command == "ban" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'banUser'), "md")
			kick_user(extra.chat_id, user.id_)
			redis:set("ban:" .. extra.chat_id .. ":" .. user.id_, true)
		elseif extra.command == "unban" then		
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'unbanUser'), "md")
			redis:del("ban:" .. extra.chat_id .. ":" .. user.id_)
      removeFromBanList(extra.chat_id, user.id_)
		elseif extra.command == "kick" then		
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'kickUser'), "md")
			kick_user(extra.chat_id, user.id_)
		elseif extra.command == "gban" then		
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'gbanUser'), "md")
			kick_user(extra.chat_id, user.id_)
			redis:sadd("gbans", user.id_)
		elseif extra.command == "ungban" then		
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'unbanUser'), "md")
			redis:srem("gbans", user.id_)
		elseif extra.command == "mute" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'muteUser'), "md")
			redis:set("muted:" .. extra.chat_id .. ":" .. user.id_, true)
		elseif extra.command == "unmute" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'unmuteUser'), "md")
			redis:del("muted:" .. extra.chat_id .. ":" .. user.id_)
		elseif extra.command == "admin" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'newAdmin') .. ": @" .. (user.type_.user_.username_ or user.type_.user_.first_name_), "html")
			redis:sadd('admins', user.id_)
			redis:srem('mods:'..extra.chat_id, user.id_)
      redis:hset('bot:ids',user.id_, '@'.. user.type_.user_.username_)
		elseif extra.command == "mod" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'newMod') .. ": @" .. (user.type_.user_.username_ or user.type_.user_.first_name_), "html")
			redis:sadd('mods:'..extra.chat_id, user.id_)
			if new_is_sudo(extra.superior) then
				redis:srem('admins', user.id_)
			end
      redis:hset('bot:ids',user.id_, '@'.. user.type_.user_.username_)
		elseif extra.command == "user" then
			if new_is_sudo(extra.superior) then
				redis:srem('mods:'..extra.chat_id, user.id_)
				redis:srem('admins', user.id_)
			elseif is_admin(extra.superior) then
				redis:srem('mods:'..extra.chat_id, user.id_)
			end
			send_msg(extra.chat_id, "<code>></code> @" .. (user.type_.user_.username_ or user.type_.user_.first_name_) .. "" ..  lang_text(extra.chat_id, 'nowUser'), "html")
		end
	else
		permissions(extra.superior, extra.chat_id, extra.plugin_tag)
		
	end
end

function resolve_id(user_id, cb_function, cb_extra)
    tdcli_function ({
        ID = "GetUserFull",
        user_id_ = user_id
    }, cb_function, cb_extra)
end

function getChat(chat_id, cb, cmd)
  tdcli_function ({
    ID = "GetChat",
    chat_id_ = chat_id
  }, cb or dl_cb, cmd)
end

function getChannelMembers(channel_id, offset, filter, limit, cb_function, cb_extra)
  if not limit or limit > 200 then
    limit = 200
  end

  tdcli_function ({
    ID = "GetChannelMembers",
    channel_id_ = getChatId(channel_id).ID,
    filter_ = {
      ID = "ChannelMembers" .. filter
    },
    offset_ = offset,
    limit_ = limit
  }, cb_function or cb_function, cb_extra)
end

function forward_msg(chat_id, from_chat_id, message_id)
    message_id = {[0] = message_id}
    tdcli_function ({
        ID = "ForwardMessages",
        chat_id_ = chat_id,
        from_chat_id_ = from_chat_id,
        message_ids_ = message_id,
        disable_notification_ = 0,
        from_background_ = 1
    }, dl_cb, nil)
end

function kick_resolve_cb(extra, user)
    if compare_permissions(extra.chat_id, extra.superior, user.id_) then
        tdcli_function ({
            ID = "ChangeChatMemberStatus",
            chat_id_ = tonumber(extra.chat_id),
            user_id_ = user.id_,
            status_ = {
                ID = "ChatMemberStatusKicked"
            },
        }, dl_cb, nil)
    else
        send_msg(extra.chat_id, 'error', 'md')
    end
end

function kick_resolve(chat_id, username, extra)
    resolve_username(username, kick_resolve_cb, {chat_id = chat_id, superior = extra})
end

function redisunban_by_reply_cb(channel_id, msg)
    redis:del("ban:" .. channel_id .. ":" .. msg.sender_user_id_)
end

function redisunban_by_reply(channel_id, message_id)
    get_msg_info(channel_id, message_id, redisunban_by_reply_cb, channel_id)
end

function redisban_resolve_cb(extra, user)
    if compare_permissions(extra.chat_id, extra.superior, user.id_) then
        redis:set("ban:" .. extra.chat_id .. ":" .. user.id_, true)
    end
end

function redisban_resolve(chat_id, username, superior)
    local extra = {}
    resolve_username(username, redisban_resolve_cb, {chat_id = chat_id, superior = superior})
end

function redisgban_resolve_cb(chat_id, user)
    redis:sadd("gbans", user.id_)
end

function redisgban_resolve(chat_id, username)
    resolve_username(username, redisgban_resolve_cb, chat_id)
end

function redisgban_resolve_cb(chat_id, user)
    redis:srem("gbans", user.id_)
end

function redisgban_resolve(chat_id, username)
    resolve_username(username, redisgban_resolve_cb, chat_id)
end

function redisunban_resolve_cb(extra, user)
    if compare_permissions(extra.chat_id, extra.superior, user.id_) then
        redis:del("ban:" .. extra.chat_id .. ":" .. user.id_)
    end
end

function redisunban_resolve(chat_id, username, superior)
    resolve_username(username, redisunban_resolve_cb, {chat_id = chat_id, superior = superior})
end

function redismute_resolve_cb(chat_id, user)
    redis:set("muted:" .. chat_id .. ":" .. user.id_, true)
end

function redismute_resolve(chat_id, username)
    resolve_username(username, redismute_resolve_cb, chat_id)
end

function redisunmute_resolve_cb(chat_id, user)
    redis:del("muted:" .. chat_id .. ":" .. user.id_)
end

function redisunmute_resolve(chat_id, username)
    resolve_username(username, redisunmute_resolve_cb, chat_id)
end

function getInputFile(file)
    if file:match('/') then
        infile = {ID = "InputFileLocal", path_ = file}
    elseif file:match('^%d+$') then
        infile = {ID = "InputFileId", id_ = file}
    else
        infile = {ID = "InputFilePersistentId", persistent_id_ = file}
    end
    return infile
end

function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)
  local input_message_content = {
    ID = "InputMessageSticker",
    sticker_ = getInputFile(sticker),
    width_ = 0,
    height_ = 0
  }
  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end

function send_document(chat_id, document)
    tdcli_function ({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = 0,
    disable_notification_ = 0,
    from_background_ = 1,
    reply_markup_ = nil,
    input_message_content_ = {
            ID = "InputMessageDocument",
            document_ = getInputFile(document),
            caption_ = nil
        },
    }, dl_cb, cb_extra)
end

function sendSticker(chat_id, sticker)
  local input_message_content = {
    ID = "InputMessageSticker",
    sticker_ = getInputFile(sticker),
    width_ = 0,
    height_ = 0
  }
  sendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendAnimation(chat_id, gif, caption)
  local input_message_content = {
    ID = "InputMessageAnimation",
    animation_ = getInputFile(gif),
    width_ = 0,
    height_ = 0,
    caption_ = caption
  }
  sendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendAudio(chat_id, audio, caption)
  local input_message_content = {
    ID = "InputMessageAudio",
    audio_ = getInputFile(audio),
    duration_ = duration or 0,
    title_ = title or 0,
    performer_ = performer,
    caption_ = caption
  }
  sendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendDocument(chat_id, document, caption)
  local input_message_content = {
    ID = "InputMessageDocument",
    document_ = getInputFile(document),
    caption_ = caption
  }
  sendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendPhoto(chat_id, photo, caption)
  local input_message_content = {
    ID = "InputMessagePhoto",
    photo_ = getInputFile(photo),
    added_sticker_file_ids_ = {},
    width_ = 0,
    height_ = 0,
    caption_ = caption
  }
  sendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendVideo(chat_id, video, caption)
  local input_message_content = {
    ID = "InputMessageVideo",
    video_ = getInputFile(video),
    added_sticker_file_ids_ = {},
    duration_ = duration or 0,
    width_ = width or 0,
    height_ = height or 0,
    caption_ = caption
  }
  sendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendVoice(chat_id, voice, caption)
  local input_message_content = {
    ID = "InputMessageVoice",
    voice_ = getInputFile(voice),
    duration_ = duration or 0,
    waveform_ = waveform or 0,
    caption_ = caption
  }
  sendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function cbsti(a,b)
	--vardump(a)
	--vardump(b)
end

function export_link(chat_id, cb_function, cb_extra)
    tdcli_function ({
        ID = "ExportChatInviteLink",
        chat_id_ = chat_id
    }, cb_function, cb_extra)
end

function checkChatInviteLink(link, cb, cmd)
  tdcli_function ({
    ID = "CheckChatInviteLink",
    invite_link_ = link
  }, cb or dl_cb, cmd)
end

function getChannelFull(channel_id, cb, cmd)
  tdcli_function ({
    ID = "GetChannelFull",
    channel_id_ = getChatId(channel_id).ID
  }, cb or dl_cb, cmd)
end

function chat_history(chat_id, from_message_id, offset, limit, cb_function, cb_extra)
    if not limit or limit > 100 then
        limit = 100
    end
    tdcli_function ({
        ID = "GetChatHistory",
        chat_id_ = chat_id,
        from_message_id_ = from_message_id,
        offset_ = offset or 0,
        limit_ = limit
    }, cb_function, cb_extra)
end

function delete_msg_user(chat_id, user_id)
    tdcli_function ({
        ID = "DeleteMessagesFromUser",
        chat_id_ = chat_id,
        user_id_ = user_id
    }, cb or dl_cb, nil)
end