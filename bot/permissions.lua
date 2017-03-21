local sudos = {
    "lang_install",
    "promote_admin",
    "plugins",
	"banall",
	"leave",
	"setabout",
	"creategroup"
}
local admins = {
	"promote_mod",
	"promote_user",
	"gban",
	"add_moderation"
}
local mods = {
	"set_lang",
	"settings",
	"muteBan",
	"moderation",
	"mod_commands",
	"tagall",
	"rem_history",
	"spam"
}

local function get_tag(plugin_tag)
	for v,tag in pairs(sudos) do
	    if tag == plugin_tag then
	       	return 3
	    end
  	end
  	for v,tag in pairs(admins) do
	    if tag == plugin_tag then
	       	return 2
	    end
  	end
  	for v,tag in pairs(mods) do
	    if tag == plugin_tag then
	       	return 1
	    end
  	end
  	return 0
end

local function user_num(user_id, chat_id)
	if new_is_sudo(user_id) then
		return 3
	elseif is_admin(user_id) then
		return 2
	elseif is_mod(chat_id, user_id) then
		return 1
	else
		return 0
	end
end

local function send_warning(user_id, chat_id, user_need)
	if user_need == 3 then
		send_msg(chat_id, lang_text(chat_id, 'require_sudo'), 'md')
	elseif user_need == 2 then
		send_msg(chat_id, lang_text(chat_id, 'require_admin'), 'md')
	elseif user_need == 1 then
		send_msg(chat_id, lang_text(chat_id, 'require_mod'), 'md')
	end
end

function compare_permissions(chat_id, user_id, user_id2)
	if user_num(user_id, chat_id) > user_num(user_id2, chat_id) then
		return true
	else
		return false
	end
end

function permissions(user_id, chat_id, plugin_tag, option)
	local user_need = get_tag(plugin_tag)
	local user_is = user_num(user_id, chat_id)
	if user_is >= user_need then
		return true
	else
		if option ~= "silent" then
			send_warning(user_id, chat_id, user_need)
		end
		return false
	end
end
