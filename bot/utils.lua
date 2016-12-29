serpent = require("serpent")

json = (loadfile "./libs/JSON.lua")()

--redis = (loadfile "./libs/redis.lua")()

function dl_cb (arg, data)
end

function vardump(value, depth, key)
    local linePrefix = ""
    local spaces = ""
  
    if key ~= nil then
        linePrefix = "["..key.."] = "
    end
  
    if depth == nil then
        depth = 0
    else
        depth = depth + 1
        for i=1, depth do spaces = spaces .. "  " end
    end
  
    if type(value) == 'table' then
        mTable = getmetatable(value)
        if mTable == nil then
            print(spaces ..linePrefix.."(table) ")
        else
            print(spaces .."(metatable) ")
            value = mTable
        end   
        for tableKey, tableValue in pairs(value) do
            vardump(tableValue, depth, tableKey)
        end
    elseif type(value)  == 'function' or type(value) == 'thread' or type(value) == 'userdata' or value == nil then
        print(spaces..tostring(value))
    else
        print(spaces..linePrefix.."("..type(value)..") "..tostring(value))
    end
end

function ok_cb(extra, success, result)
    
end

function oldtg(data)
    local msg = {}
    msg.to = {}
    msg.from = {}
    msg.to.id = data.message_.chat_id_
    msg.from.id = data.message_.sender_user_id_
    msg.text = data.message_.content_.text_
    msg.date = data.message_.date_
    msg.id = data.message_.id_
    msg.unread = false
    msg.reply_id = data.message_.reply_to_message_id_
    return msg
end

function serialize_to_file(data, file, uglify)
    file = io.open(file, 'w+')
    local serialized
    if not uglify then
        serialized = serpent.block(data, {
            comment = false,
            name = '_'
        })
    else
        serialized = serpent.dump(data)
    end
    file:write(serialized)
    file:close()
end

-- Returns a table with matches or nil
function match_pattern(pattern, text, lower_case)
  if text then
    local matches = {}
    if lower_case then
      matches = { string.match(text:lower(), pattern) }
    else
      matches = { string.match(text, pattern) }
    end
      if next(matches) then
        return matches
      end
  end
  -- nil
end

function get_receiver(msg)
    return msg.from.id

end

function getChatId(chat_id)
    print("chat_id")
  local chat = {}
  local chat_id = tostring(chat_id)

  if chat_id:match('^-100') then
    local channel_id = chat_id:gsub('-100', '')
    chat = {ID = channel_id, type = 'channel'}
  else
    local group_id = chat_id:gsub('-', '')
    chat = {ID = group_id, type = 'group'}
  end
  vardump(chat)

  return chat
end