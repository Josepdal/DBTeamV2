package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'..';./bot/?.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

require('utils')

local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")

chats = {}

function do_notify (user, msg)
    local n = notify.Notification.new(user, msg)
    n:show ()
end

function tdcli_update_callback (data)
	
end
