----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function resolve_cb(arg, msg)
	if msg.message_ == "USERNAME_INVALID" then
		send_msg(arg, "*ERROR:* `" .. msg.message_ .. "`", 'md')
	elseif msg.type_.ID == "PrivateChatInfo" then
		last_name_ = msg.type_.user_.last_name_
		if not msg.type_.user_.last_name_ then
			last_name_ = "not set"
		end
    	send_msg(arg, "*Type:* `" .. msg.type_.ID .. "`\n*UserID:* `" .. msg.id_ .. "`\n*Username:* @" .. msg.type_.user_.username_ .. "\n*Name:* `" .. (msg.type_.user_.first_name_):gsub("`", "") .. "`\n*Last name:* `" .. last_name_ .. "`", 'md')
    elseif msg.type_.ID == "ChannelChatInfo" and msg.type_.channel_.is_supergroup_ then
    	send_msg(arg, "*Type:* `" .. msg.type_.ID .. "`\n*Supergroup:* `" .. tostring(msg.type_.channel_.is_supergroup_) .. "`\n*UserID:* `" .. msg.id_ .. "`\n*Username:* @" .. msg.type_.channel_.username_ .. "\n*Title:* `" .. (msg.title_):gsub("`", "") .. "`\n*Verified:* `" .. tostring(msg.type_.channel_.is_verified_) .. "`", 'md')
    else
    	send_msg(arg, "*Type:* `" .. msg.type_.ID .. "`\n*Supergroup:* `" .. tostring(msg.type_.channel_.is_supergroup_) .. "`\n*UserID:* `" .. msg.id_ .. "`\n*Username:* @" .. msg.type_.channel_.username_ .. "\n*Title:* `" .. (msg.title_):gsub("`", "") .. "`\n*Verified:* `" .. tostring(msg.type_.channel_.is_verified_) .. "`", 'md')
    end
end

local function run(msg, matches)
	resolve(matches[1], resolve_cb, msg.to.id)
end

return {
  patterns = {
    "^[!/#][Rr]esolve (.*)"
  },
  run = run
}