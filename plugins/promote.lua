local function is_already_mod(hash, id)
  local members = redis:smembers(hash)
  for x,user in pairs(members) do
    if tonumber(id) == tonumber(user) then
      return true
    end
  end
  return false
end

local function run(msg, matches)
  hash = 'mod:'..msg.to.id..':'..msg.reply_id
  if matches[1] == "promote" then
    if is_already_mod(hash, msg.reply_id) then
      send_msg(msg.to.id, "This user is already mod", "md")
      return
    end
    redis:sadd(hash, msg.reply_id)
    send_msg(msg.to.id, "New mod "..msg.reply_id, "md")
  end
end

return {
  patterns = {
    "/(promote)"
  },
  run = run
}
