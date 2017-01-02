package.path = package.path .. ';../.luarocks/share/lua/5.2/?.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

require('utils')
require('methods')

local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")

chats = {}

function do_notify (user, msg)
    local n = notify.Notification.new(user, msg)
    n:show ()
end

function load_config( )
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
    serialize_to_file(config, './data/config.lua')
    print ('saved config into ./data/config.lua')
end

function load_plugins()
    for k, v in pairs(_config.enabled_plugins) do
        print("Loading plugin", v)
            local t = loadfile("./plugins/"..v..'.lua')()
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
                    mark_as_read(msg.to.id, {[0] = msg.id})
                end
            end
        end
    end
end

function msg_valid(msg)
end

-- Apply plugin.pre_process function
function pre_process_msg(msg)
end

-- Go over enabled plugins patterns.
function match_plugins(msg)
end

-- Check if plugin is on _config.disabled_plugin_on_chat table
local function is_plugin_disabled_on_chat(plugin_name, receiver)
end

function match_plugin(plugin, plugin_name, msg)
end

our_id = 0
now = os.time()
math.randomseed(now)