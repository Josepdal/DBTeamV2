----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function run(msg, matches)
	if matches[1] == 'lang' then
	    if permissions(msg.from.id, msg.to.id, 'set_lang') then
	        hash = 'langset:'..msg.to.id
	        redis:set(hash, matches[2])
	        return lang_text(msg.to.id, 'langUpdated')..string.upper(matches[2])
	    else
	        return '🚫 '..lang_text(msg.to.id, 'require_sudo')
	    end
	end
end

return {
  patterns = {
    '^[!/#](lang) (.*)$'
  },
  run = run
}