serpent = require("serpent")

json = (loadfile "../libs/JSON.lua")()

--redis = (loadfile "./libs/redis.lua")()

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
    return msg
end

function send_msg(chat_id, text, cb_function, cb_extra)
    tdcli_function ({ID="SendMessage", chat_id_=chat_id, reply_to_message_id_=0, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0]={ID="MessageEntityBold", offset_=0, length_=9}}}}, dl_cb, nil)
end

function reply_msg(chat_id, text, msg_id, cb_extra)
    tdcli_function ({ID="SendMessage", chat_id_=chat_id, reply_to_message_id_=msg_id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0]={ID="MessageEntityBold", offset_=0, length_=9}}}}, dl_cb, nil)
end

-- Same as send_large_msg_callback but friendly params
function send_large_msg(destination, text)
    local cb_extra = {
        destination = destination,
        text = text
    }
    send_large_msg_callback(cb_extra, true)
end

-- If text is longer than 4096 chars, send multiple msg.
-- https://core.telegram.org/method/messages.sendMessage
function send_large_msg_callback(cb_extra, success, result)
    local text_max = 4096

    local destination = cb_extra.destination
    local text = cb_extra.text
    local text_len = string.len(text)
    local num_msg = math.ceil(text_len / text_max)

    if num_msg <= 1 then
        send_msg(destination, text, ok_cb, false)
    else

        local my_text = string.sub(text, 1, 4096)
        local rest = string.sub(text, 4096, text_len)

        local cb_extra = {
            destination = destination,
            text = rest
        }

        send_msg(destination, my_text, send_large_msg_callback, cb_extra)
    end
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