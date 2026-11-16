-- Giant Toymod loader
-- Roblox executor向け: GitHub上の本体を取得して実行します。
local SOURCE_URL = "https://raw.githubusercontent.com/kohtan28-cell/giant-toymod/main/giant_toymod.lua"
local source = game:HttpGet(SOURCE_URL)
local chunk, err = loadstring(source)
if not chunk then
    error("giant_toymod.lua の読み込みに失敗しました: " .. tostring(err))
end
return chunk()
