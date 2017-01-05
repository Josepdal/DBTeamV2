local function pre_process()
    list = require("data/spam_data")
    for number, pattern in pairs(list.blacklist["default"]) do
        local matches = match_pattern(pattern, msg.text)
        if matches then
            send_msg(msg.to.id, "El texto `" .. msg.text .. "` ha coincidido con `" .. pattern .. "`", "md")
        end
    end
    return msg
end


local function run(msg, matches)
  hash = {
    blacklist = "DBsettings:"..msg.to.id..":blacklist",
    spam = "DBsettings:"..msg.to.id..":lspam"
  }
  current_status = redis:get(hash.spam)
  if matches[1] == "disable" then
    if current_status == "off" then
      send_msg(msg.to.id, "*Spam is already disabled*.", "md")
      return nil
    end
    redis:set(hash.spam, "off")
    send_msg(msg.to.id, "*Spam disabled*.", "md")
  end
  if matches[1] == "enable" then
    if current_status == "on" then
      send_msg(msg.to.id, "*Spam is already enabled*.", "md")
      return
    end
    redis:set(hash.spam, "on")
    send_msg(msg.to.id, "*Spam enabled*.", "md")
  end
end

return {
  patterns = {
    "^!spam (disable)",
    "^!spam (enable)",
  },
  run = run,
  pre_process = pre_process
}
