-- Spotify Plugin for bot based on Yagop
-- BY: Telegram:@TiagoDanin -:- Twitter:@_TiagoEDGE

function run(msg, matches)
  local input = matches[1]
  --URL API
  local BASE_URL = "https://api.spotify.com/v1/search"
  local URLP = "?q=".. (URL.escape(input) or "").."&type=track&limit=5" -- Limit 5
  -- Decode json
  local decj, tim = https.request(BASE_URL..URLP)
  if tim ~=200 then return nil  end
  -- Table
  local spotify = json:decode(decj)
  local tables = {}
  for pri,result in ipairs(spotify.tracks.items) do
    table.insert(tables, {
        spotify.tracks.total,
        result.name,
        result.external_urls.spotify
      })
  end
  -- Prit Tables
  local gets = ""
  for pri,cont in ipairs(tables) do
    gets=gets.."▶️ "..cont[2].." - "..cont[3].."\n"
  end
  -- ERRO 404
  local text_end = gets -- Text END
  if gets == "" then
    text_end = "Not found music"
  end
  -- Send MSG
  return text_end
end

--Run
return {
  description = "Track Spotify byTiagoDanin",
  usage = "!Spotify + Name Track",
  patterns = {
    "^![Ss]potify$", -- Prefix !
    "^![Ss]potify (.*)$",
    "^/[Ss]potify$", -- Prefix /
    "^/[Ss]potify (.*)$",
  },
  run = run
}
