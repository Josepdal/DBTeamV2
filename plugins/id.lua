----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function run(msg, matches)
    send_msg(msg.to.id, "Tu id es: " .. msg.from.id, ok_cb, false)
    reply_msg(msg.to.id, "Tu id es: " .. msg.from.id, msg.id, false)
end

return {
  patterns = {
    "^[!/#](id)$"
  },
  run = run
}