----------------------------------------------------
--      ___  ___ _____            __   _____      --
--     |   \| _ )_   _|__ __ _ _ _\ \ / /_  )     --
--     | |) | _ \ | |/ -_) _` | '  \ V / / /      --
--     |___/|___/ |_|\___\__,_|_|_|_\_/ /___|     --
--                                                --
----------------------------------------------------

local function lang_enabled(name)
    for k,v in pairs(_config.enabled_lang) do
	    if name == v then
	        return true
	    end
	end
	return false
end

local function lang_exists( name )
    for k,v in pairs(langs_names()) do
	    if name..'.lua' == v then
	        return true
	    end
	end
	return false
end

local function enable_lang(lang_name) 
	table.insert(_config.enabled_lang, lang_name)
	load_lang()
	save_config()
	send_msg(msg.to.id, "`>` This lang was correctly installed in your bot, use `#install <lang_package>` to load the translations and `#lang <lang>` to change the language.", "md")
end

local function run(msg, matches)
	if permissions(msg.from.id, msg.to.id, "plugins") then
		if lang_enabled(matches[2]) == true then
			send_msg(msg.to.id, "`>` This lang is already installed, use `#install <lang_package>` to load the translations and `#lang <lang>` to change the language.", "md")
		else
			if lang_exists(matches[2]) == true then
				enable_lang(matches[2])
			else
				send_msg(msg.to.id, "`>` This lang does not exists in `/lang` folder.", "md")
			end
		end
	end
end

return {
	patterns = {
	    "^[!/#]([Ee][Nn][aA][Bb][lL]e) (%S+)$",
		},
	run = run
}
