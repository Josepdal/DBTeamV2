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

function pin_msg(channel_id, message_id, disable_notification)
  	tdcli_function ({
    	ID = "PinChannelMessage",
    	channel_id_ = getChatId(channel_id).ID,
    	message_id_ = message_id,
    	disable_notification_ = disable_notification
  	}, dl_cb, nil)
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
		elseif extra.command == "mod" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'newMod') .. ": @" .. (user.type_.user_.username_ or user.type_.user_.first_name_), "html")
			redis:sadd('mods:'..extra.chat_id, user.id_)
			if new_is_sudo(extra.superior) then
				redis:srem('admins', user.id_)
			end
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

local function getInputFile(file)
    if file:match('/') then
        infile = {ID = "InputFileLocal", path_ = file}
    elseif file:match('^%d+$') then
        infile = {ID = "InputFileId", id_ = file}
    else
        infile = {ID = "InputFilePersistentId", persistent_id_ = file}
    end
    return infile
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

function export_link(chat_id, cb_function, cb_extra)
    tdcli_function ({
        ID = "ExportChatInviteLink",
        chat_id_ = chat_id
    }, cb_function, cb_extra)
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