local function run(msg, matches)
        if matches[1] == "setwarn" then
                send_msg(msg.to.id, "warnSet", "md")
        end
end
return {
        patterns = {
                "^[!/#](setwarn)$"
        },
        run = run,
        pre_process = pre_process
}
