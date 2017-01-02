----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function run(msg, matches)
    if msg.reply_id == 0 then
    	kick_user(msg.to.id, matches[0])
    else
    	kick_by_reply(msg.to.id, msg.reply_id)
    end
end

return {
  patterns = {
    "^!kick (.*)",
    "^!kick"
  },
  run = run
}