----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function run(msg, matches)
    if msg.reply_id == 0 then
    	pin_msg(msg.to.id, msg.id, 1)
    else
    	pin_msg(msg.to.id, msg.reply_id, 1)
    end
end

return {
  patterns = {
    "^!pin"
  },
  run = run
}