require("json");
require("socket.http")
require("socket.url")



function babelfish(lang, query)
    lang  = lang  or "en"
    query = query or ""

    if lang == "en" or query == "" then
        return query
    end

    local result, status = socket.http.request(
        "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q="
        .. socket.url.escape(query)
        .. "&langpair=en|"
        .. lang
    )
    if not (status == 200 or status == 201) then
        return "api error: " .. status
    end

    local data = json.decode(result)
    if data.responseStatus == 200 then
        return data.responseData.translatedText
    else
        return "status " .. data.responseStatus .. ": " .. data.responseDetails
    end
end



local function run(msg, matches)
        if matches[1] == "tr" and if matches[2] then
			local text = babelfish(matches[2])
                 send_msg(msg.to.id, text, "md")
        end
end
return {
        patterns = {
                "^[!/#](tr)$"
        },
        run = run,
        pre_process = pre_process
}
