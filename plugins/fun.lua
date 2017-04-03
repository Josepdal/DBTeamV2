do

local function get_9GAG()
  local url = "http://api-9gag.herokuapp.com/"
  local b,c = http.request(url)
  if c ~= 200 then return nil end
  local gag = json:decode(b)
  -- random max json table size
  local i = math.random(#gag)
  local link_image = gag[i].src
  local title = gag[i].title
  if link_image:sub(0,2) == '//' then
    link_image = msg.text:sub(3,-1)
  end
  return link_image, title
end

local function send_title(cb_extra, success, result)
  if success then
    send_msg(cb_extra[1], cb_extra[2], ok_cb, false)
  end
end
--[[
local function run(msg, matches)
 
  return false
end
]]--
local function run(msg, matches)
        if matches[1] == "9gag" then
			 local receiver = get_receiver(msg)
  local url, title = get_9GAG()
  send_photo_from_url(receiver, url, send_title, {receiver, title})
        end
end
return {
        patterns = {
              "^!9gag$"
        },
        run = run,
        pre_process = pre_process
}

end
