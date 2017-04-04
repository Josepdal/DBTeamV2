----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

package.path = package.path ..';.luarocks/share/lua/5.2/?.lua' .. ';./bot/?.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

redis = require("redis")
redis = redis.connect('127.0.0.1', 6379)

require('utils')
require("permissions")
require('methods')

local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")

chats = {}

function do_notify (user, msg)
    local n = notify.Notification.new(user, msg)
    n:show ()
end

function save_config( )
    serialize_to_file(_config, './data/config.lua')
    print ('saved config into ./data/config.lua')
end

function load_config( )
    local f = io.open('./data/config.lua', "r")
    -- If config.lua doesn't exist
    if not f then
        create_config()
        print ("Created new config file: data/config.lua")
		redis:sadd("start", "settings")
    else
		redis:sadd("load", "settings")
        f:close()
    end
    local config = loadfile ("./data/config.lua")()
    for v,user in pairs(config.sudo_users) do
        print("Allowed user: " .. user)
    end
    return config
end

function create_config()
    -- A simple config with basic plugins and ourselves as privileged user
    config = {
        enabled_plugins = {
            "settings",
            "id",
            "promote",
            "moderation",
            "commands",
            "plugins",
            "stats",
			"gbans",
			"extra",
			"langs",
			"private"
        },
        enabled_lang = {
            "english_lang"
        },
        our_id = {0},
        sudo_users = {0}
    }
    serialize_to_file(config, './data/config.lua')
    print ('saved config into ./data/config.lua')
end

function load_plugins()
    for k, v in pairs(_config.enabled_plugins) do
        print("Loading plugin", v)
        local ok, err = pcall(function()
            local t = loadfile("./plugins/"..v..'.lua')()
            plugins[v] = t
        end)
        if not ok then
            print('\27[31mError loading plugin '..v..'\27[39m')
            print('\27[31m'..err..'\27[39m')
        end
    end
end

function load_lang()
    for k, v in pairs(_config.enabled_lang) do
        print('\27[92mLoading language '.. v..'\27[39m')

        local ok, err = pcall(function()
        local t = loadfile("./lang/"..v..'.lua')()
            plugins[v] = t
        end)

        if not ok then
            print('\27[31mError loading language '..v..'\27[39m')
            print(tostring(io.popen("lua lang/"..v..".lua"):read('*all')))
            print('\27[31m'..err..'\27[39m')
        end
    end
end

_config = load_config()
-- load plugins
plugins = {}
load_plugins()
load_lang()

function bot_init(msg)
    receiver = msg.to.id

    --Idea from https://github.com/RememberTheAir/GroupButler/blob/master/bot.lua
    if msg.from then
        if msg.from.username then
            redis:hset('bot:usernames', '@'..msg.from.username:lower(), msg.from.id)
            redis:hset('bot:ids', msg.from.id, '@'.. msg.from.username:lower())
        else
        	redis:hset('bot:usernames', '@' .. msg.from.first_name:lower(), msg.from.id)
        	redis:hset('bot:ids', msg.from.id, msg.from.first_name:lower())
        end
        redis:sadd('chat:' .. msg.to.id .. ':members', msg.from.id)
    end

    if msg.added then
        for i = 1, #msg.added, 1 do
            redis:sadd('chat:' .. msg.to.id .. ':members', msg.added[i].id)
        end
    end

    if msg.reply_id then
        redis:sadd('chat:' .. msg.to.id .. ':members', msg.replied.id)
		if msg.replied.username then
			redis:hset('bot:usernames', '@'.. msg.replied.username:lower(), msg.replied.id)
			redis:hset('bot:ids', msg.replied.id, '@'..msg.replied.username:lower())
		else
			redis:hset('bot:usernames', msg.replied.first_name:lower(), msg.replied.id)
			redis:hset('bot:ids', msg.replied.id, msg.replied.first_name:lower())
		end
    end

    if msg.to.id ~= msg.from.id then 		-- If it is not a private chat
        redis:sadd('chats:ids', msg.to.id)
    end

    if _config.our_id == msg.from.id then
        msg.from.id = 0
    end

    if msg_valid(msg) then
        msg = pre_process_msg(msg)
        if msg then
			if msg.from.id == msg.to.id then 	-- match special plugins in private
				match_plugin(plugins.private, private, msg)
			else
				match_plugins(msg)
			end
			mark_as_read(msg.to.id, {[0] = msg.id})
        end
    end

end

function user_reply_callback(msg, message)
    msg = reply_data(msg, message)
    bot_init(msg)
end

function reply_callback(msg, message)
    msg.replied.id = message.sender_user_id_
    tdcli_function ({
        ID = "GetUser",
        user_id_ = msg.replied.id
    }, user_reply_callback, msg)
end

function user_callback(msg, message)
    msg = user_data(msg, message)
    if msg.reply_id then
        tdcli_function ({
            ID = "GetMessage",
            chat_id_ = msg.to.id,
            message_id_ = msg.reply_id
        }, reply_callback, msg)
    else
        bot_init(msg)
    end
end

-- This function is called when tg receive a msg
function tdcli_update_callback(data)
    if (data.ID == "UpdateNewMessage") then
        local msgb = data.message_
        local d = data.disable_notification_
        local chat = chats[msgb.chat_id_]

        if ((not d) and chat) then
            if msgb.content_.ID == "MessageText" then
                do_notify(chat.title_, msgb.content_.text_)
            else
                do_notify(chat.title_, msgb.content_.ID)
            end
        end
		
		if redis:sismember("start", "settings") then
			redis:srem("start", "settings")
			changeAbout("DBTeamV2 Tg-cli administration Bot\nChannels: @DBTeamEn @DBTeamEs", ok_cb)
			getMe(getMeCb)
		elseif redis:sismember("load", "settings") then
			redis:srem("load", "settings")
			-- This loads to cache most of users, chats, channels .. that are removed in every reboot
			getChats(2^63 - 1, 0, 20, ok_cb)
			-- This opens all chats and channels in order to receive updates
			for k, chat in pairs (redis:smembers('chats:ids')) do
				 openChat(chat, ok_cb)
			end
		end

        msg = oldtg(data)
        tdcli_function ({
            ID = "GetUser",
            user_id_ = data.message_.sender_user_id_
        }, user_callback, msg)
    end
end

function msg_valid(msg)
    -- Don't process outgoing messages
    if msg.from.id == 0 then
        print('\27[36mNot valid: msg from us\27[39m')
        return false
    end

    -- Before bot was started
    if msg.date < now then
        print('\27[36mNot valid: old msg\27[39m')
        return false
    end

    if msg.unread == 0 then
        print('\27[36mNot valid: readed\27[39m')
        return false
    end

    if not msg.to.id then
        print('\27[36mNot valid: To id not provided\27[39m')
        return false
    end

    if not msg.from.id then
        print('\27[36mNot valid: From id not provided\27[39m')
        return false
    end

    if msg.from.id == 777000 then
        print('\27[36mNot valid: Telegram message\27[39m')
        return false
    end

    return true
end

-- Apply plugin.pre_process function
function pre_process_msg(msg)
    for name,plugin in pairs(plugins) do
        if plugin.pre_process and msg then
            print('Preprocess', name)
            msg = plugin.pre_process(msg)
        end
    end
    return msg
end

-- Go over enabled plugins patterns.
function match_plugins(msg)
    for name, plugin in pairs(plugins) do
        match_plugin(plugin, name, msg)
    end
end

-- Check if plugin is on _config.disabled_plugin_on_chat table
local function is_plugin_disabled_on_chat(plugin_name, receiver)
    local disabled_chats = _config.disabled_plugin_on_chat
    -- Table exists and chat has disabled plugins
    if disabled_chats and disabled_chats[receiver] then
        -- Checks if plugin is disabled on this chat
        for disabled_plugin,disabled in pairs(disabled_chats[receiver]) do
            if disabled_plugin == plugin_name and disabled then
                local warning = 'Plugin '..disabled_plugin..' is disabled on this chat'
                return true
            end
        end
    end
    return false
end

function match_plugin(plugin, plugin_name, msg)
    local receiver = get_receiver(msg)
    -- Go over patterns. If one matches it's enough.
    for k, pattern in pairs(plugin.patterns) do
        local matches = match_pattern(pattern, msg.text)
        if matches then
            -- Function exists
            if plugin.run then
                -- If plugin is for privileged users only
                local result = plugin.run(msg, matches)
                if result then
                    send_msg(receiver, result, "md")
                end
            end
            -- One patterns matches
            return
        end
    end
end

now = os.time()
math.randomseed(now)
