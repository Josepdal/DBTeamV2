package.path = package.path .. ';../.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'..';../bot/?.lua'..';./libs/?.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

require('utils')

local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")



chats = {}

function dl_cb (arg, data)
end

function do_notify (user, msg)
    local n = notify.Notification.new(user, msg)
    n:show ()
end

function load_config( )
	local f = io.open('./data/config.lua', "r")
  	-- If config.lua doesn't exist
  	if not f then
  		create_config()
  		print ("Created new config file: data/config.lua")
  	else
  		f:close()
  	end
  	local config = loadfile ("../data/config.lua")()
  	for v,user in pairs(config.sudo_users) do
  		print("Allowed user: " .. user)
  	end
  	return config
end

function create_config()
    -- A simple config with basic plugins and ourselves as privileged user
    config = {
        enabled_plugins = {
            "id"
        },
        our_id = {0},
        sudo_users = {our_id},
        disabled_channels = {}
    }
    serialize_to_file(config, '../data/config.lua')
    print ('saved config into ../data/config.lua')
end

function load_plugins()
    for k, v in pairs(_config.enabled_plugins) do
        print("Loading plugin", v)
        local ok, err =  pcall(function()
            local t = loadfile("../plugins/"..v..'.lua')()
            plugins[v] = t
        end)
        if not ok then
            print('\27[31mError loading plugin '..v..'\27[39m')
            print('\27[31m'..err..'\27[39m')
        end
    end
end

_config = load_config()
-- load plugins
plugins = {}
load_plugins()

-- This function is called when tg receive a msg
function tdcli_update_callback (data)
    if (data.ID == "UpdateNewMessage") then
        local msgb = data.message_
        local d = data.disable_notification_
        local chat = chats[msgb.chat_id_]

        if ((not d) and chat) then
            if msgb.content_.ID == "MessageText" then
                do_notify (chat.title_, msgb.content_.text_)
            else
                do_notify (chat.title_, msgb.content_.ID)
            end
        end

        msg = oldtg(data)

        receiver = msg.to.id

        if _config.our_id == msg.from.id then
            msg.from.id = 0
        end

        if data.message_.content_.ID == "MessageText" then
            if msg_valid(msg) then
                msg = pre_process_msg(msg)
                if msg then
                    match_plugins(msg)
                    --mark_read(receiver, ok_cb, false)
                end
            end
        end
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
        			send_large_msg(receiver, result)
      			end
      		end
      		-- One patterns matches
      		return
    	end
  	end
end

our_id = 0
now = os.time()
math.randomseed(now)