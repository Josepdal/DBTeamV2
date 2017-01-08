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
    	ID="DeleteMessages",
    	chat_id_=chat_id,
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

function kick_by_reply(channel_id, message_id)
	get_msg_info(channel_id, message_id, kick_user_cb, false)
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

function kick_user_cb(arg, msg)
  	tdcli_function ({
    	ID = "ChangeChatMemberStatus",
    	chat_id_ = msg.chat_id_,
    	user_id_ = msg.sender_user_id_,
    	status_ = {
      		ID = "ChatMemberStatusKicked"
    	},
  	}, dl_cb, nil)
end

function resolve_username(username, cb_function, cb_extra)
    vardump(username)
    tdcli_function ({
        ID = "SearchPublicChat",
        username_ = username
    }, cb_function, cb_extra)
end

function resolve_id(user_id, cb_function, cb_extra)
    tdcli_function ({
        ID = "GetUserFull",
        user_id_ = user_id
    }, cb_function, cb_extra)
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

function kick_resolve_cb(chat_id, user)
    tdcli_function ({
        ID = "ChangeChatMemberStatus",
        chat_id_ = tonumber(chat_id),
        user_id_ = user.id_,
        status_ = {
            ID = "ChatMemberStatusKicked"
        },
    }, dl_cb, nil)
end

function kick_resolve(chat_id, username)
    resolve_username(username, kick_resolve_cb, chat_id)
end

function redisunban_by_reply(channel_id, message_id)
    get_msg_info(channel_id, message_id, redisunban_by_reply_cb, channel_id)
end

function redisunban_by_reply_cb(channel_id, msg)
    redis:del("ban:" .. channel_id .. ":" .. msg.sender_user_id_)
end

function redisban_resolve_cb(chat_id, user)
    redis:set("ban:" .. chat_id .. ":" .. user.id_, true)
end

function redisban_resolve(chat_id, username)
    resolve_username(username, redisban_resolve_cb, chat_id)
end

function redisunban_resolve_cb(chat_id, user)
    redis:del("ban:" .. chat_id .. ":" .. user.id_)
end

function redisunban_resolve(chat_id, username)
    resolve_username(username, redisunban_resolve_cb, chat_id)
end