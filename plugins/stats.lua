local function sort_(tbl, sortFunction)
        local keys = {}
        for key in pairs(tbl) do
                table.insert(keys, key)
        end
        table.sort(keys, function(a, b)
                return sortFunction(tbl[a], tbl[b])
        end)
        return keys
end

local function get_name(chatid, id)
        hash = "statsn:"..chatid
        ok = redis:hget(hash, tostring(id))
        if ok then
                to_space = string.find(ok, " ")
                if to_space then
                        return string.sub(ok, 0, to_space)
                end
                return ok
        end
        return false
end

local function get_msgs(chatid, id)
        hash = "stats:"..chatid
        ok = redis:hget(hash, tostring(id))
        if ok then
                return tonumber(ok)
        end
        return tonumber(0)
end

local function get_ranking(chatid, first_message)
        local user = first_message
        hash = "stats:"..chatid
        local reg = redis:hkeys(hash)
        local lista = {}
        for i,x in pairs(reg) do
                local total = get_msgs(chatid, x)
                lista[x] = tonumber(total)
        end
        local tabla = sort_(lista, function(a, b) return a > b end)
        for i,x in pairs(tabla) do
                if i > 20 then break end
                if i == 1 then
                        user = user.."\n  "..i.."° 🏆 `"..get_name(chatid, x).." ➝ "..lista[x].."`"
                elseif i == 2 then
                        user = user.."\n  "..i.."° ⭐️ `"..get_name(chatid, x).." ➝ "..lista[x].."`"
                elseif i == 3 then
                        user = user.."\n  "..i.."° 🔥 `"..get_name(chatid, x).." ➝ "..lista[x].."`"
                else
                        user = user.."\n  "..i.."°  `"..get_name(chatid, x).." ➝ "..lista[x].."`"
                end
        end
        return user
end

local function pre_process(msg)
        if msg.from.id then
                hash = "stats:"..msg.to.id
                hash2 = "statsn:"..msg.to.id
                redis:hincrby(hash, msg.from.id, 1)
                redis:hset(hash2, msg.from.id, msg.from.first_name)
        end
        return msg
end


local function run(msg, matches)
        if matches[1] == lang_text(msg.to.id, 'statsCommand') or matches[1] == "stats" then
                ranking = get_ranking(msg.to.id, lang_text(msg.to.id, 'stats'))
                send_msg(msg.to.id, ranking, "md")
        end
end
return {
        patterns = {
                "^[!/#](stats)$",
				"^[!/#](وضعیت)$"--[[,
				"^[!/#](add command with your language)$"]]--
        },
        run = run,
        pre_process = pre_process
}
