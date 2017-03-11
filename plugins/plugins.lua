do

	local to_id = ""

	-- Returns the key (index) in the config.enabled_plugins table
	local function plugin_enabled( name )
	    for k,v in pairs(_config.enabled_plugins) do
	        if name == v then
	            return k
	        end
	    end
	    -- If not found
	    return false
	end

	-- Returns true if file exists in plugins folder
	local function plugin_exists( name )
	    for k,v in pairs(plugins_names()) do
	        if name..'.lua' == v then
	            return true
	        end
	    end
	    return false
	end

	local function list_plugins(only_enabled)
	    local text = '*'..lang_text(to_id, 'pluginsActivated')..':*\n'
	    local psum = 0
	    for k, v in pairs( plugins_names( )) do
	        --  ✅ enabled, ❎ disabled
	        local status = '`✗`'
	        psum = psum+1
	        pact = 0
	        -- Check if is enabled
	        for k2, v2 in pairs(_config.enabled_plugins) do
	            if v == v2..'.lua' then
	                status = '`✓`'
	            end
	            pact = pact+1
	        end
	        if not only_enabled and status == '`✗`'then
	            -- get the name
	            v = string.match (v, "(.*)%.lua")
	            text = text..status..'  _'..v..'_\n'
	        elseif not only_enabled and status == '`✓`' then
	            -- get the name
	            v = string.match (v, "(.*)%.lua")
	            text = text..status..'  '..v..'\n'
	        end
	    end
	    return text
	end

	local function reload_plugins(de)
	    plugins = {}
	    load_plugins()
	    if de == 'en' then
	        return lang_text(to_id, 'pluginEnabled')
	    elseif de == 'di' then
	        return lang_text(to_id, 'pluginDisabled')
	    end
	end


	local function enable_plugin(plugin_name)
	    -- Check if plugin is enabled
	    if plugin_enabled(plugin_name) then
	        return lang_text(to_id, 'pluginIsEnabled')
	    end
	    -- Checks if plugin exists
	    if plugin_exists(plugin_name) then
	        -- Add to the config table
	        table.insert(_config.enabled_plugins, plugin_name)
	        save_config()
	        -- Reload the plugins
	        return reload_plugins('en')
	    else
	        return lang_text(to_id, 'pluginNoExist'):gsub("$name", plugin_name)
	    end
	end

	local function disable_plugin(plugin_name)
	    -- Check if plugins exists
	    if not plugin_exists(plugin_name) then
	        return lang_text(to_id, 'pluginNoExist'):gsub("$name", plugin_name)
	    end
	    local k = plugin_enabled(plugin_name)
	    -- Check if plugin is enabled
	    if not k then
	        return lang_text(to_id, 'pluginNoEnabled')
	    end
	    -- Disable and reload
	    table.remove(_config.enabled_plugins, k)
	    save_config( )
	    return reload_plugins('di')
	end


	local function run(msg, matches)
		to_id = msg.to.id
	    if permissions(msg.from.id, msg.to.id, "plugins") then
	        -- Enable a plugin
	        if matches[1] == 'enable' then
	            local plugin_name = matches[2]
	            print("enable: "..matches[2])
	            return enable_plugin(plugin_name)
	        end
	        -- Disable a plugin
	        if matches[1] == 'disable' then
	            print("disable: "..matches[2])
	            return disable_plugin(matches[2])
	        end
	        -- Reload all the plugins!
	        if matches[1] == 'reload' then
				send_msg(msg.to.id, lang_text(msg.to.id, 'pluginsReload'), "md")
	            return reload_plugins(true)
	        end

	        if matches[1] == 'plugins' then
	            return list_plugins()
	        end
	    else
	        return lang_text(msg.to.id, 'require_sudo')
	    end
	end

	return {
	    patterns = {
	        "^[!/#](plugins)$",
	        "^[!/#]plugins? (enable) ([%w_%.%-]+)$",
	        "^[!/#]plugins? (disable) ([%w_%.%-]+)$",
	        "^[!/#]plugins? (reload)$" },
	  run = run
	}
end