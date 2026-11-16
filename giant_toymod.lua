--[[
    Fapta Giant Trace v0.3.44

    v0.3.44: NOW RELEASE
    v0.3.43: noclip fix

]]

-- Roblox services and HertaIX window setup
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local SCRIPT_VERSION = "0.3.44"
local HertaIX = loadstring(
    game:HttpGet(
        "https://raw.githubusercontent.com/midorimidoru1-collab/HertaIX/master/HertaIX.lua"
    )
)()
local Window = HertaIX:CreateWindow("Fapta | v" .. SCRIPT_VERSION .. " BETA", "near_future")
Window:SetTitleRainbow(true)
Window:SetTitleFont("arcade")
Window._InfoTab = Window:CreateTab("INFO")
local ReanimateTab = Window:CreateTab("REANIMATE")
Window._SwordTab = Window:CreateTab("SWORD")
local SettingTab = Window:CreateTab("SETTING")
Window._OthersTab = Window:CreateTab("OTHERS")
local AutoTab = Window:CreateTab("PLOT")
local DefenseTab = Window:CreateTab("DEFENSE")
local StaffTab = Window:CreateTab("STAFF ROLL")

-- Live localization keeps the original English text for every HertaIX text object.
-- Switching languages changes display text only; callbacks, selected values, and game logic stay unchanged.
Window._FaptaLanguageState = {
    Current = "English",
    Applying = false,
    OriginalText = setmetatable({}, { __mode = "k" }),
    OriginalPlaceholder = setmetatable({}, { __mode = "k" }),
    Connections = setmetatable({}, { __mode = "k" }),
    PlaceholderConnections = setmetatable({}, { __mode = "k" }),
}

Window._FaptaExactTranslations = {
    ["INFO"] = "情報",
    ["REANIMATE"] = "巨人化",
    ["SETTING"] = "設定",
    ["OTHERS"] = "その他",
    ["PLOT"] = "プロット",
    ["DEFENSE"] = "防御",
    ["STAFF ROLL"] = "スタッフロール",
    ["-- Auto Get Coins --"] = "-- コイン自動取得 --",
    ["Auto-Spin"] = "自動スピン",
    ["-- Auto Time-Reset --"] = "-- 時間リセット --",
    ["Preserve Time"] = "Plot時間を維持",
    ["-- Auto Claim-Plot --"] = "-- Plot自動取得 --",
    ["Plot"] = "プロット",
    ["Claim Plot"] = "Plotを取得",
    ["-- build --"] = "-- ビルド --",
    ["Toy Type"] = "対象タイプ",
    ["build giant"] = "巨人を構築",
    ["cleanup"] = "クリーンアップ",
    ["-- live summary --"] = "-- ライブサマリー --",
    ["Live Parts / Body Summary"] = "パーツ・身体構成サマリー",
    ["Scanning selected source..."] = "選択中の対象を確認しています...",
    ["Refresh Summary"] = "サマリーを更新",
    ["-- required parts --"] = "-- 必要パーツ --",
    ["Normal Required Parts (1 Giant)"] = "Normal必要パーツ（巨人1体）",
    ["Double Required Parts (2 Giants)"] = "Double必要パーツ（巨人2体）",
    ["Shared Orbit Required Parts"] = "共通オービット必要パーツ",
    [ [=[Normal (1 giant)
Body: TableWoodTwoLegs x22
  Left Arm x4 / Right Arm x4
  Left Leg x4 / Right Leg x4
  Torso x6
Head: GlassBoxGray x1 when Headless is OFF
Korblox: TetracubeI x1 when Korblox leg is ON
  The four wooden right-leg boards remain reserved.]=] ] = [=[Normal（巨人1体）
身体: TableWoodTwoLegs x22
  左腕 x4 / 右腕 x4
  左脚 x4 / 右脚 x4
  胴体 x6
頭部: HeadlessがOFFのときGlassBoxGray x1
Korblox: Korblox脚がONのときTetracubeI x1
  右脚用の木板4枚は予備として保持されます。]=],
    [ [=[Double (2 giants)
Body: TableWoodTwoLegs x44 (22 for each giant)
  Left Arm x8 / Right Arm x8
  Left Leg x8 / Right Leg x8
  Torso x12
Head: GlassBoxGray x2 when Headless is OFF
Korblox: TetracubeI x2 when Korblox leg is ON
  Eight wooden right-leg boards remain reserved.]=] ] = [=[Double（巨人2体）
身体: TableWoodTwoLegs x44（各巨人22枚）
  左腕 x8 / 右腕 x8
  左脚 x8 / 右脚 x8
  胴体 x12
頭部: HeadlessがOFFのときGlassBoxGray x2
Korblox: Korblox脚がONのときTetracubeI x2
  右脚用の木板8枚は予備として保持されます。]=],
    [ [=[Shared Orbit materials (not doubled in Double mode)
FireworkSparkler: at least x1
Spotlight: at least x1 of every selected color
  SpotlightBlue / Green / Red / White]=] ] = [=[共通オービット素材（Doubleでも倍増しません）
FireworkSparkler: 1個以上
Spotlight: 選択した各色を1個以上
  SpotlightBlue / Green / Red / White]=],
    ["-- trace --"] = "-- トレース --",
    ["Giant Mode"] = "巨人モード",
    ["Be Giant"] = "巨人化",
    ["-- super necessity --"] = "-- 必須機能 --",
    ["BarrierBreak"] = "バリア破壊",
    ["-- Giant Settings --"] = "-- 巨人設定 --",
    ["Toggle 7x Giant Movement"] = "巨人移動距離7倍",
    ["Toggle 7x Movement Speed"] = "移動速度7倍",
    ["Double Giant Spacing"] = "2体の間隔",
    ["Double Spacing"] = "2体の間隔",
    ["-- Orbit_1(FireworkSparkler) --"] = "-- オービット1（FireworkSparkler） --",
    ["Firework Orbit"] = "Fireworkオービット",
    ["Spin Y Position"] = "回転Y位置",
    ["Firework Radius"] = "Firework半径",
    ["Spin Speed"] = "回転速度",
    ["-- Orbit_2(Spotlight) --"] = "-- オービット2（Spotlight） --",
    ["Spotlight Types"] = "Spotlight種類",
    ["Spotlight Orbit"] = "Spotlightオービット",
    ["Spotlight Radius"] = "Spotlight半径",
    ["-- Modifiers --"] = "-- モディファイア --",
    ["Toggle Headless"] = "Headless切替",
    ["Toggle Korblox leg"] = "Korblox脚切替",
    ["-- STAFF ROLL --"] = "-- スタッフロール --",
    ["Library / Design: midori"] = "ライブラリ／デザイン: midori",
    ["Toy-based giant body tracking rebuild"] = "Toyを使用した巨人ボディ追従の再構築",
    ["PLOT Tab Reference"] = "PLOTタブ参照",
    ["-- omake! --"] = "-- おまけ！ --",
    ["thx 4 useing this script"] = "このスクリプトを使ってくれてありがとう",
    ["Click"] = "実行",
    ["Selected"] = "選択中",
    ["NO"] = "いいえ",
    ["ON"] = "ON",
    ["OFF"] = "OFF",
    ["BUILD ERROR"] = "ビルドエラー",
    ["GIANT BUILT"] = "巨人構築完了",
    ["PLOT AUTO-SELECTED"] = "PLOT自動選択",
    ["PLOT OWNER ERROR"] = "PLOT所有者エラー",
    ["FOLDER SELECTED"] = "フォルダ選択完了",
    ["CLEANUP"] = "クリーンアップ",
    ["GIANT MODE"] = "巨人モード",
    ["FIREWORK ERROR"] = "FIREWORKエラー",
    ["SPOTLIGHT ERROR"] = "SPOTLIGHTエラー",
    ["KORBLOX LEG ERROR"] = "KORBLOX脚エラー",
    ["LOAD ERROR"] = "読み込みエラー",
    ["Console"] = "コンソール",
    ["FIREWORK"] = "花火",
    ["SPOTLIGHT"] = "スポットライト",
    ["Success"] = "成功",
    ["Error"] = "エラー",
    ["error"] = "エラー",
    ["Enabled"] = "有効",
    ["Disabled"] = "無効",
    ["Enabled Crazy hamburger"] = "有効（Crazy hamburger）",
    ["IsHeld was not found."] = "IsHeldが見つかりません。",
    ["Required fire parts were not found."] = "必要な炎関連パーツが見つかりません。",
    ["Ragdolled was not found."] = "Ragdolledが見つかりません。",
    ["Character was not ready."] = "キャラクターの準備ができていません。",
    ["NinjaKunai could not be purchased."] = "NinjaKunaiを購入できませんでした。",
    ["CharacterAndBeamMove was not found."] = "CharacterAndBeamMoveが見つかりません。",
    ["Ten Defense features loaded."] = "10個の防御機能を読み込みました。",
    ["GUCCI Anti Grab was cancelled."] = "旧Gucci Anti Grabをキャンセルしました。",
    ["Humanoid or HumanoidRootPart was not found."] = "HumanoidまたはHumanoidRootPartが見つかりません。",
    ["CreatureBlobman could not be spawned."] = "CreatureBlobmanを召喚できませんでした。",
    ["GrabbableHitbox was not found."] = "GrabbableHitboxが見つかりません。",
    ["Activation failed."] = "有効化に失敗しました。",
    ["speed, gravity, and jump power enabled"] = "速度・重力・ジャンプ力の変更を有効にしました",
    ["original speed, gravity, and jump restored"] = "速度・重力・ジャンプ力を元に戻しました",
    ["auto save progress reset; restarting"] = "オートセーブの進行度をリセットして再開します",
    ["get out this house"] = "家の外へ移動してください",
    ["unknown number response"] = "不明な応答です",
    ["unknown error"] = "不明なエラーです",
    ["saved"] = "保存しました",
    ["try again later"] = "時間をおいて再試行してください",
    ["are you sure?"] = "確認してください",
    ["...uhmm I think you already have gamepass"] = "すでにゲームパスを所有している可能性があります",
    ["owned movers removed and collisions restored"] = "所有Moverを削除し、衝突設定を復元しました",
    ["animation off; parked underground"] = "アニメーションOFF。地下へ待機させました",
    ["selection changed; animation restarted"] = "選択を変更し、アニメーションを再開しました",
    ["selection changed; parked underground"] = "選択を変更し、地下へ待機させました",
    ["Bad Apple"] = "Bad Apple",
    ["0 s error exist"] = "エラーは0件です",
    ["LANGUAGE"] = "言語",
    ["Japanese UI selected"] = "日本語UIを選択しました",
    ["English UI selected"] = "英語UIを選択しました",
    ["build Toys"] = "トイを構築",
    ["Build Toys Required Parts"] = "Build Toys必要パーツ",
    ["Other Toys Required Parts"] = "その他のトイの必要パーツ",
    ["Swap Boards (Giant 1 brown / Giant 2 TwoLegs)"] = "ボード入れ替え（巨人1=茶 / 巨人2=TwoLegs）",
    ["TOYS BUILT"] = "トイ構築完了",
    [ [[build Toys applies everything at once and always sets up two giants
Body: TableWoodTwoLegs or TableWoodFourLegsBrown x44 (22 per giant)
  Left Arm x4 / Right Arm x4 / Left Leg x4 / Right Leg x4 / Torso x6
  Normal mode with only 22 to 43 boards still builds one giant
Head: GlassBoxGray x2 when Headless is OFF
Korblox: TetracubeI x2 when Korblox leg is ON]] ] = [[build Toysは全てのトイを一度に適用し、常に巨人2体分を構築します
体: TableWoodTwoLegs または TableWoodFourLegsBrown x44（巨人1体につき22）
  左腕 x4 / 右腕 x4 / 左脚 x4 / 右脚 x4 / 胴体 x6
  板が22〜43枚のNormalでも巨人1体は構築されます
頭: ヘッドレスOFFのときGlassBoxGray x2
Korblox: Korblox脚ONのときTetracubeI x2]],
    [ [[Prepared by build Toys and kept under the map until used
FireworkSparkler: at least x1
Spotlight: SpotlightBlue / Green / Red / White (any amount)
Sword: PalletLightBrown x5 per sword (x10 for two swords)]] ] = [[build Toysが準備し、使うまで地下で待機します
FireworkSparkler: 1個以上
Spotlight: SpotlightBlue / Green / Red / White（数は問いません）
ソード: 1本につきPalletLightBrown x5（2本ならx10）]],
    ["Brown Boards (FourLegsBrown)"] = "茶色の板（FourLegsBrown）",
    ["BROWN BOARDS"] = "茶色の板",
    ["selection saved; build the giant again to apply it"] = "選択を保存しました。反映するには巨人をもう一度組み立ててください",
    ["Firework Wings"] = "Fireworkの翼",
    ["-- Firework Wings --"] = "-- Fireworkの翼 --",
    ["FIREWORK WINGS"] = "Firework翼",
    ["wings off; parked underground"] = "翼をしまいました（地下待機）",
    ["-- wait / assemble --"] = "-- 待機・組み立て --",
    ["Orbit Parts While Waiting"] = "待機中のパーツを頭上で周回",
    ["Tween Assemble (0.5s steps)"] = "Tween組み立て（0.5秒ごと）",
    ["-- Antis --"] = "-- アンチ --",
    ["-- Miscellaneous --"] = "-- その他 --",
    ["-- Config --"] = "-- 設定 --",
    ["-- Anti Net-Owner --"] = "-- アンチ ネットワークオーナー --",
    ["-- Anti-Grabs --"] = "-- アンチグラブ --",
    ["-- Anti-Kick --"] = "-- アンチキック --",
    ["-- Auto Reset --"] = "-- 自動リセット --",
    ["Anti Grab"] = "アンチグラブ",
    ["[GUCCI] Anti Grab"] = "[GUCCI] アンチグラブ",
    ["Anti Blobman"] = "アンチBlobman",
    ["Anti Network Ownership"] = "アンチネットワークオーナーシップ",
    ["Anti Explosion"] = "アンチ爆発",
    ["Anti Burn"] = "アンチ炎上",
    ["Anti Void"] = "アンチVoid",
    ["Anti Kick"] = "アンチキック",
    ["[Break PCLD] Anti Kick"] = "[PCLD破壊] アンチキック",
    ["Anti Sticky"] = "アンチ粘着",
    ["Anti Snowball"] = "アンチ雪玉",
    ["Anti Banana"] = "アンチバナナ",
    ["Anti Paint"] = "アンチペイント",
    ["Anti Poison"] = "アンチ毒",
    ["Anti Lag"] = "アンチラグ",
    ["Auto Anti Lag"] = "自動アンチラグ",
    ["Anti Invis"] = "アンチ透明化",
    ["Auto Reset"] = "自動リセット",
    ["Loop TP"] = "ループTP",
    ["Disable Void"] = "Void無効化",
    ["Water Walk"] = "水上歩行",
    ["Noclip Barrier"] = "バリアすり抜け",
    ["Anti-Fling [Objects Noclip]"] = "アンチフリング［物体すり抜け］",
    ["Auto Leave"] = "自動退出",
    ["Highlight"] = "ハイライト",
    ["Auto Anti-Lag Sensitivity (FPS)"] = "自動アンチラグ感度（FPS）",
    ["Grab & Drop Delay (sec) x100"] = "掴み＆落とし遅延（秒） x100",
    ["Item Transparency x100"] = "アイテム透明度 x100",
    ["Fill Transparency x100"] = "塗り透明度 x100",
    ["Outline Transparency x100"] = "輪郭透明度 x100",
    ["Shuriken Transparency x100"] = "手裏剣透明度 x100",
    ["Anti-Grab Type"] = "アンチグラブの種類",
    ["GUCCI Type"] = "GUCCIの種類",
    ["Type"] = "種類",
    ["Fill Color"] = "塗りの色",
    ["Outline Color"] = "輪郭の色",
    ["Below 0.05 can cause high ping"] = "0.05未満は高Pingの原因になります",
    ["Last person who grabbed you: nobody"] = "最後にあなたを掴んだ人: なし",
    ["Defense engine ready"] = "ディフェンスエンジン準備完了",
    ["Defense engine is still starting (waiting for game objects)"] = "ディフェンスエンジンを起動中です（ゲーム内オブジェクト待ち）",
    ["SWORD"] = "ソード",
    ["-- sword build --"] = "-- ソード構築 --",
    ["Sword Required Parts"] = "ソード必要パーツ",
    ["PalletLightBrown x5 per sword (SoundPart 11.5, 1.5, 11.5); Double mode needs x10 for two swords"] = "ソード1本につきPalletLightBrown x5（SoundPart 11.5, 1.5, 11.5）。Doubleは2本分でx10必要です",
    ["10 PalletLightBrown boards joined into two long blades; they follow both giants while Be Giant is ON"] = "PalletLightBrown 10枚を2本の長い板にしました。巨人化ONの間、2体の巨人に追従します",
    ["build sword"] = "ソードを構築",
    ["cleanup sword"] = "ソードをクリーンアップ",
    ["-- sword mount --"] = "-- ソード取り付け位置 --",
    ["Show Sword Switch UI"] = "ソード切替UIを表示",
    ["Sword on Arm Tip (OFF: Back)"] = "ソードを腕先に配置（OFF: 背中）",
    ["-- Sword Offset (Back) --"] = "-- ソード配置（背中） --",
    ["-- Sword Offset (Arm Tip) --"] = "-- ソード配置（腕先） --",
    ["Sword Pos X"] = "ソード位置X",
    ["Sword Pos Y"] = "ソード位置Y",
    ["Sword Pos Z"] = "ソード位置Z",
    ["Sword Angle X"] = "ソード角度X",
    ["Sword Angle Y"] = "ソード角度Y",
    ["Sword Angle Z"] = "ソード角度Z",
    ["Sword Pos X Value"] = "ソード位置X 値",
    ["Sword Pos Y Value"] = "ソード位置Y 値",
    ["Sword Pos Z Value"] = "ソード位置Z 値",
    ["Sword Angle X Value"] = "ソード角度X 値",
    ["Sword Angle Y Value"] = "ソード角度Y 値",
    ["Sword Angle Z Value"] = "ソード角度Z 値",
    ["reset sword transform"] = "配置をリセット",
    ["SWORD ERROR"] = "ソードエラー",
    ["SWORD BUILT"] = "ソード構築完了",
    ["SWORD CLEANUP"] = "ソードクリーンアップ",
    ["SWORD MODE"] = "ソードモード",
    ["SWORD RESET"] = "ソードリセット",
    ["SWORD UI"] = "ソード切替UI",
    ["Arm tip selected"] = "腕先を選択しました",
    ["Back selected"] = "背中を選択しました",
    ["5 PalletLightBrown boards joined into one long blade; they follow the giant while Be Giant is ON"] = "PalletLightBrown 5枚を1本の長い板にしました。巨人化ONの間、巨人に追従します",
    ["sword movers removed and original state restored"] = "ソードのMoverを削除し、元の状態に戻しました",
    ["sword was not built"] = "ソードは構築されていません",
    ["transform reset to default"] = "現在の配置を初期値に戻しました",
    ["Sword switch UI shown"] = "ソード切替UIを表示しました",
    ["Sword switch UI hidden"] = "ソード切替UIを非表示にしました",
    ["Item: 0=NOT_FOUND | partial=ERROR | full=SUCCESS"] = "個別: 0=未検出 | 不足=エラー | 充足=成功",
    ["Overall: 0=ERROR | partial=ATTENTION | full=SUCCESS"] = "全体: 0=エラー | 不足=注意 | 充足=成功",
}

Window._FaptaFragmentTranslations = {
    { "Time Remaining: ", "残り時間: " },
    { "Coins Won: ", "獲得コイン: " },
    { "Plot Time: ", "Plot時間: " },
    { "Plot Owner:", "Plot所有者:" },
    { "Plot Members: ", "Plot人数: " },
    { "Spotlight Types", "Spotlight種類" },
    { "Source: ", "対象: " },
    { "Mode: ", "モード: " },
    { " | Built: ", " | 構築: " },
    { " | Be Giant: ", " | 巨人化: " },
    { "YES (", "はい（" },
    { " stored / ", " 保持 / " },
    { " active)", " 有効）" },
    { "Source Status: ", "対象状態: " },
    { "Overall Summary: ", "総合サマリー: " },
    { "Body Composition:", "身体構成:" },
    { "Body Overall: ", "身体総合: " },
    { "Orbit Materials:", "オービット素材:" },
    { "Orbit Overall: ", "オービット総合: " },
    { "Left Arm", "左腕" },
    { "Right Arm", "右腕" },
    { "Left Leg", "左脚" },
    { "Right Leg", "右脚" },
    { "Reserved Right-Leg Boards", "右脚用予備板" },
    { "Torso", "胴体" },
    { "Head (GlassBoxGray)", "頭部（GlassBoxGray）" },
    { "Firework State: ", "Firework状態: " },
    { "Spotlight State: ", "Spotlight状態: " },
    { " | controlled: ", " | 制御数: " },
    { " | invalid size: ", " | サイズ不一致: " },
    { " available [NOT_SELECTED]", " 個使用可能 [未選択]" },
    { "[NOT_SELECTED]", "[未選択]" },
    { "[NOT_FOUND]", "[未検出]" },
    { "[ATTENTION]", "[注意]" },
    { "[SUCCESS]", "[成功]" },
    { "[ERROR]", "[エラー]" },
    { "DISABLED", "無効" },
    { "Summary update failed: ", "サマリー更新に失敗しました: " },
    { "Selected folder is not found: ", "選択フォルダが見つかりません: " },
    {
        "No Plot1-Plot5 owner entry references ",
        "Plot1～5の所有者情報に次の名前がありません: ",
    },
    {
        ". Claim a plot before using Plot.",
        "。Plotを使用する前にPlotを取得してください。",
    },
    { "Owned ", "所有中の " },
    { " was found, but ", " は見つかりましたが、" },
    { " is missing", " がありません" },
    { " was not found", " が見つかりません" },
    {
        "Select at least one Spotlight type",
        "Spotlight種類を1つ以上選択してください",
    },
    {
        "No selected Spotlight objects were found in ",
        "選択したSpotlightが見つかりません: ",
    },
    { "No ", "対象なし: " },
    { " objects were found in ", " オブジェクトが見つかりません: " },
    { "attached movers to ", "Moverを適用しました: " },
    { " objects", " 個" },
    { "; animation on", "、アニメーションON" },
    {
        " selected; press Build Toys again",
        " を選択しました。Build Toysをもう一度押してください",
    },
    { " owned by ", "（所有者: " },
    {
        " selected; press Build Toys again",
        "）を選択しました。Build Toysをもう一度押してください",
    },
    { " selected", " を選択しました" },
    { " are required for ", " が必要です（モード: " },
    { "; found ", "）、検出数: " },
    { " are required; ", " が必要です。" },
    { " available", " 個使用可能" },
    { "mode ", "モード " },
    { " | folder ", " | フォルダ " },
    { " | giants ", " | 巨人数 " },
    { " | wood ", " | 木板 " },
    { " | active right-leg parts ", " | 使用中の右脚パーツ " },
    { " | head parts ", " | 頭部パーツ " },
    { "Normal", "通常" },
    { "Double", "2体" },
    { "Giant ", "巨人" },
    { " Giant ", " 巨人 " },
    { " Position --", " 位置 --" },
    { " Offset", " オフセット" },
    { " to ", "～" },
    { "Sword needs ", "ソードに必要: " },
    { "; wings on", "；翼をはばたかせます" },
    { "Last person who grabbed you: ", "最後にあなたを掴んだ人: " },
    { ", found ", "、検出数: " },
}

function Window:_FaptaEscapePattern(value)
    return tostring(value):gsub("([^%w])", "%%%1")
end

function Window:_FaptaTranslateText(value)
    local textValue = tostring(value or "")
    if self._FaptaLanguageState.Current ~= "Japanese" then
        return textValue
    end
    local exact = self._FaptaExactTranslations[textValue]
    if exact then
        return exact
    end
    textValue = textValue:gsub("%[(%d+) selected%]", "[%1選択]")
    for _, pair in ipairs(self._FaptaFragmentTranslations) do
        textValue = textValue:gsub(self:_FaptaEscapePattern(pair[1]), pair[2])
    end
    textValue = textValue:gsub("%[(%d+)選択%]", "[%1選択]")
    textValue = textValue:gsub("%[None%]", "[未選択]")
    return textValue
end

function Window:_FaptaIsLanguageControlText(value)
    local textValue = tostring(value or "")
    return textValue:find("Language / 言語", 1, true) ~= nil
        or textValue:find("English (Current)", 1, true) ~= nil
        or textValue:find("日本語", 1, true) ~= nil
end

function Window:_FaptaApplyTextObject(object)
    local state = self._FaptaLanguageState
    if not object or not object.Parent then
        return
    end
    local original = state.OriginalText[object]
    if original == nil then
        original = object.Text
        state.OriginalText[object] = original
    end
    local target = self:_FaptaIsLanguageControlText(original) and original
        or self:_FaptaTranslateText(original)
    if object.Text ~= target then
        local wasApplying = state.Applying
        state.Applying = true
        object.Text = target
        state.Applying = wasApplying
    end
    if object:IsA("TextBox") then
        local originalPlaceholder = state.OriginalPlaceholder[object]
        if originalPlaceholder == nil then
            originalPlaceholder = object.PlaceholderText
            state.OriginalPlaceholder[object] = originalPlaceholder
        end
        local placeholderTarget = self:_FaptaTranslateText(originalPlaceholder)
        if object.PlaceholderText ~= placeholderTarget then
            local wasApplying = state.Applying
            state.Applying = true
            object.PlaceholderText = placeholderTarget
            state.Applying = wasApplying
        end
    end
end

function Window:_FaptaTrackTextObject(object)
    if
        not object
        or not (object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox"))
        or self._FaptaLanguageState.Connections[object]
    then
        return
    end
    local state = self._FaptaLanguageState
    state.OriginalText[object] = object.Text
    state.Connections[object] = object:GetPropertyChangedSignal("Text"):Connect(function()
        if state.Applying or not object.Parent then
            return
        end
        state.OriginalText[object] = object.Text
        self:_FaptaApplyTextObject(object)
    end)
    if object:IsA("TextBox") then
        state.OriginalPlaceholder[object] = object.PlaceholderText
        state.PlaceholderConnections[object] = object
            :GetPropertyChangedSignal("PlaceholderText")
            :Connect(function()
                if state.Applying or not object.Parent then
                    return
                end
                state.OriginalPlaceholder[object] = object.PlaceholderText
                self:_FaptaApplyTextObject(object)
            end)
    end
    self:_FaptaApplyTextObject(object)
end

function Window:_FaptaRefreshLanguageUI()
    for _, object in ipairs(self._ScreenGui:GetDescendants()) do
        self:_FaptaTrackTextObject(object)
        if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
            self:_FaptaApplyTextObject(object)
        end
    end
    if self._FaptaBuildSummary then
        self._FaptaBuildSummary:Refresh()
    end
end

function Window:_FaptaSetLanguage(language)
    self._FaptaLanguageState.Current = language == "Japanese" and "Japanese" or "English"
    self:_FaptaRefreshLanguageUI()
end

Window._FaptaOriginalNotify = Window.Notify
function Window:Notify(title, message, duration)
    return self._FaptaOriginalNotify(
        self,
        self:_FaptaTranslateText(title),
        self:_FaptaTranslateText(message),
        duration
    )
end

Window._FaptaLanguageState.DescendantConnection = Window._ScreenGui.DescendantAdded:Connect(
    function(object)
        task.defer(function()
            if object and object.Parent then
                Window:_FaptaTrackTextObject(object)
            end
        end)
    end
)
Window:_FaptaRefreshLanguageUI()
-- Player reference and immutable giant assembly configuration
local LP = Players.LocalPlayer
local TOY_NAME = "TableWoodTwoLegs"
local HEAD_TOY_NAME = "GlassBoxGray"
local KORBLOX_LEG_TOY_NAME = "TetracubeI"
-- Board styles: TableWoodTwoLegs and TableWoodFourLegsBrown have the same size, so only the model
-- name differs. Giant 1 starts with TwoLegs, giant 2 with brown; the dropdown flips a body part.
Window._FaptaWoodStyle = {
    BrownName = "TableWoodFourLegsBrown",
    Options = { "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" },
    Selected = {},
    -- Every attached board, by style. A board is "in use" while it is part of a giant.
    Pool = { Two = {}, Brown = {} },
    SpareSlotBase = 300,
}
-- Prepared toys that are not part of the giants (filled by "build Toys").
Window._FaptaToys = { SpotlightPool = {} }
local TOY_SIZE = Vector3.new(13.75, 7, 0.375)
local KORBLOX_LEG_SIZE = Vector3.new(1.75, 7, 1.75)
local LIMB_ASSEMBLY_SIZE = Vector3.new(13.75, 7, 7)
local TORSO_ASSEMBLY_SIZE = Vector3.new(13.75, 14, 7)
local POSITION_SCALE = 7
local SIZE_TOLERANCE = 0.03
local TOY_ROTATION_OFFSET = CFrame.Angles(math.rad(180), 0, 0)
local WAIT_POS_Y = -75
-- Orbit-wait and tween-assemble state (SETTING tab); kept in one table to save locals.
Window._FaptaWait = {
    Orbit = false,
    Assemble = false,
    AssembleStart = nil,
    OrbitHeight = 25,
    OrbitRadius = 35,
    WaveHeight = 5,
    WaveCycles = 3,
    OrbitPeriod = 12,
    StepTime = 0.5,
    AllParts = {},
    OrbitCount = 1,
    Center = Vector3.zero,
    FaceOffset = CFrame.new(),
    ReleaseTime = 0.7,
    ReleaseStart = nil,
    GiantTorsoCF = nil,
}
-- Firework Wings state (OTHERS tab).
Window._FaptaWings = {
    Enabled = false,
    Busy = false,
    Toys = {},
    Toggle = nil,
    FlapHz = 1.4,
    FlapAmplitude = math.rad(40),
    BaseAngle = math.rad(25),
    FeatherLag = 0.18,
    Spacing = 2,
    GiantScale = 7,
}
-- Sword state lives in one table so the main chunk gains no extra top-level locals.
Window._FaptaSword = {
    ToyName = "PalletLightBrown",
    PartSize = Vector3.new(11.5, 1.5, 11.5),
    PartCount = 5,
    WaitSlotBase = 129,
    Sets = {},
    ArmMode = false,
    Anims = {},
    ReachTime = 0.28,
    HoldTime = 0.05,
    PullOutTime = 0.12,
    SwingTime = 0.3,
    PullDistance = 14,
    ReachArc = { Up = 8, Forward = -3 },
    SwingArc = { Up = 12, Forward = 6 },
    Defaults = {
        Back = { Position = Vector3.new(0, 0, 5), Angle = Vector3.new(90, 0, 45) },
        Arm = { Position = Vector3.new(0, 0, -25), Angle = Vector3.new(0, -90, 0) },
    },
    Profiles = {
        Back = { Position = Vector3.new(0, 0, 5), Angle = Vector3.new(90, 0, 45) },
        Arm = { Position = Vector3.new(0, 0, -25), Angle = Vector3.new(0, -90, 0) },
    },
}
-- Runtime state for giant parts, orbiting props, auto-save, and movement
local GiantAssemblies = {}
local FireworkSparklers = {}
local Spotlights = {}
local FireworkOrbitAnchor = nil
local SpotlightOrbitAnchor = nil
local CollisionState = {}
local CollisionRecorded = {}
local isBuilt = false
local isTracing = false
local giantMode = "Normal"
local giantSpacing = 50
local giantOffsets = {
    Vector3.zero,
    Vector3.zero,
}
local headlessEnabled = false
local korbloxLegEnabled = false
local giantMovementScaleEnabled = true
local fireworkSpinEnabled = false
local fireworkSpinAngle = 0
local spotlightSpinEnabled = false
local spotlightSpinAngle = 0
local spotlightFacingSession = 0
local spotlightFacingIndex = 1
local autoSaveRunning = false
local autoSaveSession = 0
local autoSaveThread = nil
local autoSaveActiveState = nil
local tpWalkEnabled = false
local tpWalkOriginalGravity = nil
local tpWalkCharacterState = nil
local tpWalkHeartbeatConnection = nil
local tpWalkCharacterAddedConnection = nil
local TORSO_TRACE_Y_OFFSET = 17.875
local GIANT_MODE_OPTIONS = { "Normal", "Double" }
local GIANT_SPACING_MIN = 20
local GIANT_SPACING_MAX = 120
local GIANT_OFFSET_MIN = -100
local GIANT_OFFSET_MAX = 100
local WAIT_SLOT_SPACING = 16
local WAIT_SLOT_COLUMNS = 8
local FIREWORK_TOY_NAME = "FireworkSparkler"
local FIREWORK_SOURCE_ROTATION_OFFSET = CFrame.Angles(math.rad(90), 0, math.rad(90))
local SPOTLIGHT_OPTIONS = {
    "SpotlightBlue",
    "SpotlightGreen",
    "SpotlightRed",
    "SpotlightWhite",
}
local selectedSpotlightNames = table.clone(SPOTLIGHT_OPTIONS)
local BACK_SPIN_DISTANCE = 8
local backSpinVerticalOffset = 13
local fireworkOrbitRadius = 10
local spotlightOrbitRadius = 20
local backSpinRotationSpeed = 100
local FIREWORK_FOLLOW_RESPONSIVENESS = 8
local SPOTLIGHT_FOLLOW_RESPONSIVENESS = 6
local SPOTLIGHT_FACING_RANDOM = Random.new()
local FOLDER_OPTIONS = { "SpawnedInToys", "Plot" }
local selectedFolderOption = "SpawnedInToys"

-- Build a live inventory summary for the selected giant and orbit source.
Window._FaptaBuildSummary = {
    Paragraph = nil,
    RefreshSession = 0,
}

local Util = {} -- shared helpers (defined at the start of the logic section)

-- ============================================================================
-- FORWARD DECLARATIONS
-- Logic functions and state that the UI callbacks below call. They are assigned in the logic
-- section further down (same names, declared once, so the local count does not change).
-- ============================================================================
local rotationOnly, cleanupGiant, findKorbloxLegCandidates, makeKorbloxLegData, assignKorbloxLegLayout, moveToWaitPosition, moveHeadToWaitPosition, moveRightLegGroupsToWaitPosition
local resolveSelectedFolder, getSelectedFolderError, getBackOrbitTargetCF, restoreFireworkSparklers, restoreSpotlights, normalizeSpotlightSelection, applyFireworkSparklers, applySpotlights
local updateFireworkSpin, updateSpotlightSpin, buildGiant, tracePlayer, refreshGiantAssemblyPlacement, runAutoSave, setTPWalkEnabled, AutoSNOWship
local GetAutoSlotEntries, AreAllSlotLightsNeon, SaveAutoPosition, RestoreAutoPosition, TrackRemainingTime, AutoPlotRefreshValue

-- ============================================================================
-- UI CREATION
-- Every tab and control is created here; callbacks use the logic defined below.
-- ============================================================================

-- DEFENSE tab: ported from the supplied Resonance "Invincibility" tab (Counter-attack not included).
-- Part 1 (this statement) builds every control immediately, so the tab always shows. Part 2
-- loads the ported defense engine in its own thread and attaches it to those controls. A compile error, a runtime error, or a long wait for game objects therefore
-- affects only the defense engine and never the rest of the script.
;(function()
    local SPEC = {
        { "section", "Antis" },
        { "toggle", "AntiGrab", "Anti Grab", false },
        { "toggle", "GucciAntiGrab", "[GUCCI] Anti Grab", false },
        { "toggle", "AntiBlobman", "Anti Blobman", false },
        { "toggle", "AntiInputLag", "Anti Network Ownership", false },
        { "toggle", "AntiExplosion", "Anti Explosion", false },
        { "toggle", "AntiBurn", "Anti Burn", false },
        { "toggle", "AntiVoid", "Anti Void", false },
        { "toggle", "AntiKick", "Anti Kick", false },
        { "toggle", "AntiKick2", "[Break PCLD] Anti Kick", false },
        { "toggle", "AntiSticky", "Anti Sticky", false },
        { "toggle", "AntiSnowball", "Anti Snowball", false },
        { "toggle", "AntiBanana", "Anti Banana", false },
        { "toggle", "AntiPaint", "Anti Paint", false },
        { "toggle", "AntiPoison", "Anti Poison", false },
        { "toggle", "AntiLag", "Anti Lag", false },
        { "toggle", "AutoAntiLag", "Auto Anti Lag", true },
        { "toggle", "AntiInvis", "Anti Invis", false },
        { "toggle", "AutoReset", "Auto Reset", true },
        { "toggle", "LoopTP", "Loop TP", false },
        { "section", "Miscellaneous" },
        { "toggle", "DisblVoid", "Disable Void", true },
        { "toggle", "WaterWalk", "Water Walk", false },
        { "toggle", "DeleteBarriers", "Noclip Barrier", false },
        { "toggle", "OtherInvCollisions", "Anti-Fling [Objects Noclip]", false },
        { "label", "LastGrabbedLabel", "Last person who grabbed you: nobody" },
        { "section", "Config" },
        { "slider", "AntiLagSens", "Auto Anti-Lag Sensitivity (FPS)", 3, 1, 20, 1 },
        { "section", "Auto Reset" },
        { "toggle", "AutoLeave", "Auto Leave", true },
        { "section", "Anti-Grabs" },
        { "dropdown", "AGTDropdown", "Anti-Grab Type", { "Normal", "No Ragdoll", "Anti-Kill", "Escapes Anything, but buggy" }, 1 },
        { "dropdown", "GTDropdown", "GUCCI Type", { "Blobman", "Tractor [Invisible]", "Train [Invisible]", "Sleigh [Invisible]" }, 1 },
        { "section", "Anti Net-Owner" },
        { "dropdown", "AITDropdown", "Type", { "FoodHamburger", "InstrumentDrumBongos", "InstrumentBrassTrumpet", "InstrumentBrassBugle", "InstrumentVoiceMicrophone", "InstrumentWoodwindOcarina", "InstrumentGuitarUkulele", "InstrumentGuitarLyre", "InstrumentGuitarBanjo", "InstrumentGuitarAcoustic", "CupMugBrown", "CupMugWhite", "FoodBanana", "FoodBread", "FoodBroccoli", "FoodCakePink", "FoodCoconut", "FoodDippyEgg", "FoodDonut", "FoodFrenchFries", "FoodHotdog", "FoodMayonnaise", "FoodMeatStick", "FoodMushroomPoison", "FoodPizzaCheese", "FoodPizzaPepperoni", "FoodSodaCan", "PoopPile", "PoopPileSparkle" }, 1 },
        { "slider", "AntiInpLagDel", "Grab & Drop Delay (sec) x100", 0.05, 0, 30, 100 },
        { "label", nil, "Below 0.05 can cause high ping" },
        { "slider", "ItemTransAK", "Item Transparency x100", 1, 0, 100, 100 },
        { "section", "Anti-Kick" },
        { "toggle", "AntiKickHL", "Highlight", false },
        { "color", "AKFill", "Fill Color", Color3.new(1, 0, 0) },
        { "color", "AKOutline", "Outline Color", Color3.new(1, 1, 1) },
        { "slider", "FillTransAK", "Fill Transparency x100", 0.5, 0, 100, 100 },
        { "slider", "OutlTransAK", "Outline Transparency x100", 0, 0, 100, 100 },
        { "slider", "ShurTransAK", "Shuriken Transparency x100", 0.9, 0, 100, 100 },
    }
    local controls = { Toggles = {}, Options = {}, Labels = {} }
    for _, item in ipairs(SPEC) do
        local kind = item[1]
        if kind == "section" then
            DefenseTab:AddSection("-- " .. item[2] .. " --")
        elseif kind == "toggle" then
            local entry = { Value = item[4] }
            local component = DefenseTab:AddToggle(item[3], item[4], function(value)
                entry.Value = value
                if entry.Callback then
                    entry.Callback(value)
                end
            end)
            entry.SetValue = function(_, value)
                component:Set(value == true)
            end
            controls.Toggles[item[2]] = entry
        elseif kind == "slider" then
            local scale = item[7]
            local entry = { Value = item[4] }
            local component = DefenseTab:AddSlider(item[3], {
                Min = item[5],
                Max = item[6],
                Default = math.floor(item[4] * scale + 0.5),
            }, function(value)
                entry.Value = value / scale
                if entry.Callback then
                    entry.Callback(entry.Value)
                end
            end)
            entry.SetValue = function(_, value)
                component:Set(math.floor(value * scale + 0.5))
            end
            controls.Options[item[2]] = entry
        elseif kind == "dropdown" then
            local entry = { Value = item[4][item[5]], Values = item[4] }
            local component = DefenseTab:AddDropdown(item[3], item[4], function(value)
                entry.Value = value
                if entry.Callback then
                    entry.Callback(value)
                end
            end)
            entry.SetValue = function(_, value)
                component:Set(value)
            end
            controls.Options[item[2]] = entry
            component:Set(entry.Value)
        elseif kind == "label" then
            local component = DefenseTab:AddLabel(item[3])
            local entry = {
                SetText = function(_, text)
                    component:Set(tostring(text))
                end,
                SetVisible = function(_, visible)
                    component:SetVisible(visible)
                end,
            }
            if item[2] then
                controls.Labels[item[2]] = entry
            end
        elseif kind == "color" then
            local entry = { Value = item[4] }
            local component = DefenseTab:AddColorPicker({
                Name = item[3],
                Default = item[4],
                Callback = function(color)
                    entry.Value = color
                    if entry.Callback then
                        entry.Callback(color)
                    end
                end,
            })
            entry.SetValue = function(_, color)
                component:Set(color)
            end
            controls.Options[item[2]] = entry
        end
    end

    Window._FaptaDefenseControls = controls
end)()

-- Auto coin farming
AutoTab:AddSection("-- Auto Get Coins --")

local TimeRemainingLabel
local CoinsWonLabel
local TimeInHouseLabel
local PlotOwner
local PlayersInPlot

AutoTab:AddToggle("Auto-Spin", false, function(enabled)
    _G.AutoFarmCoins = enabled
    if enabled then
        while _G.AutoFarmCoins do
            if AreAllSlotLightsNeon() and ChangeActivityPriority(5) then
                SaveAutoPosition("Spin")

                local activeHandle = nil
                local autoSpinTask = task.spawn(function()
                    while true do
                        if activeHandle then
                            TeleportPlayer(activeHandle.CFrame + Vector3.new(0, 5, 0), 5)
                            task.wait(0.2)
                            AutoSNOWship(activeHandle)
                        end
                        task.wait()
                    end
                end)

                local success, err = pcall(function()
                    for _, entry in ipairs(GetAutoSlotEntries()) do
                        activeHandle = entry.Handle
                        activeHandle.CanCollide = false
                        local currentHandle = activeHandle
                        for _ = 1, 5 do
                            task.wait(0.2)
                        end
                        if currentHandle.Parent then
                            currentHandle.CanCollide = true
                        end
                        if not AreAllSlotLightsNeon() then
                            break
                        end
                    end
                end)

                if autoSpinTask then
                    task.cancel(autoSpinTask)
                end
                if activeHandle and activeHandle.Parent then
                    activeHandle.CanCollide = true
                end
                ChangeActivityPriority(0)
                RestoreAutoPosition("Spin")
                if not success then
                    warn("[fapta] Auto-Spin failed:", err)
                end
                newtask = nil
            end
            task.wait(5)
        end
    end
end)

TimeRemainingLabel = AutoTab:AddLabel("Time Remaining: 0:00")
CoinsWonLabel = AutoTab:AddLabel("Coins Won: 0")

-- Preserve plot time by occupying PlotArea until the timer reaches 90
AutoTab:AddSection("-- Auto Time-Reset --")

local PreserveTimeToggle
PreserveTimeToggle = AutoTab:AddToggle("Preserve Time", false, function(enabled)
    _G.AutoSaveHouseTime = enabled
    if enabled then
        TrackRemainingTime()
        while _G.AutoSaveHouseTime do
            local infiniteHouseTime = LP:FindFirstChild("InfiniteHouseTime")
            if infiniteHouseTime and infiniteHouseTime.Value then
                PreserveTimeToggle:Set(false)
                Window:Notify("are you sure?", "...uhmm I think you already have gamepass", 5)
                break
            end

            local remainingTime = _G.RemainingTimeInHouse
            if
                typeof(remainingTime) ~= "Instance" or not remainingTime:IsDescendantOf(Workspace)
            then
                TrackRemainingTime()
                remainingTime = _G.RemainingTimeInHouse
            end
            if
                typeof(remainingTime) == "Instance"
                and remainingTime:IsDescendantOf(Workspace)
                and remainingTime:IsA("IntValue")
            then
                local ownerValue = remainingTime.Parent
                local owners = ownerValue and ownerValue.Parent
                local plotSign = owners and owners.Parent
                local plotModel = plotSign and plotSign.Parent
                local plotArea = plotModel and plotModel:FindFirstChild("PlotArea")
                if plotArea and remainingTime.Value < 20 and ChangeActivityPriority(4) then
                    local character = LP.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    local success = true
                    local err = nil
                    if root then
                        local oldCFrame = root.CFrame
                        success, err = pcall(function()
                            local activeRemainingTime = remainingTime
                            local activePlotArea = plotArea
                            repeat
                                if
                                    typeof(activeRemainingTime) ~= "Instance"
                                    or not activeRemainingTime:IsDescendantOf(Workspace)
                                then
                                    TrackRemainingTime()
                                    activeRemainingTime = _G.RemainingTimeInHouse
                                end
                                if
                                    typeof(activeRemainingTime) == "Instance"
                                    and activeRemainingTime:IsDescendantOf(Workspace)
                                then
                                    local activeOwnerValue = activeRemainingTime.Parent
                                    local activeOwners = activeOwnerValue
                                        and activeOwnerValue.Parent
                                    local activePlotSign = activeOwners and activeOwners.Parent
                                    local activePlotModel = activePlotSign and activePlotSign.Parent
                                    activePlotArea = activePlotModel
                                        and activePlotModel:FindFirstChild("PlotArea")
                                end
                                if not root.Parent then
                                    break
                                end
                                if activePlotArea and activePlotArea.Parent then
                                    root.CFrame = CFrame.new(activePlotArea.Position)
                                end
                                RunService.Heartbeat:Wait()
                            until not _G.AutoSaveHouseTime
                                or (
                                    typeof(activeRemainingTime) == "Instance"
                                    and activeRemainingTime:IsDescendantOf(Workspace)
                                    and activeRemainingTime.Value >= 90
                                )
                        end)
                        if root.Parent then
                            root.CFrame = oldCFrame
                        end
                    else
                        success = false
                        err = "HumanoidRootPart not found"
                    end
                    ChangeActivityPriority(0)
                    if not success then
                        warn("[fapta] Preserve Time failed:", err)
                    end
                end
            end
            task.wait(2)
        end
    end
end)

TimeInHouseLabel = AutoTab:AddLabel("Plot Time: 0")

-- Plot claiming plus owner and player-count status
AutoTab:AddSection("-- Auto Claim-Plot --")

local AutoPlotDropdown = AutoTab:AddDropdown("Plot", {
    "Witch House",
    "Lumber House",
    "Common House",
    "American House",
    "Chinese House",
}, function(plotName)
    _G.PlotName = plotName
    AutoPlotRefreshValue.Value = AutoPlotRefreshValue.Value + 1
end)

PlotOwner = AutoTab:AddLabel("Plot Owner:")
PlayersInPlot = AutoTab:AddLabel("Plot Members: 0")

AutoTab:AddButton("Claim Plot", function()
    ClaimPlot()
end)

-- REANIMATE tab controls
ReanimateTab:AddSection("-- build --")
local GiantTraceToggle
local GiantModeDropdown
local FireworkSpinToggle
local SpotlightSpinToggle
local KorbloxLegToggle
local FolderDropdown
FolderDropdown = ReanimateTab:AddDropdown("Toy Type", FOLDER_OPTIONS, function(option)
    if option == selectedFolderOption then
        return
    end
    isTracing = false
    if GiantTraceToggle and GiantTraceToggle:Get() then
        GiantTraceToggle:Set(false)
    end
    Util.releaseSpinToysAndSword()
    selectedFolderOption = option
    if isBuilt then
        cleanupGiant()
    end
    if option == "Plot" then
        local folder, folderLabel = resolveSelectedFolder()
        if folder then
            Window:Notify(
                "PLOT AUTO-SELECTED",
                string.format("%s owned by %s selected; press Build Toys again", folderLabel, LP.Name),
                6
            )
        else
            Window:Notify("PLOT OWNER ERROR", folderLabel, 7)
        end
    else
        Window:Notify("FOLDER SELECTED", option .. " selected; press Build Toys again", 5)
    end
end)
ReanimateTab:AddButton("build Toys", function()
    Window._FaptaToys.Build()
end)
ReanimateTab:AddButton("cleanup", function()
    Util.releaseSpinToysAndSword()
    cleanupGiant()
    Window:Notify("CLEANUP", "owned movers removed and collisions restored", 4)
end)
Window._InfoTab:AddSection("-- live summary --")
Window._FaptaBuildSummary.Paragraph =
    Window._InfoTab:AddParagraph("Live Parts / Body Summary", "Scanning selected source...")
Window._InfoTab:AddButton("Refresh Summary", function()
    Window._FaptaBuildSummary:Refresh()
end)
Window._InfoTab:AddSection("-- required parts --")
Window._InfoTab:AddParagraph(
    "Build Toys Required Parts",
    [[build Toys applies everything at once and always sets up two giants
Body: TableWoodTwoLegs or TableWoodFourLegsBrown x44 (22 per giant)
  Left Arm x4 / Right Arm x4 / Left Leg x4 / Right Leg x4 / Torso x6
  Normal mode with only 22 to 43 boards still builds one giant
Head: GlassBoxGray x2 when Headless is OFF
Korblox: TetracubeI x2 when Korblox leg is ON]],
    { Id = "BuildToysRequiredPartsGuide" }
)
Window._InfoTab:AddParagraph(
    "Other Toys Required Parts",
    [[Prepared by build Toys and kept under the map until used
FireworkSparkler: at least x1
Spotlight: SpotlightBlue / Green / Red / White (any amount)
Sword: PalletLightBrown x5 per sword (x10 for two swords)]],
    { Id = "OtherToysRequiredPartsGuide" }
)
ReanimateTab:AddSection("-- trace --")
GiantModeDropdown = ReanimateTab:AddDropdown("Giant Mode", GIANT_MODE_OPTIONS, function(option)
    if option == giantMode then
        return
    end
    local previousMode = giantMode
    local wasBuilt = isBuilt
    local wasTracing = isTracing
    giantMode = option
    if wasBuilt then
        local needsSecondAssembly = option == "Double" and #GiantAssemblies < 2
        if needsSecondAssembly then
            local success = buildGiant()
            if not success then
                giantMode = previousMode
                local restored = buildGiant()
                isTracing = wasTracing and restored
                task.defer(function()
                    if GiantModeDropdown and GiantModeDropdown:Get() ~= previousMode then
                        GiantModeDropdown:Set(previousMode)
                    end
                end)
                return
            end
        end
        isTracing = wasTracing
        refreshGiantAssemblyPlacement()
    end
    Window:Notify("GIANT MODE", option .. " selected", 4)
end)
GiantTraceToggle = ReanimateTab:AddToggle("Be Giant", false, function(value)
    local wasTracing = isTracing
    isTracing = value
    if value and not wasTracing then
        -- With Tween Assemble on, the giant is built up step by step from here.
        Window._FaptaWait.BeginAssemble()
    elseif not value then
        Window._FaptaWait.CancelAssemble()
        -- The sword must not stay behind: it goes to its waiting spot at once, on every path
        -- (instant release, glide back, orbit wait).
        Window._FaptaSword.Park()
    end
    if not isTracing and isBuilt then
        if wasTracing and Window._FaptaWait.Assemble then
            -- Tween Assemble on: glide the parts back to their waiting spots.
            Window._FaptaWait.BeginRelease()
        else
            moveToWaitPosition()
        end
    end
end)
ReanimateTab:AddSection("-- super necessity --")
ReanimateTab:AddButton("BarrierBreak", function()
    runAutoSave()
end)

-- SWORD tab: controls, floating Back / Arm Tip switch UI and their glue code.
-- The sword logic itself (Sword.Build, Sword.Animate, ...) is defined in the logic section.
;(function()
    local Sword = Window._FaptaSword
    local SwordTab = Window._SwordTab
    local UserInputService = game:GetService("UserInputService")

    local POSITION_LIMIT = 100
    local ANGLE_LIMIT = 180
    local OFF_COLOR = Color3.fromRGB(220, 55, 55)
    local ON_COLOR = Color3.fromRGB(55, 190, 85)
    local DEFAULT_COLOR = Color3.fromRGB(163, 162, 165)
    local UI_TOTAL_WIDTH = 75
    local UI_TOTAL_HEIGHT = 50

    local SwordSliders = {}
    local SwordTextboxes = {}
    local controlSyncing = false
    local modeSyncing = false
    local ModeSectionLabel
    local ArmToggle
    local ShowUiToggle
    local SwitchGui
    local SwitchButton
    local SwitchEndDrag

    local CONTROL_DEFS = {
        { Key = "Position", Axis = "X", Name = "Sword Pos X", Limit = POSITION_LIMIT },
        { Key = "Position", Axis = "Y", Name = "Sword Pos Y", Limit = POSITION_LIMIT },
        { Key = "Position", Axis = "Z", Name = "Sword Pos Z", Limit = POSITION_LIMIT },
        { Key = "Angle", Axis = "X", Name = "Sword Angle X", Limit = ANGLE_LIMIT },
        { Key = "Angle", Axis = "Y", Name = "Sword Angle Y", Limit = ANGLE_LIMIT },
        { Key = "Angle", Axis = "Z", Name = "Sword Angle Z", Limit = ANGLE_LIMIT },
    }

    -- Profile helpers: Back and Arm Tip keep separate position / angle values.
    local function activeProfile()
        return Sword.ArmMode and Sword.Profiles.Arm or Sword.Profiles.Back
    end

    local function getControlValue(def)
        return activeProfile()[def.Key][def.Axis]
    end

    local function withAxis(vector, axis, value)
        return Vector3.new(
            axis == "X" and value or vector.X,
            axis == "Y" and value or vector.Y,
            axis == "Z" and value or vector.Z
        )
    end

    local function syncControls()
        controlSyncing = true
        for _, def in ipairs(CONTROL_DEFS) do
            local value = getControlValue(def)
            if SwordSliders[def.Name] then
                SwordSliders[def.Name]:Set(value)
            end
            if SwordTextboxes[def.Name] then
                SwordTextboxes[def.Name]:Set(tostring(value))
            end
        end
        if ModeSectionLabel then
            ModeSectionLabel:Set(
                Sword.ArmMode and "-- Sword Offset (Arm Tip) --" or "-- Sword Offset (Back) --"
            )
        end
        controlSyncing = false
    end

    local function setControlValue(def, value)
        if controlSyncing then
            return
        end
        local profile = activeProfile()
        local numericValue = tonumber(value)
        if not numericValue then
            numericValue = profile[def.Key][def.Axis]
        end
        numericValue = math.clamp(math.floor(numericValue + 0.5), -def.Limit, def.Limit)
        profile[def.Key] = withAxis(profile[def.Key], def.Axis, numericValue)
        controlSyncing = true
        if SwordSliders[def.Name] then
            SwordSliders[def.Name]:Set(numericValue)
        end
        if SwordTextboxes[def.Name] then
            SwordTextboxes[def.Name]:Set(tostring(numericValue))
        end
        controlSyncing = false
    end

    -- Back / Arm Tip switching shared by the HertaIX toggle and the floating UI button.
    local function updateSwitchButton()
        if SwitchButton then
            SwitchButton.BackgroundColor3 = Sword.ArmMode and ON_COLOR or OFF_COLOR
            SwitchButton.Text = Sword.ArmMode and "A" or "B"
        end
    end

    local function setArmMode(value)
        if modeSyncing then
            return
        end
        value = value == true
        modeSyncing = true
        if next(Sword.Anims) ~= nil and value ~= Sword.ArmMode then
            -- A draw / sheathe animation is running: ignore the request and restore the controls.
            if ArmToggle and ArmToggle:Get() ~= Sword.ArmMode then
                ArmToggle:Set(Sword.ArmMode)
            end
            modeSyncing = false
            return
        end
        local changed = value ~= Sword.ArmMode
        Sword.ArmMode = value
        if ArmToggle and ArmToggle:Get() ~= Sword.ArmMode then
            ArmToggle:Set(Sword.ArmMode)
        end
        updateSwitchButton()
        syncControls()
        modeSyncing = false
        if changed and isBuilt and isTracing and Sword.Sets[1] ~= nil then
            Sword.StartAnimation(value)
        end
        Window:Notify("SWORD MODE", Sword.ArmMode and "Arm tip selected" or "Back selected", 3)
    end

    -- Floating switch UI: B = Back (red), A = Arm Tip (green), x = hide, arrows = drag.
    local function createSwitchUi()
        local playerGui = LP:WaitForChild("PlayerGui")
        local gui = Instance.new("ScreenGui")
        gui.Name = "SwordSwitchUI"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.Enabled = false
        gui.Parent = playerGui

        local container = Instance.new("Frame")
        container.Name = "Container"
        container.Size = UDim2.fromOffset(UI_TOTAL_WIDTH, UI_TOTAL_HEIGHT)
        container.BackgroundTransparency = 1
        container.BorderSizePixel = 0
        container.Parent = gui

        local function makeButton(name, size, position, color, text)
            local button = Instance.new("TextButton")
            button.Name = name
            button.Size = UDim2.fromOffset(size.X, size.Y)
            button.Position = UDim2.fromOffset(position.X, position.Y)
            button.BackgroundColor3 = color
            button.BorderSizePixel = 0
            button.Text = text
            button.TextScaled = true
            button.TextColor3 = Color3.new(1, 1, 1)
            button.Font = Enum.Font.SourceSans
            button.Active = true
            button.Parent = container
            return button
        end

        local mainButton =
            makeButton("MainButton", Vector2.new(50, 50), Vector2.new(0, 0), OFF_COLOR, "B")
        local hideButton =
            makeButton("HideButton", Vector2.new(25, 25), Vector2.new(50, 0), OFF_COLOR, "×")
        local moveButton =
            makeButton("MoveButton", Vector2.new(25, 25), Vector2.new(50, 25), DEFAULT_COLOR, "↕")

        local function setUiPosition(x, y)
            local camera = workspace.CurrentCamera
            if not camera then
                return
            end
            local viewport = camera.ViewportSize
            x = math.clamp(x, 0, math.max(0, viewport.X - UI_TOTAL_WIDTH))
            y = math.clamp(y, 0, math.max(0, viewport.Y - UI_TOTAL_HEIGHT))
            container.Position = UDim2.fromOffset(x, y)
        end

        local function clampCurrentPosition()
            setUiPosition(container.Position.X.Offset, container.Position.Y.Offset)
        end

        local initialCamera = workspace.CurrentCamera
        if initialCamera then
            local viewport = initialCamera.ViewportSize
            setUiPosition((viewport.X - UI_TOTAL_WIDTH) / 2, (viewport.Y - UI_TOTAL_HEIGHT) / 2)
        end

        local function connectCamera(camera)
            if not camera then
                return
            end
            camera:GetPropertyChangedSignal("ViewportSize"):Connect(clampCurrentPosition)
            clampCurrentPosition()
        end
        workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
            connectCamera(workspace.CurrentCamera)
        end)
        connectCamera(workspace.CurrentCamera)

        -- Drag handling (touch and mouse) on the arrow button.
        local dragging = false
        local dragStart = nil
        local startPosition = nil
        local activeTouch = nil
        local activeMouse = false

        local function endDrag()
            dragging = false
            dragStart = nil
            startPosition = nil
            activeTouch = nil
            activeMouse = false
        end

        local function updateDrag(input)
            if not dragging then
                return
            end
            local current = Vector2.new(input.Position.X, input.Position.Y)
            local delta = current - dragStart
            setUiPosition(startPosition.X + delta.X, startPosition.Y + delta.Y)
        end

        moveButton.InputBegan:Connect(function(input)
            if dragging then
                return
            end
            if
                input.UserInputType ~= Enum.UserInputType.Touch
                and input.UserInputType ~= Enum.UserInputType.MouseButton1
            then
                return
            end
            dragging = true
            dragStart = Vector2.new(input.Position.X, input.Position.Y)
            startPosition =
                Vector2.new(container.Position.X.Offset, container.Position.Y.Offset)
            if input.UserInputType == Enum.UserInputType.Touch then
                activeTouch = input
            else
                activeMouse = true
            end
        end)

        UserInputService.TouchMoved:Connect(function(input)
            if dragging and activeTouch and input == activeTouch then
                updateDrag(input)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if
                dragging
                and activeMouse
                and input.UserInputType == Enum.UserInputType.MouseMovement
            then
                updateDrag(input)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if activeTouch and input == activeTouch then
                endDrag()
            elseif activeMouse and input.UserInputType == Enum.UserInputType.MouseButton1 then
                endDrag()
            end
        end)

        mainButton.Activated:Connect(function()
            setArmMode(not Sword.ArmMode)
        end)

        -- The x button only hides the UI; the HertaIX toggle shows it again.
        hideButton.Activated:Connect(function()
            if ShowUiToggle then
                ShowUiToggle:Set(false)
            else
                gui.Enabled = false
                endDrag()
            end
        end)

        return gui, mainButton, endDrag
    end

    SwitchGui, SwitchButton, SwitchEndDrag = createSwitchUi()
    updateSwitchButton()

    -- SWORD tab controls
    SwordTab:AddSection("-- sword build --")
    SwordTab:AddParagraph(
        "Sword Required Parts",
        "PalletLightBrown x5 per sword (SoundPart 11.5, 1.5, 11.5); Double mode needs x10 for two swords"
    )
    SwordTab:AddButton("build sword", function()
        Sword.Build()
    end)
    SwordTab:AddButton("cleanup sword", function()
        if Sword.Cleanup() then
            Window:Notify("SWORD CLEANUP", "sword movers removed and original state restored", 4)
        else
            Window:Notify("SWORD CLEANUP", "sword was not built", 3)
        end
    end)

    SwordTab:AddSection("-- sword mount --")
    ShowUiToggle = SwordTab:AddToggle("Show Sword Switch UI", false, function(value)
        SwitchGui.Enabled = value
        if not value and SwitchEndDrag then
            SwitchEndDrag()
        end
        Window:Notify("SWORD UI", value and "Sword switch UI shown" or "Sword switch UI hidden", 3)
    end)
    ArmToggle = SwordTab:AddToggle("Sword on Arm Tip (OFF: Back)", false, function(value)
        setArmMode(value)
    end)

    ModeSectionLabel = SwordTab:AddSection("-- Sword Offset (Back) --")
    for _, def in ipairs(CONTROL_DEFS) do
        local control = def
        local initialValue = getControlValue(control)
        SwordSliders[control.Name] = SwordTab:AddSlider(control.Name, {
            Min = -control.Limit,
            Max = control.Limit,
            Default = initialValue,
        }, function(value)
            setControlValue(control, value)
        end)
        SwordTextboxes[control.Name] = SwordTab:AddTextbox({
            Name = control.Name .. " Value",
            Default = tostring(initialValue),
            Placeholder = string.format("%d to %d", -control.Limit, control.Limit),
            Callback = function(text)
                setControlValue(control, text)
            end,
        })
    end
    SwordTab:AddButton("reset sword transform", function()
        local defaults = Sword.ArmMode and Sword.Defaults.Arm or Sword.Defaults.Back
        local profile = activeProfile()
        profile.Position = defaults.Position
        profile.Angle = defaults.Angle
        syncControls()
        Window:Notify("SWORD RESET", "transform reset to default", 3)
    end)
end)()

-- SETTING tab controls
SettingTab:AddSection("-- Giant Settings --")
SettingTab:AddToggle("Toggle 7x Giant Movement", true, function(value)
    if giantMovementScaleEnabled == value then
        return
    end
    giantMovementScaleEnabled = value
    if isBuilt and isTracing then
        tracePlayer()
    end
end)
SettingTab:AddToggle("Toggle 7x Movement Speed", false, function(value)
    setTPWalkEnabled(value)
end)
local GiantSpacingSlider
local GiantSpacingTextbox
local giantSpacingControlSyncing = false

local function setGiantSpacing(value)
    if giantSpacingControlSyncing then
        return
    end
    local numericValue = tonumber(value)
    if not numericValue then
        numericValue = giantSpacing
    end
    numericValue = math.clamp(math.floor(numericValue + 0.5), GIANT_SPACING_MIN, GIANT_SPACING_MAX)
    giantSpacingControlSyncing = true
    giantSpacing = numericValue
    if GiantSpacingSlider then
        GiantSpacingSlider:Set(numericValue)
    end
    if GiantSpacingTextbox then
        GiantSpacingTextbox:Set(tostring(numericValue))
    end
    giantSpacingControlSyncing = false
    refreshGiantAssemblyPlacement()
end

GiantSpacingSlider = SettingTab:AddSlider("Double Giant Spacing", {
    Min = GIANT_SPACING_MIN,
    Max = GIANT_SPACING_MAX,
    Default = giantSpacing,
}, function(value)
    setGiantSpacing(value)
end)

GiantSpacingTextbox = SettingTab:AddTextbox({
    Name = "Double Giant Spacing Value",
    Default = tostring(giantSpacing),
    Placeholder = string.format("%d-%d", GIANT_SPACING_MIN, GIANT_SPACING_MAX),
    Callback = function(text)
        setGiantSpacing(text)
    end,
})

local GiantOffsetSliders = { {}, {} }
local GiantOffsetTextboxes = { {}, {} }
local giantOffsetControlSyncing = false
local GIANT_OFFSET_AXES = { "X", "Y", "Z" }

local function getGiantOffsetAxis(offset, axis)
    if axis == "X" then
        return offset.X
    elseif axis == "Y" then
        return offset.Y
    end
    return offset.Z
end

local function replaceGiantOffsetAxis(offset, axis, value)
    if axis == "X" then
        return Vector3.new(value, offset.Y, offset.Z)
    elseif axis == "Y" then
        return Vector3.new(offset.X, value, offset.Z)
    end
    return Vector3.new(offset.X, offset.Y, value)
end

local function setGiantOffsetAxis(assemblyIndex, axis, value)
    if giantOffsetControlSyncing then
        return
    end
    local currentOffset = giantOffsets[assemblyIndex] or Vector3.zero
    local numericValue = tonumber(value)
    if not numericValue then
        numericValue = getGiantOffsetAxis(currentOffset, axis)
    end
    numericValue = math.clamp(math.floor(numericValue + 0.5), GIANT_OFFSET_MIN, GIANT_OFFSET_MAX)
    giantOffsetControlSyncing = true
    giantOffsets[assemblyIndex] = replaceGiantOffsetAxis(currentOffset, axis, numericValue)
    local slider = GiantOffsetSliders[assemblyIndex][axis]
    local textbox = GiantOffsetTextboxes[assemblyIndex][axis]
    if slider then
        slider:Set(numericValue)
    end
    if textbox then
        textbox:Set(tostring(numericValue))
    end
    giantOffsetControlSyncing = false
    refreshGiantAssemblyPlacement()
end

local function addGiantOffsetControls(assemblyIndex)
    SettingTab:AddSection(string.format("-- Giant %d Position --", assemblyIndex))
    for _, axisName in ipairs(GIANT_OFFSET_AXES) do
        local axis = axisName
        local defaultValue = getGiantOffsetAxis(giantOffsets[assemblyIndex], axis)
        GiantOffsetSliders[assemblyIndex][axis] = SettingTab:AddSlider(
            string.format("Giant %d %s Offset", assemblyIndex, axis),
            {
                Min = GIANT_OFFSET_MIN,
                Max = GIANT_OFFSET_MAX,
                Default = defaultValue,
            },
            function(newValue)
                setGiantOffsetAxis(assemblyIndex, axis, newValue)
            end
        )
        GiantOffsetTextboxes[assemblyIndex][axis] = SettingTab:AddTextbox({
            Name = string.format("Giant %d %s Value", assemblyIndex, axis),
            Default = tostring(defaultValue),
            Placeholder = string.format("%d to %d", GIANT_OFFSET_MIN, GIANT_OFFSET_MAX),
            Callback = function(text)
                setGiantOffsetAxis(assemblyIndex, axis, text)
            end,
        })
    end
end

SettingTab:AddSection("-- wait / assemble --")
SettingTab:AddToggle("Orbit Parts While Waiting", false, function(value)
    Window._FaptaWait.Orbit = value
    if not value and isBuilt then
        -- Back to the usual spot under the map.
        if isTracing then
            refreshGiantAssemblyPlacement()
            moveRightLegGroupsToWaitPosition()
            if headlessEnabled then
                moveHeadToWaitPosition()
            end
        else
            moveToWaitPosition()
        end
    end
end)
SettingTab:AddToggle("Tween Assemble (0.5s steps)", false, function(value)
    Window._FaptaWait.Assemble = value
    if not value then
        Window._FaptaWait.CancelAssemble()
        if Window._FaptaWait.ReleaseStart then
            -- Switched off while parts were still gliding back: park them right away.
            Window._FaptaWait.ReleaseStart = nil
            if isBuilt then
                moveToWaitPosition()
            end
        end
    end
end)
SettingTab:AddSection("-- Modifiers --")
SettingTab:AddToggle("Toggle Headless", false, function(value)
    headlessEnabled = value
    if isBuilt then
        if headlessEnabled then
            moveHeadToWaitPosition()
        elseif isTracing then
            tracePlayer()
        else
            moveToWaitPosition()
        end
    end
end)
KorbloxLegToggle = SettingTab:AddToggle("Toggle Korblox leg", false, function(value)
    if korbloxLegEnabled == value then
        return
    end
    if value and isBuilt then
        local folder, folderLabel = resolveSelectedFolder()
        if not folder then
            Window:Notify("KORBLOX LEG ERROR", getSelectedFolderError(folderLabel), 6)
            task.defer(function()
                if KorbloxLegToggle and KorbloxLegToggle:Get() then
                    KorbloxLegToggle:Set(false)
                end
            end)
            return
        end
        local candidates = findKorbloxLegCandidates(folder)
        local usedParts = {}
        local missingAssemblies = {}
        for _, assembly in ipairs(GiantAssemblies) do
            if #assembly.KorbloxRightLegParts > 0 then
                usedParts[assembly.KorbloxRightLegParts[1].Part] = true
            else
                table.insert(missingAssemblies, assembly)
            end
        end
        local availableCandidates = {}
        for _, candidate in ipairs(candidates) do
            if not usedParts[candidate.Part] then
                table.insert(availableCandidates, candidate)
            end
        end
        if #availableCandidates < #missingAssemblies then
            Window:Notify(
                "KORBLOX LEG ERROR",
                string.format(
                    "%d TetracubeI SoundParts with size 1.75, 7, 1.75 are required; %d available",
                    #GiantAssemblies,
                    #candidates
                ),
                6
            )
            task.defer(function()
                if KorbloxLegToggle and KorbloxLegToggle:Get() then
                    KorbloxLegToggle:Set(false)
                end
            end)
            return
        end
        for index, assembly in ipairs(missingAssemblies) do
            local candidate = availableCandidates[index]
            assembly.KorbloxRightLegParts = {
                makeKorbloxLegData(candidate.Model, candidate.Part),
            }
            assignKorbloxLegLayout(assembly.KorbloxRightLegParts)
        end
    end
    korbloxLegEnabled = value
    if isBuilt then
        moveRightLegGroupsToWaitPosition()
        if isTracing then
            tracePlayer()
        end
    end
end)
-- Choose the body parts that are built from the brown boards. The change applies at the next build.
Window._FaptaWoodStyle.Dropdown = SettingTab:AddMultiDropdown(
    "Swap Boards (Giant 1 brown / Giant 2 TwoLegs)",
    Window._FaptaWoodStyle.Options,
    function(selectedList)
        local selected = {}
        for _, partName in ipairs(selectedList) do
            selected[partName] = true
        end
        Window._FaptaWoodStyle.Selected = selected
        if isBuilt then
            -- Applied right away: swapped boards trade places with unused ones.
            local swapped = Window._FaptaWoodStyle.Apply()
            Window:Notify(
                "BROWN BOARDS",
                string.format("%d boards swapped; replaced boards moved to the waiting spot", swapped),
                5
            )
        end
    end
)
addGiantOffsetControls(1)
addGiantOffsetControls(2)
-- OTHERS tab controls (Orbit_1, Firework Wings, Orbit_2)
Window._OthersTab:AddSection("-- Orbit_1(FireworkSparkler) --")
FireworkSpinToggle = Window._OthersTab:AddToggle("Firework Orbit", false, function(value)
    if value then
        if Window._FaptaWings.Enabled and Window._FaptaWings.Toggle then
            -- The wings use the same toys: switch them off first.
            Window._FaptaWings.Toggle:Set(false)
        end
        local success, message = applyFireworkSparklers()
        if not success then
            Window:Notify("FIREWORK ERROR", message, 6)
            task.defer(function()
                if FireworkSpinToggle and FireworkSpinToggle:Get() then
                    FireworkSpinToggle:Set(false)
                end
            end)
            return
        end
        local targetCF = getBackOrbitTargetCF()
        if FireworkOrbitAnchor and FireworkOrbitAnchor.Parent and targetCF then
            FireworkOrbitAnchor.CFrame = targetCF
        end
        fireworkSpinEnabled = true
        updateFireworkSpin(0)
        Window:Notify("FIREWORK", message .. "; animation on", 4)
    else
        local hadAppliedFireworks = #FireworkSparklers > 0 or FireworkOrbitAnchor ~= nil
        fireworkSpinEnabled = false
        if hadAppliedFireworks then
            local waitPositionY = WAIT_POS_Y
            Util.parkGroupUnderground(FireworkSparklers, waitPositionY)
            if FireworkOrbitAnchor and FireworkOrbitAnchor.Parent then
                FireworkOrbitAnchor.CFrame = CFrame.new(0, waitPositionY, 0)
            end
            Window:Notify("FIREWORK", "animation off; parked underground", 4)
        end
    end
end)
Window._OthersTab:AddSlider("Spin Y Position", {
    Min = -30,
    Max = 30,
    Default = backSpinVerticalOffset,
}, function(value)
    backSpinVerticalOffset = value
end)
Window._OthersTab:AddSlider("Firework Radius", {
    Min = 0,
    Max = 30,
    Default = fireworkOrbitRadius,
}, function(value)
    fireworkOrbitRadius = value
end)
Window._OthersTab:AddSlider("Spin Speed", {
    Min = 0,
    Max = 360,
    Default = backSpinRotationSpeed,
}, function(value)
    backSpinRotationSpeed = value
end)


;(function()
    local Wings = Window._FaptaWings
    Window._OthersTab:AddSection("-- Firework Wings --")
    Wings.Toggle = Window._OthersTab:AddToggle("Firework Wings", false, function(value)
        if value then
            Wings.Enable()
        else
            Wings.Disable()
        end
    end)
end)()

Window._OthersTab:AddSection("-- Orbit_2(Spotlight) --")
local SpotlightTypeDropdown = Window._OthersTab:AddMultiDropdown(
    "Spotlight Types",
    SPOTLIGHT_OPTIONS,
    function(selectedNames)
        selectedSpotlightNames = normalizeSpotlightSelection(selectedNames)
        local hadAppliedSpotlights = #Spotlights > 0 or SpotlightOrbitAnchor ~= nil
        if hadAppliedSpotlights then
            local wasEnabled = SpotlightSpinToggle and SpotlightSpinToggle:Get()
            local success, message = applySpotlights()
            if not success then
                Window:Notify("SPOTLIGHT ERROR", message, 6)
                if wasEnabled then
                    task.defer(function()
                        if SpotlightSpinToggle and SpotlightSpinToggle:Get() then
                            SpotlightSpinToggle:Set(false)
                        end
                    end)
                end
                return
            end
            if wasEnabled then
                local targetCF = getBackOrbitTargetCF()
                if SpotlightOrbitAnchor and SpotlightOrbitAnchor.Parent and targetCF then
                    SpotlightOrbitAnchor.CFrame = targetCF
                end
                spotlightSpinEnabled = true
                updateSpotlightSpin(0)
                Window:Notify("SPOTLIGHT", "selection changed; animation restarted", 4)
            else
                spotlightSpinEnabled = false
                spotlightFacingSession = spotlightFacingSession + 1
                local waitPositionY = WAIT_POS_Y
                Util.parkGroupUnderground(Spotlights, waitPositionY)
                if SpotlightOrbitAnchor and SpotlightOrbitAnchor.Parent then
                    SpotlightOrbitAnchor.CFrame = CFrame.new(0, waitPositionY, 0)
                end
                Window:Notify("SPOTLIGHT", "selection changed; parked underground", 4)
            end
        end
    end
)
SpotlightSpinToggle = Window._OthersTab:AddToggle("Spotlight Orbit", false, function(value)
    if value then
        local success, message = applySpotlights()
        if not success then
            Window:Notify("SPOTLIGHT ERROR", message, 6)
            task.defer(function()
                if SpotlightSpinToggle and SpotlightSpinToggle:Get() then
                    SpotlightSpinToggle:Set(false)
                end
            end)
            return
        end
        local targetCF = getBackOrbitTargetCF()
        if SpotlightOrbitAnchor and SpotlightOrbitAnchor.Parent and targetCF then
            SpotlightOrbitAnchor.CFrame = targetCF
        end
        spotlightSpinEnabled = true
        updateSpotlightSpin(0)
        Window:Notify("SPOTLIGHT", message .. "; animation on", 4)
    else
        local hadAppliedSpotlights = #Spotlights > 0 or SpotlightOrbitAnchor ~= nil
        spotlightSpinEnabled = false
        spotlightFacingSession = spotlightFacingSession + 1
        if hadAppliedSpotlights then
            local waitPositionY = WAIT_POS_Y
            Util.parkGroupUnderground(Spotlights, waitPositionY)
            if SpotlightOrbitAnchor and SpotlightOrbitAnchor.Parent then
                SpotlightOrbitAnchor.CFrame = CFrame.new(0, waitPositionY, 0)
            end
            Window:Notify("SPOTLIGHT", "animation off; parked underground", 4)
        end
    end
end)
Window._OthersTab:AddSlider("Spotlight Radius", {
    Min = 0,
    Max = 40,
    Default = spotlightOrbitRadius,
}, function(value)
    spotlightOrbitRadius = value
end)
-- STAFF ROLL tab
-- Keep the language selector as the first visible component in this tab.
Window._FaptaLanguageStartup = true
Window._FaptaLanguageDropdown = StaffTab:AddDropdown(
    "Language / 言語",
    { "English (Current)", "日本語" },
    function(option)
        Window:_FaptaSetLanguage(option == "日本語" and "Japanese" or "English")
        if not Window._FaptaLanguageStartup then
            Window:Notify(
                "LANGUAGE",
                option == "日本語" and "Japanese UI selected" or "English UI selected",
                3
            )
        end
    end
)
StaffTab:AddSection("-- STAFF ROLL --")
StaffTab:AddParagraph("HertaIX Library", "Library / Design: midori")
StaffTab:AddParagraph("fapta giant trace", "Toy-based giant body tracking rebuild")
StaffTab:AddParagraph("PLOT,DEFENCE Tab Reference", "Blitz,Resonance (ayoo fuckass skid script😭✌️)")
StaffTab:AddSection("-- omake! --")
StaffTab:AddButton("...", function()
    local success, err = pcall(function()
        loadstring(
            game:HttpGet(
                "https://raw.githubusercontent.com/midorimidoru1-collab/bad-apple-roblox-script/main/bad_apple.lua"
            )
        )()
    end)
    if success then
        Window:Notify("STAFF ROLL", "Bad Apple", 4)
    else
        Window:Notify("LOAD ERROR", tostring(err), 6)
        warn("[HertaIX] Bad Apple load failed:", err)
    end
end)
StaffTab:AddLabel("thx 4 useing this script")

-- ============================================================================
-- LOGIC
-- ============================================================================
-- ----------------------------------------------------------------------------
-- Shared helpers (used by several features below and by the UI callbacks)
-- ----------------------------------------------------------------------------
function Util.isDataAlive(data)
    return data.Part and data.Part.Parent and data.BP and data.BP.Parent and data.BG and data.BG.Parent
end

-- Parking spot number `slot` (1-based) under the map: rows of WAIT_SLOT_COLUMNS, WAIT_SLOT_SPACING apart.
function Util.getWaitSlotCF(slot, waitY)
    local zeroBasedSlot = slot - 1
    return CFrame.new(
        (zeroBasedSlot % WAIT_SLOT_COLUMNS) * WAIT_SLOT_SPACING,
        waitY,
        math.floor(zeroBasedSlot / WAIT_SLOT_COLUMNS) * WAIT_SLOT_SPACING
    )
end

-- Moves every toy of a group to its parking spot under the map (movers stay attached).
function Util.parkGroupUnderground(group, waitY)
    for index, data in ipairs(group) do
        if Util.isDataAlive(data) then
            local waitCF = Util.getWaitSlotCF(index, waitY)
            data.BP.Position = waitCF.Position
            data.BG.CFrame = waitCF * rotationOnly(data.BG.CFrame)
        end
    end
end

-- Un-anchors a toy model, switches off its collisions and returns what it was before
-- (restoreSpinGroup puts it back).
function Util.freezeParts(model)
    local partStates = {}
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            table.insert(partStates, {
                Part = descendant,
                Anchored = descendant.Anchored,
                CanCollide = descendant.CanCollide,
            })
            descendant.Anchored = false
            descendant.CanCollide = false
        end
    end
    return partStates
end

-- Switches Firework / Spotlight orbit off and gives their toys (and the sword) back.
function Util.releaseSpinToysAndSword()
    if FireworkSpinToggle and FireworkSpinToggle:Get() then
        FireworkSpinToggle:Set(false)
    end
    if SpotlightSpinToggle and SpotlightSpinToggle:Get() then
        SpotlightSpinToggle:Set(false)
    end
    restoreFireworkSparklers()
    restoreSpotlights()
    if Window._FaptaSword.Cleanup then
        Window._FaptaSword.Cleanup()
    end
end



-- Shared CFrame and numeric comparison helpers
function rotationOnly(cf)
    return cf - cf.Position
end

local function approximatelyEqual(a, b, tolerance)
    return math.abs(a - b) <= tolerance
end

local function approximatelyEqualVector(a, b, tolerance)
    return approximatelyEqual(a.X, b.X, tolerance)
        and approximatelyEqual(a.Y, b.Y, tolerance)
        and approximatelyEqual(a.Z, b.Z, tolerance)
end

-- BodyMover ownership and collision-state lifecycle
local function clearAllBodyMovers(part)
    for _, child in ipairs(part:GetChildren()) do
        if child:IsA("BodyPosition") or child:IsA("BodyGyro") then
            child:Destroy()
        end
    end
end

local function clearOwnedBodyMovers(part)
    for _, child in ipairs(part:GetChildren()) do
        if child.Name == "GiantTraceBodyPosition" or child.Name == "GiantTraceBodyGyro" then
            child:Destroy()
        end
    end
end

local function attachBodyMovers(part)
    clearAllBodyMovers(part)
    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.Name = "GiantTraceBodyPosition"
    bodyPosition.MaxForce = Vector3.new(1, 1, 1) * 1e10
    bodyPosition.P = 15000
    bodyPosition.D = 200
    bodyPosition.Parent = part
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.Name = "GiantTraceBodyGyro"
    bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 1e10
    bodyGyro.P = 15000
    bodyGyro.D = 200
    bodyGyro.Parent = part
    return bodyGyro, bodyPosition
end

local function recordAndDisableCollisions(model)
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            if not CollisionRecorded[descendant] then
                CollisionRecorded[descendant] = true
                table.insert(CollisionState, {
                    Part = descendant,
                    CanCollide = descendant.CanCollide,
                })
            end
            descendant.CanCollide = false
        end
    end
end

local function restoreCollisions()
    for _, entry in ipairs(CollisionState) do
        if entry.Part and entry.Part.Parent then
            entry.Part.CanCollide = entry.CanCollide
        end
    end
    CollisionState = {}
    CollisionRecorded = {}
end

local function destroyGroupMovers(group)
    for _, data in ipairs(group) do
        if data.Part and data.Part.Parent then
            clearOwnedBodyMovers(data.Part)
        end
    end
end

local function forEachAssemblyGroup(assembly, callback)
    for _, group in ipairs(assembly.Units) do
        callback(group)
    end
    callback(assembly.RightLegWoodParts)
    callback(assembly.KorbloxRightLegParts)
    callback(assembly.HeadParts)
    callback(assembly.TorsoParts)
end

function cleanupGiant()
    if Window._FaptaSword.Park then
        Window._FaptaSword.Park()
    end
    for _, assembly in ipairs(GiantAssemblies) do
        forEachAssemblyGroup(assembly, destroyGroupMovers)
    end
    -- Unused (spare) boards carry movers too.
    for _, boards in pairs(Window._FaptaWoodStyle.Pool) do
        destroyGroupMovers(boards)
    end
    Window._FaptaWoodStyle.Pool = { Two = {}, Brown = {} }
    restoreCollisions()
    GiantAssemblies = {}
    isBuilt = false
end

-- Apply target transforms and validate assembled dimensions
local function setTarget(data, targetCF)
    if data.Part and data.Part.Parent and data.BP and data.BG then
        local traceYOffset = isTracing and TORSO_TRACE_Y_OFFSET or 0
        local torsoAnchoredTargetCF = CFrame.new(0, traceYOffset, 0) * targetCF
        local finalCF = torsoAnchoredTargetCF * (data.RotationOffset or TOY_ROTATION_OFFSET)
        if data.BlendAlpha and data.BlendFromCF then
            -- Tween assembly: glide from the waiting spot toward the traced position.
            local alpha = data.BlendAlpha
            finalCF = data.BlendFromCF:Lerp(finalCF, alpha * alpha * (3 - 2 * alpha))
        end
        data.BP.Position = finalCF.Position
        data.BG.CFrame = finalCF
    end
end

local function setGroupTarget(group, assemblyCF)
    for _, data in ipairs(group) do
        setTarget(data, assemblyCF * data.LocalCF)
    end
end

local function calculateAssemblyBounds(group)
    local minX, minY, minZ = math.huge, math.huge, math.huge
    local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge
    for _, data in ipairs(group) do
        local cf = data.LocalCF
        local size = data.Part.Size
        local halfX = (
            math.abs(cf.XVector.X) * size.X
            + math.abs(cf.YVector.X) * size.Y
            + math.abs(cf.ZVector.X) * size.Z
        ) / 2
        local halfY = (
            math.abs(cf.XVector.Y) * size.X
            + math.abs(cf.YVector.Y) * size.Y
            + math.abs(cf.ZVector.Y) * size.Z
        ) / 2
        local halfZ = (
            math.abs(cf.XVector.Z) * size.X
            + math.abs(cf.YVector.Z) * size.Y
            + math.abs(cf.ZVector.Z) * size.Z
        ) / 2
        minX = math.min(minX, cf.Position.X - halfX)
        minY = math.min(minY, cf.Position.Y - halfY)
        minZ = math.min(minZ, cf.Position.Z - halfZ)
        maxX = math.max(maxX, cf.Position.X + halfX)
        maxY = math.max(maxY, cf.Position.Y + halfY)
        maxZ = math.max(maxZ, cf.Position.Z + halfZ)
    end
    return Vector3.new(maxX - minX, maxY - minY, maxZ - minZ)
end

local function validateAssemblySize(label, group, expectedSize)
    local measuredSize = calculateAssemblyBounds(group)
    if not approximatelyEqualVector(measuredSize, expectedSize, SIZE_TOLERANCE) then
        return false,
            string.format(
                "%s size mismatch. expected %.3f, %.3f, %.3f / measured %.3f, %.3f, %.3f",
                label,
                expectedSize.X,
                expectedSize.Y,
                expectedSize.Z,
                measuredSize.X,
                measuredSize.Y,
                measuredSize.Z
            )
    end
    return true, measuredSize
end

local function validateWoodToyPart(part)
    if not approximatelyEqualVector(part.Size, TOY_SIZE, SIZE_TOLERANCE) then
        return false,
            string.format(
                "TableWoodTwoLegs size mismatch. expected %.3f, %.3f, %.3f / got %.3f, %.3f, %.3f",
                TOY_SIZE.X,
                TOY_SIZE.Y,
                TOY_SIZE.Z,
                part.Size.X,
                part.Size.Y,
                part.Size.Z
            )
    end
    return true
end

-- Locate supported toy parts and create their runtime data records
local function findMatchingSoundPart(model)
    for _, descendant in ipairs(model:GetDescendants()) do
        if
            descendant.Name == "SoundPart"
            and descendant:IsA("BasePart")
            and approximatelyEqualVector(descendant.Size, TOY_SIZE, SIZE_TOLERANCE)
        then
            return descendant
        end
    end
    return nil
end

-- The brown board model has no part called SoundPart, so its board part is found by name
-- (SoundMain / Hitbox / Part) and by the board size instead.
local function findBrownBoardPart(model)
    for _, wantedName in ipairs({ "SoundPart", "SoundMain", "Hitbox", "Part" }) do
        for _, descendant in ipairs(model:GetDescendants()) do
            if
                descendant.Name == wantedName
                and descendant:IsA("BasePart")
                and approximatelyEqualVector(descendant.Size, TOY_SIZE, SIZE_TOLERANCE)
            then
                return descendant
            end
        end
    end
    for _, descendant in ipairs(model:GetDescendants()) do
        if
            descendant:IsA("BasePart")
            and approximatelyEqualVector(descendant.Size, TOY_SIZE, SIZE_TOLERANCE)
        then
            return descendant
        end
    end
    return nil
end

local function findKorbloxLegPart(model)
    local soundPart = model:FindFirstChild("SoundPart")
    if
        soundPart
        and soundPart:IsA("BasePart")
        and approximatelyEqualVector(soundPart.Size, KORBLOX_LEG_SIZE, SIZE_TOLERANCE)
    then
        return soundPart
    end
    return nil
end

function findKorbloxLegCandidates(folder)
    local candidates = {}
    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Model") and child.Name == KORBLOX_LEG_TOY_NAME then
            local part = findKorbloxLegPart(child)
            if part then
                table.insert(candidates, { Model = child, Part = part })
            end
        end
    end
    return candidates
end

local function getHeadModelPart(model)
    return model:FindFirstChildWhichIsA("BasePart", true)
end

local function makePartData(model, part)
    recordAndDisableCollisions(model)
    local bg, bp = attachBodyMovers(part)
    return {
        Part = part,
        BG = bg,
        BP = bp,
        LocalCF = CFrame.new(),
    }
end

function makeKorbloxLegData(model, soundPart)
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("BasePart") then
            if not CollisionRecorded[child] then
                CollisionRecorded[child] = true
                table.insert(CollisionState, {
                    Part = child,
                    CanCollide = child.CanCollide,
                })
            end
            child.CanCollide = false
        end
    end
    local bg, bp = attachBodyMovers(soundPart)
    return {
        Part = soundPart,
        BG = bg,
        BP = bp,
        LocalCF = CFrame.new(),
        RotationOffset = CFrame.Angles(math.rad(90), 0, math.rad(90)),
    }
end

-- Local assembly layouts for limbs, torso, and the optional Korblox leg
local function assignLimbLayout(group)
    local faceOffsetZ = (LIMB_ASSEMBLY_SIZE.Z - TOY_SIZE.Z) / 2
    local capOffsetY = (LIMB_ASSEMBLY_SIZE.Y - TOY_SIZE.Z) / 2
    local layout = {
        CFrame.new(0, 0, -faceOffsetZ),
        CFrame.new(0, 0, faceOffsetZ) * CFrame.Angles(0, math.rad(180), 0),
        CFrame.new(0, capOffsetY, 0) * CFrame.Angles(math.rad(90), 0, 0),
        CFrame.new(0, -capOffsetY, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    }
    for slot, data in ipairs(group) do
        data.LocalCF = layout[slot]
    end
end

function assignKorbloxLegLayout(group)
    local topAlignmentOffset = (TOY_SIZE.X - KORBLOX_LEG_SIZE.Y) / 2
    for _, data in ipairs(group) do
        data.LocalCF = CFrame.new(topAlignmentOffset, 0, 0)
    end
end

local function assignTorsoLayout(group)
    local faceOffsetZ = (TORSO_ASSEMBLY_SIZE.Z - TOY_SIZE.Z) / 2
    local faceHalfHeight = TOY_SIZE.Y / 2
    local capOffsetY = (TORSO_ASSEMBLY_SIZE.Y - TOY_SIZE.Z) / 2
    local layout = {
        CFrame.new(0, -faceHalfHeight, -faceOffsetZ),
        CFrame.new(0, faceHalfHeight, -faceOffsetZ),
        CFrame.new(0, -faceHalfHeight, faceOffsetZ) * CFrame.Angles(0, math.rad(180), 0),
        CFrame.new(0, faceHalfHeight, faceOffsetZ) * CFrame.Angles(0, math.rad(180), 0),
        CFrame.new(0, capOffsetY, 0) * CFrame.Angles(math.rad(90), 0, 0),
        CFrame.new(0, -capOffsetY, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    }
    for slot, data in ipairs(group) do
        data.LocalCF = layout[slot]
    end
end

-- Park every inactive giant component in a unique non-overlapping slot below the map.
local function parkGiantDataAtSlot(data, slot)
    if not (data.Part and data.Part.Parent and data.BP and data.BG) then
        return
    end
    data.WaitSlot = slot
    local waitCF = Util.getWaitSlotCF(slot, WAIT_POS_Y)
    local finalCF = waitCF * (data.RotationOffset or TOY_ROTATION_OFFSET)
    data.BP.Position = finalCF.Position
    data.BG.CFrame = finalCF
end

local function getAssemblyWaitBase(assemblyIndex)
    return ((assemblyIndex - 1) * 64) + 1
end

local function moveAssemblyToWaitPosition(assembly, assemblyIndex)
    local slot = getAssemblyWaitBase(assemblyIndex)
    local function placeGroup(group)
        for _, data in ipairs(group) do
            parkGiantDataAtSlot(data, slot)
            slot = slot + 1
        end
    end
    for _, group in ipairs(assembly.Units) do
        placeGroup(group)
    end
    placeGroup(assembly.RightLegWoodParts)
    placeGroup(assembly.KorbloxRightLegParts)
    placeGroup(assembly.HeadParts)
    placeGroup(assembly.TorsoParts)
end

function moveToWaitPosition()
    for assemblyIndex, assembly in ipairs(GiantAssemblies) do
        moveAssemblyToWaitPosition(assembly, assemblyIndex)
    end
    if Window._FaptaSword.Park then
        Window._FaptaSword.Park()
    end
end

function moveHeadToWaitPosition()
    for assemblyIndex, assembly in ipairs(GiantAssemblies) do
        local slot = getAssemblyWaitBase(assemblyIndex) + 40
        for _, data in ipairs(assembly.HeadParts) do
            parkGiantDataAtSlot(data, slot)
            slot = slot + 1
        end
    end
end

function moveRightLegGroupsToWaitPosition()
    for assemblyIndex, assembly in ipairs(GiantAssemblies) do
        local slot = getAssemblyWaitBase(assemblyIndex) + 48
        for _, data in ipairs(assembly.RightLegWoodParts) do
            parkGiantDataAtSlot(data, slot)
            slot = slot + 1
        end
        for _, data in ipairs(assembly.KorbloxRightLegParts) do
            parkGiantDataAtSlot(data, slot)
            slot = slot + 1
        end
    end
end

-- Share the PLOT tab's ThisPlotsOwners data with the giant source selector.
local function isPlotOwnedByLocalPlayer(plotModel)
    local plotSign = plotModel and plotModel:FindFirstChild("PlotSign")
    local owners = plotSign and plotSign:FindFirstChild("ThisPlotsOwners")
    if not owners then
        return false
    end
    for _, ownerValue in ipairs(owners:GetChildren()) do
        if
            ownerValue.Name == "Value"
            and ownerValue:IsA("StringValue")
            and ownerValue.Value == LP.Name
        then
            return true
        end
    end
    return false
end

local function findLocalPlayerOwnedPlot()
    local plots = Workspace:FindFirstChild("Plots")
    if not plots then
        return nil, nil, "Workspace.Plots was not found"
    end
    for plotIndex = 1, 5 do
        local plotName = "Plot" .. plotIndex
        local plotModel = plots:FindFirstChild(plotName)
        if plotModel and isPlotOwnedByLocalPlayer(plotModel) then
            return plotModel, plotName
        end
    end
    return nil,
        nil,
        string.format(
            "No Plot1-Plot5 owner entry references %s. Claim a plot before using Plot.",
            LP.Name
        )
end

-- Resolve SpawnedInToys directly or map Plot to the local player's owned PlotItems folder.
function resolveSelectedFolder()
    if selectedFolderOption == "Plot" then
        local _, plotName, ownerError = findLocalPlayerOwnedPlot()
        if not plotName then
            return nil, ownerError
        end
        local plotItems = Workspace:FindFirstChild("PlotItems")
        if not plotItems then
            return nil, "Workspace.PlotItems was not found"
        end
        local plotFolder = plotItems:FindFirstChild(plotName)
        if not plotFolder then
            return nil,
                "Owned " .. plotName .. " was found, but PlotItems." .. plotName .. " is missing"
        end
        return plotFolder, "PlotItems." .. plotName
    end
    local standardName = LP.Name .. "SpawnedInToys"
    local legacyName = LP.Name .. "SpawnedinToys"
    local folder = Workspace:FindFirstChild(standardName) or Workspace:FindFirstChild(legacyName)
    return folder, standardName .. " or " .. legacyName
end

function getSelectedFolderError(folderLabel)
    if selectedFolderOption == "Plot" then
        return folderLabel
    end
    return string.format("Selected folder is not found: %s", folderLabel)
end

-- FireworkSparkler and Spotlight lifecycle management
local function restoreSpinGroup(group)
    for _, data in ipairs(group) do
        if data.Part and data.Part.Parent then
            clearOwnedBodyMovers(data.Part)
        end
        if data.Model and data.Model.Parent then
            pcall(function()
                data.Model:PivotTo(data.OriginalModelPivot)
            end)
        end
        for _, partState in ipairs(data.PartStates) do
            if partState.Part and partState.Part.Parent then
                partState.Part.Anchored = partState.Anchored
                partState.Part.CanCollide = partState.CanCollide
            end
        end
    end
end

local function createOrbitAnchor(name)
    local anchor = Instance.new("Part")
    anchor.Name = name
    anchor.Size = Vector3.new(1, 1, 1)
    anchor.Transparency = 1
    anchor.Anchored = true
    anchor.CanCollide = false
    anchor.CanTouch = false
    anchor.CanQuery = false
    anchor.CastShadow = false
    anchor.Parent = Workspace
    return anchor
end

local function getYawOnlyCFrame(sourceCF, position)
    local flatLook = Vector3.new(sourceCF.LookVector.X, 0, sourceCF.LookVector.Z)
    if flatLook.Magnitude < 0.001 then
        flatLook = Vector3.new(0, 0, -1)
    else
        flatLook = flatLook.Unit
    end
    return CFrame.lookAt(position, position + flatLook, Vector3.new(0, 1, 0))
end

function getBackOrbitTargetCF()
    local character = LP.Character
    local torso = character
        and (character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso"))
    if not torso then
        return nil
    end
    local centerPosition = torso.Position
        + Vector3.new(0, TORSO_TRACE_Y_OFFSET + backSpinVerticalOffset, 0)
    return getYawOnlyCFrame(torso.CFrame, centerPosition) * CFrame.new(0, 0, BACK_SPIN_DISTANCE)
end

local function updateOrbitAnchor(anchor, targetCF, responsiveness, deltaTime)
    if not anchor or not anchor.Parent or not targetCF then
        return
    end
    local alpha = 1 - math.exp(-responsiveness * math.max(deltaTime, 0))
    anchor.CFrame = anchor.CFrame:Lerp(targetCF, math.clamp(alpha, 0, 1))
end

local function getSpinGroupCenterPosition(group)
    local totalPosition = Vector3.new()
    local count = 0
    for _, data in ipairs(group) do
        if data.Part and data.Part.Parent then
            totalPosition = totalPosition + data.Part.Position
            count = count + 1
        end
    end
    if count == 0 then
        return nil
    end
    return totalPosition / count
end

function restoreFireworkSparklers()
    local hadWings = Window._FaptaWings.Restore and Window._FaptaWings.Restore() or false
    local hadToys = hadWings or fireworkSpinEnabled or #FireworkSparklers > 0 or FireworkOrbitAnchor ~= nil
    fireworkSpinEnabled = false
    fireworkSpinAngle = 0
    restoreSpinGroup(FireworkSparklers)
    FireworkSparklers = {}
    if FireworkOrbitAnchor then
        FireworkOrbitAnchor:Destroy()
        FireworkOrbitAnchor = nil
    end
    return hadToys
end

-- Stops the spotlight orbit without giving any toy back (the toys stay prepared under the map).
function Window._FaptaToys.ResetSpotlightOrbit()
    spotlightSpinEnabled = false
    spotlightSpinAngle = 0
    spotlightFacingSession = spotlightFacingSession + 1
    spotlightFacingIndex = 1
    Spotlights = {}
    if SpotlightOrbitAnchor then
        SpotlightOrbitAnchor:Destroy()
        SpotlightOrbitAnchor = nil
    end
end

function restoreSpotlights()
    local toyState = Window._FaptaToys
    local hadPool = next(toyState.SpotlightPool) ~= nil
    local hadToys = hadPool or spotlightSpinEnabled or #Spotlights > 0 or SpotlightOrbitAnchor ~= nil
    -- Spotlights is a subset of the prepared pool, so giving the pool back covers it.
    for _, toys in pairs(toyState.SpotlightPool) do
        restoreSpinGroup(toys)
    end
    if not hadPool then
        restoreSpinGroup(Spotlights)
    end
    toyState.SpotlightPool = {}
    toyState.ResetSpotlightOrbit()
    return hadToys
end

-- Collect orbit models and attach reusable BodyPosition/BodyGyro movers
local function collectAndAttachSpinToys(folder, toyName, allowPartFallback)
    local toys = {}
    for _, model in ipairs(folder:GetChildren()) do
        if model:IsA("Model") and model.Name == toyName then
            local soundPart = model:FindFirstChild("SoundPart")
            if allowPartFallback and (not soundPart or not soundPart:IsA("BasePart")) then
                soundPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
            end
            if soundPart and soundPart:IsA("BasePart") then
                local partStates = Util.freezeParts(model)
                local bodyGyro, bodyPosition = attachBodyMovers(soundPart)
                bodyPosition.Position = soundPart.Position
                bodyGyro.CFrame = soundPart.CFrame
                table.insert(toys, {
                    Model = model,
                    Part = soundPart,
                    BP = bodyPosition,
                    BG = bodyGyro,
                    OriginalModelPivot = model:GetPivot(),
                    OriginalRotation = rotationOnly(soundPart.CFrame),
                    PartStates = partStates,
                })
            end
        end
    end
    return toys
end

local function prepareSpinToys(toyName)
    local folder, folderLabel = resolveSelectedFolder()
    if not folder then
        return false, {}, getSelectedFolderError(folderLabel)
    end
    local toys = collectAndAttachSpinToys(folder, toyName)
    if #toys == 0 then
        return false, {}, string.format("No %s objects were found in %s", toyName, folder.Name)
    end
    return true, toys, string.format("attached movers to %d %s objects", #toys, toyName)
end

-- Normalize Spotlight selections and interleave multiple selected colors
function normalizeSpotlightSelection(selectedNames)
    local selectedLookup = {}
    for _, name in ipairs(selectedNames or {}) do
        selectedLookup[name] = true
    end
    local orderedNames = {}
    for _, name in ipairs(SPOTLIGHT_OPTIONS) do
        if selectedLookup[name] then
            table.insert(orderedNames, name)
        end
    end
    return orderedNames
end

local function prepareSelectedSpotlights()
    local folder, folderLabel = resolveSelectedFolder()
    if not folder then
        return false, {}, getSelectedFolderError(folderLabel)
    end
    local orderedNames = normalizeSpotlightSelection(selectedSpotlightNames)
    if #orderedNames == 0 then
        return false, {}, "Select at least one Spotlight type"
    end
    local buckets = {}
    for _, name in ipairs(orderedNames) do
        local pooledToys = Window._FaptaToys.SpotlightPool[name]
        if not pooledToys then
            -- build Toys was not used yet: attach this color now.
            pooledToys = collectAndAttachSpinToys(folder, name, true)
            Window._FaptaToys.SpotlightPool[name] = pooledToys
            Util.parkGroupUnderground(pooledToys, WAIT_POS_Y)
        end
        buckets[name] = pooledToys
    end
    local interleavedToys = {}
    local bucketIndex = 1
    local addedInRound = true
    while addedInRound do
        addedInRound = false
        for _, name in ipairs(orderedNames) do
            local toy = buckets[name][bucketIndex]
            if toy then
                toy.SpotlightType = name
                table.insert(interleavedToys, toy)
                addedInRound = true
            end
        end
        bucketIndex = bucketIndex + 1
    end
    if #interleavedToys == 0 then
        return false,
            {},
            string.format(
                "No selected Spotlight objects were found in %s: %s",
                folder.Name,
                table.concat(orderedNames, ", ")
            )
    end
    return true,
        interleavedToys,
        string.format(
            "attached movers to %d Spotlight objects (%s)",
            #interleavedToys,
            table.concat(orderedNames, ", ")
        )
end

-- Orientation helpers for orbiting models
local function makeModelFacingCFrame(position, lookDirection, fallbackDirection)
    local direction = lookDirection
    if not direction or direction.Magnitude < 0.001 then
        direction = fallbackDirection or Vector3.new(0, 0, -1)
    end
    direction = direction.Unit
    local upVector = Vector3.new(0, 1, 0)
    if math.abs(direction:Dot(upVector)) > 0.98 then
        upVector = Vector3.new(1, 0, 0)
    end
    return CFrame.lookAt(position, position + direction, upVector)
end

-- Apply FireworkSparkler and Spotlight groups to independent orbit anchors
function applyFireworkSparklers()
    local toys = FireworkSparklers
    local message
    if #toys == 0 then
        -- build Toys was not used yet: attach the toys now.
        local success, preparedToys, preparedMessage = prepareSpinToys(FIREWORK_TOY_NAME)
        if not success then
            return false, preparedMessage
        end
        FireworkSparklers = preparedToys
        toys = preparedToys
        message = preparedMessage
    else
        message = string.format("using %d prepared FireworkSparkler objects", #toys)
    end
    if FireworkOrbitAnchor then
        FireworkOrbitAnchor:Destroy()
        FireworkOrbitAnchor = nil
    end
    fireworkSpinAngle = 0
    FireworkOrbitAnchor = createOrbitAnchor("FireworkOrbitAnchor")
    local targetCF = getBackOrbitTargetCF()
    local startPosition = getSpinGroupCenterPosition(toys) or toys[1].Part.Position
    FireworkOrbitAnchor.CFrame = getYawOnlyCFrame(targetCF or toys[1].Part.CFrame, startPosition)
    return true, message
end

-- Rotate one Spotlight at a time to reduce per-frame workload
local function createSpotlightRandomLookVector()
    local y = SPOTLIGHT_FACING_RANDOM:NextNumber(-1, 1)
    local horizontalLength = math.sqrt(math.max(0, 1 - y * y))
    local yaw = SPOTLIGHT_FACING_RANDOM:NextNumber(0, math.pi * 2)
    return Vector3.new(math.cos(yaw) * horizontalLength, y, math.sin(yaw) * horizontalLength)
end

local function updateOneSpotlightRandomFacing(data)
    if not data or not data.Part or not data.Part.Parent or not data.BG or not data.BG.Parent then
        return
    end
    data.RandomLookVector = createSpotlightRandomLookVector()
    data.BG.CFrame = makeModelFacingCFrame(
        data.Part.Position,
        data.RandomLookVector,
        data.OriginalRotation.LookVector
    )
end

local function startSpotlightSequentialFacing()
    spotlightFacingSession = spotlightFacingSession + 1
    local session = spotlightFacingSession
    spotlightFacingIndex = 1
    task.spawn(function()
        while
            session == spotlightFacingSession
            and SpotlightOrbitAnchor
            and SpotlightOrbitAnchor.Parent
            and #Spotlights > 0
        do
            if spotlightFacingIndex > #Spotlights then
                spotlightFacingIndex = 1
            end
            updateOneSpotlightRandomFacing(Spotlights[spotlightFacingIndex])
            spotlightFacingIndex = spotlightFacingIndex + 1
            task.wait(0.2)
        end
    end)
end

function applySpotlights()
    Window._FaptaToys.ResetSpotlightOrbit()
    local success, toys, message = prepareSelectedSpotlights()
    if not success then
        return false, message
    end
    Spotlights = toys
    -- Colors that are not selected stay prepared and wait under the map.
    local selectedLookup = {}
    for _, name in ipairs(normalizeSpotlightSelection(selectedSpotlightNames)) do
        selectedLookup[name] = true
    end
    for name, pooledToys in pairs(Window._FaptaToys.SpotlightPool) do
        if not selectedLookup[name] then
            Util.parkGroupUnderground(pooledToys, WAIT_POS_Y)
        end
    end
    spotlightSpinAngle = 0
    SpotlightOrbitAnchor = createOrbitAnchor("SpotlightOrbitAnchor")
    local targetCF = getBackOrbitTargetCF()
    local startPosition = getSpinGroupCenterPosition(toys) or toys[1].Part.Position
    SpotlightOrbitAnchor.CFrame = getYawOnlyCFrame(targetCF or toys[1].Part.CFrame, startPosition)
    startSpotlightSequentialFacing()
    return true, message
end

-- build Toys: applies every toy at once. The body boards (44) and glass boxes (2) form two giants;
-- FireworkSparklers, the four Spotlight colors and the sword boards are attached too. Everything
-- that is not in use waits under the map (Y = WAIT_POS_Y).
function Window._FaptaToys.PrepareFirework()
    local success, toys, message = prepareSpinToys(FIREWORK_TOY_NAME)
    if not success then
        return false, message
    end
    FireworkSparklers = toys
    Util.parkGroupUnderground(toys, WAIT_POS_Y)
    return true, message
end

function Window._FaptaToys.PrepareSpotlights()
    local folder = resolveSelectedFolder()
    local pool = {}
    local total = 0
    if folder then
        for _, name in ipairs(SPOTLIGHT_OPTIONS) do
            local toys = collectAndAttachSpinToys(folder, name, true)
            if #toys > 0 then
                pool[name] = toys
                Util.parkGroupUnderground(toys, WAIT_POS_Y)
                total = total + #toys
            end
        end
    end
    Window._FaptaToys.SpotlightPool = pool
    return total
end

function Window._FaptaToys.Build()
    -- Start clean: orbits and wings off, every earlier toy given back.
    Util.releaseSpinToysAndSword()
    local giantBuilt = buildGiant()
    local summary = { giantBuilt and "giants OK" or "giants FAILED" }
    local fireworkReady = Window._FaptaToys.PrepareFirework()
    table.insert(summary, string.format("FireworkSparkler x%d", fireworkReady and #FireworkSparklers or 0))
    table.insert(summary, string.format("Spotlight x%d", Window._FaptaToys.PrepareSpotlights()))
    Window._FaptaSword.Build()
    local swordSets = 0
    for _ in pairs(Window._FaptaSword.Sets) do
        swordSets = swordSets + 1
    end
    table.insert(summary, string.format("sword x%d", swordSets))
    Window:Notify("TOYS BUILT", table.concat(summary, " | "), 7)
    return giantBuilt
end

-- Shared circular animation and smooth anchor-follow logic
local function updateSpinGroup(group, orbitCenterCF, spinAngle, radius, rotationOffset)
    local count = #group
    if count == 0 then
        return
    end
    for index, data in ipairs(group) do
        if Util.isDataAlive(data) then
            local angle = spinAngle + ((index - 1) / count) * math.pi * 2
            local orbitPositionCF = orbitCenterCF
                * CFrame.Angles(0, 0, angle)
                * CFrame.new(0, radius, 0)
            data.BP.Position = orbitPositionCF.Position
            if rotationOffset then
                data.BG.CFrame = orbitPositionCF * rotationOffset
            end
        end
    end
end

local function updateToyOrbit(
    group,
    anchor,
    currentAngle,
    direction,
    radius,
    animationEnabled,
    responsiveness,
    deltaTime,
    rotationOffset
)
    if not anchor or not anchor.Parent then
        return currentAngle
    end
    local targetCF = getBackOrbitTargetCF()
    updateOrbitAnchor(anchor, targetCF, responsiveness, deltaTime)
    if animationEnabled then
        currentAngle = (currentAngle + direction * math.rad(backSpinRotationSpeed) * deltaTime)
            % (math.pi * 2)
    end
    updateSpinGroup(group, anchor.CFrame, currentAngle, radius, rotationOffset)
    return currentAngle
end

function updateFireworkSpin(deltaTime)
    fireworkSpinAngle = updateToyOrbit(
        FireworkSparklers,
        FireworkOrbitAnchor,
        fireworkSpinAngle,
        1,
        fireworkOrbitRadius,
        fireworkSpinEnabled,
        FIREWORK_FOLLOW_RESPONSIVENESS,
        deltaTime,
        FIREWORK_SOURCE_ROTATION_OFFSET
    )
end

function updateSpotlightSpin(deltaTime)
    spotlightSpinAngle = updateToyOrbit(
        Spotlights,
        SpotlightOrbitAnchor,
        spotlightSpinAngle,
        -1,
        spotlightOrbitRadius,
        spotlightSpinEnabled,
        SPOTLIGHT_FOLLOW_RESPONSIVENESS,
        deltaTime
    )
end

function Window._FaptaBuildSummary:CountStatus(foundCount, requiredCount)
    if foundCount <= 0 then
        return "NOT_FOUND"
    end
    if foundCount < requiredCount then
        return "ERROR"
    end
    return "SUCCESS"
end

function Window._FaptaBuildSummary:OverallStatus(foundCount, requiredCount)
    if foundCount >= requiredCount then
        return "SUCCESS"
    end
    if foundCount > 0 then
        return "ATTENTION"
    end
    return "ERROR"
end

function Window._FaptaBuildSummary:FormatRequired(label, foundCount, requiredCount)
    return string.format(
        "%s: %d/%d [%s]",
        label,
        foundCount,
        requiredCount,
        self:CountStatus(foundCount, requiredCount)
    )
end

-- Board styles. Giant 1 starts with TableWoodTwoLegs and giant 2 with the brown boards
-- (TableWoodFourLegsBrown); a body part chosen in the dropdown gets the opposite style.
function Window._FaptaWoodStyle.GetDesiredStyle(assemblyIndex, partName)
    local flipped = Window._FaptaWoodStyle.Selected[partName] == true
    local brown = (assemblyIndex == 2) ~= flipped
    return brown and "Brown" or "Two"
end

-- Takes an unused board of the wanted style. Without `strict`, the other style is used when
-- none of the wanted style is left.
function Window._FaptaWoodStyle.TakeBoard(style, strict)
    local pool = Window._FaptaWoodStyle.Pool
    local order = style == "Brown" and { "Brown", "Two" } or { "Two", "Brown" }
    for orderIndex, key in ipairs(order) do
        if not (strict and orderIndex > 1) then
            for _, data in ipairs(pool[key]) do
                if not data.InUse then
                    data.InUse = true
                    return data
                end
            end
        end
    end
    return nil
end

-- Unused boards wait under the map (they never join the orbit ring).
function Window._FaptaWoodStyle.ParkSpares()
    local slot = Window._FaptaWoodStyle.SpareSlotBase
    for _, key in ipairs({ "Two", "Brown" }) do
        for _, data in ipairs(Window._FaptaWoodStyle.Pool[key]) do
            slot = slot + 1
            if not data.InUse then
                parkGiantDataAtSlot(data, slot)
            end
        end
    end
end

-- Applies the dropdown selection to the built giants at once: boards whose style no longer matches
-- are swapped for unused boards of the wanted style, and the replaced boards go to the spare spots.
function Window._FaptaWoodStyle.Apply()
    if not isBuilt then
        return 0
    end
    local woodStyle = Window._FaptaWoodStyle
    local mismatches = {}
    for assemblyIndex, assembly in ipairs(GiantAssemblies) do
        local groups = {
            ["Left Arm"] = assembly.Units[1],
            ["Right Arm"] = assembly.Units[2],
            ["Left Leg"] = assembly.Units[3],
            ["Right Leg"] = assembly.RightLegWoodParts,
            ["Torso"] = assembly.TorsoParts,
        }
        for partName, group in pairs(groups) do
            local wanted = woodStyle.GetDesiredStyle(assemblyIndex, partName)
            for index, data in ipairs(group) do
                if data.BoardStyle ~= wanted then
                    table.insert(mismatches, {
                        Group = group,
                        Index = index,
                        Old = data,
                        Slot = data.WaitSlot,
                        Wanted = wanted,
                    })
                end
            end
        end
    end
    -- Free every mismatched board first so giant 1 and giant 2 can trade boards.
    for _, entry in ipairs(mismatches) do
        entry.Old.InUse = false
    end
    local swapped = 0
    for _, entry in ipairs(mismatches) do
        local replacement = woodStyle.TakeBoard(entry.Wanted, true)
        if replacement then
            replacement.LocalCF = entry.Old.LocalCF
            replacement.RotationOffset = entry.Old.RotationOffset
            replacement.BlendAlpha = nil
            replacement.BlendFromCF = nil
            entry.Group[entry.Index] = replacement
            if entry.Slot then
                -- Same waiting spot as the board it replaces (the trace / orbit takes over from there).
                parkGiantDataAtSlot(replacement, entry.Slot)
            end
            swapped = swapped + 1
        else
            -- No unused board of that style left: the board stays where it is.
            entry.Old.InUse = true
        end
    end
    woodStyle.ParkSpares()
    return swapped
end

function Window._FaptaBuildSummary:CollectInventory(folder)
    local inventory = {
        Wood = 0,
        Brown = 0,
        InvalidWood = 0,
        Head = 0,
        Korblox = 0,
        Firework = 0,
        Spotlights = {},
    }
    for _, spotlightName in ipairs(SPOTLIGHT_OPTIONS) do
        inventory.Spotlights[spotlightName] = 0
    end
    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Model") then
            if child.Name == TOY_NAME then
                if findMatchingSoundPart(child) then
                    inventory.Wood = inventory.Wood + 1
                else
                    inventory.InvalidWood = inventory.InvalidWood + 1
                end
            elseif child.Name == Window._FaptaWoodStyle.BrownName then
                if findBrownBoardPart(child) then
                    inventory.Brown = inventory.Brown + 1
                else
                    inventory.InvalidWood = inventory.InvalidWood + 1
                end
            elseif child.Name == HEAD_TOY_NAME then
                if getHeadModelPart(child) then
                    inventory.Head = inventory.Head + 1
                end
            elseif child.Name == KORBLOX_LEG_TOY_NAME then
                if findKorbloxLegPart(child) then
                    inventory.Korblox = inventory.Korblox + 1
                end
            elseif child.Name == FIREWORK_TOY_NAME then
                local fireworkPart = child:FindFirstChild("SoundPart")
                if fireworkPart and fireworkPart:IsA("BasePart") then
                    inventory.Firework = inventory.Firework + 1
                end
            elseif inventory.Spotlights[child.Name] ~= nil then
                local spotlightPart = child:FindFirstChild("SoundPart")
                if not spotlightPart or not spotlightPart:IsA("BasePart") then
                    spotlightPart = child.PrimaryPart
                        or child:FindFirstChildWhichIsA("BasePart", true)
                end
                if spotlightPart and spotlightPart:IsA("BasePart") then
                    inventory.Spotlights[child.Name] = inventory.Spotlights[child.Name] + 1
                end
            end
        end
    end
    return inventory
end

function Window._FaptaBuildSummary:BuildText()
    local folder, folderLabel = resolveSelectedFolder()
    -- build Toys always sets up two giants; only the first is traced in Normal mode.
    local assemblyCount = 2
    local activeGiantCount = giantMode == "Double" and 2 or 1
    local requiredWoodCount = assemblyCount * 22
    local requiredHeadCount = headlessEnabled and 0 or assemblyCount
    local requiredKorbloxCount = korbloxLegEnabled and assemblyCount or 0
    local requiredBodyCount = requiredWoodCount + requiredHeadCount + requiredKorbloxCount
    local selectedLookup = {}
    for _, spotlightName in ipairs(selectedSpotlightNames) do
        selectedLookup[spotlightName] = true
    end
    local requiredOrbitCount = 1 + #selectedSpotlightNames
    local requiredTotalCount = requiredBodyCount + requiredOrbitCount
    local lines = {
        "Source: " .. tostring(folderLabel),
        string.format(
            "Mode: %s | Built: %s | Be Giant: %s",
            giantMode,
            isBuilt
                    and string.format(
                        "YES (%d stored / %d active)",
                        #GiantAssemblies,
                        math.min(#GiantAssemblies, activeGiantCount)
                    )
                or "NO",
            isTracing and "ON" or "OFF"
        ),
        "Item: 0=NOT_FOUND | partial=ERROR | full=SUCCESS",
        "Overall: 0=ERROR | partial=ATTENTION | full=SUCCESS",
    }
    if not folder then
        table.insert(lines, "Source Status: [NOT_FOUND]")
        table.insert(
            lines,
            string.format(
                "Overall Summary: 0/%d [%s]",
                requiredTotalCount,
                self:OverallStatus(0, requiredTotalCount)
            )
        )
        table.insert(lines, "Body Composition:")
        for assemblyIndex = 1, assemblyCount do
            table.insert(lines, string.format(" Giant %d: [NOT_FOUND]", assemblyIndex))
            table.insert(lines, "  " .. self:FormatRequired("Left Arm", 0, 4))
            table.insert(lines, "  " .. self:FormatRequired("Right Arm", 0, 4))
            table.insert(lines, "  " .. self:FormatRequired("Left Leg", 0, 4))
            if korbloxLegEnabled then
                table.insert(lines, "  " .. self:FormatRequired("Right Leg (TetracubeI)", 0, 1))
                table.insert(lines, "  " .. self:FormatRequired("Reserved Right-Leg Boards", 0, 4))
            else
                table.insert(lines, "  " .. self:FormatRequired("Right Leg", 0, 4))
            end
            table.insert(lines, "  " .. self:FormatRequired("Torso", 0, 6))
            if headlessEnabled then
                table.insert(lines, "  Head (GlassBoxGray): DISABLED [SUCCESS]")
            else
                table.insert(lines, "  " .. self:FormatRequired("Head (GlassBoxGray)", 0, 1))
            end
        end
        table.insert(
            lines,
            string.format(
                "Body Overall: 0/%d [%s]",
                requiredBodyCount,
                self:OverallStatus(0, requiredBodyCount)
            )
        )
        table.insert(lines, "Orbit Materials:")
        table.insert(lines, "FireworkSparkler: 0/>=1 [NOT_FOUND]")
        for _, spotlightName in ipairs(SPOTLIGHT_OPTIONS) do
            if selectedLookup[spotlightName] then
                table.insert(lines, spotlightName .. ": 0/>=1 [NOT_FOUND]")
            else
                table.insert(lines, spotlightName .. ": 0 available [NOT_SELECTED]")
            end
        end
        table.insert(
            lines,
            string.format(
                "Orbit Overall: 0/%d [%s]",
                requiredOrbitCount,
                self:OverallStatus(0, requiredOrbitCount)
            )
        )
        return table.concat(lines, "\n")
    end

    local inventory = self:CollectInventory(folder)
    local availableBoards = math.min(inventory.Wood + inventory.Brown, requiredWoodCount)
    local availableBodyCount = availableBoards
        + math.min(inventory.Head, requiredHeadCount)
        + math.min(inventory.Korblox, requiredKorbloxCount)
    local availableOrbitCount = math.min(inventory.Firework, 1)
    for _, spotlightName in ipairs(selectedSpotlightNames) do
        availableOrbitCount = availableOrbitCount
            + math.min(inventory.Spotlights[spotlightName] or 0, 1)
    end
    local availableTotalCount = availableBodyCount + availableOrbitCount

    table.insert(lines, "Source Status: [SUCCESS]")
    table.insert(
        lines,
        string.format(
            "Overall Summary: %d/%d [%s]",
            availableTotalCount,
            requiredTotalCount,
            self:OverallStatus(availableTotalCount, requiredTotalCount)
        )
    )
    table.insert(
        lines,
        self:FormatRequired("Body boards (TwoLegs + FourLegsBrown)", inventory.Wood + inventory.Brown, requiredWoodCount)
            .. string.format(
                " | TwoLegs x%d + Brown x%d | invalid size: %d",
                inventory.Wood,
                inventory.Brown,
                inventory.InvalidWood
            )
    )
    table.insert(lines, "Body Composition:")

    local function segmentCount(availableWood, firstIndex, requiredCount)
        return math.clamp(availableWood - firstIndex + 1, 0, requiredCount)
    end

    for assemblyIndex = 1, assemblyCount do
        local availableWood = math.clamp(availableBoards - ((assemblyIndex - 1) * 22), 0, 22)
        local headCount = headlessEnabled and 0 or (inventory.Head >= assemblyIndex and 1 or 0)
        local korbloxCount = korbloxLegEnabled and (inventory.Korblox >= assemblyIndex and 1 or 0)
            or 0
        local requiredAssemblyCount = 22
            + (headlessEnabled and 0 or 1)
            + (korbloxLegEnabled and 1 or 0)
        local availableAssemblyCount = math.min(availableWood, 22) + headCount + korbloxCount
        table.insert(
            lines,
            string.format(
                " Giant %d: %d/%d [%s]",
                assemblyIndex,
                availableAssemblyCount,
                requiredAssemblyCount,
                self:OverallStatus(availableAssemblyCount, requiredAssemblyCount)
            )
        )
        table.insert(
            lines,
            "  " .. self:FormatRequired("Left Arm", segmentCount(availableWood, 1, 4), 4)
        )
        table.insert(
            lines,
            "  " .. self:FormatRequired("Right Arm", segmentCount(availableWood, 5, 4), 4)
        )
        table.insert(
            lines,
            "  " .. self:FormatRequired("Left Leg", segmentCount(availableWood, 9, 4), 4)
        )
        if korbloxLegEnabled then
            table.insert(
                lines,
                "  " .. self:FormatRequired("Right Leg (TetracubeI)", korbloxCount, 1)
            )
            table.insert(
                lines,
                "  "
                    .. self:FormatRequired(
                        "Reserved Right-Leg Boards",
                        segmentCount(availableWood, 13, 4),
                        4
                    )
            )
        else
            table.insert(
                lines,
                "  " .. self:FormatRequired("Right Leg", segmentCount(availableWood, 13, 4), 4)
            )
        end
        table.insert(
            lines,
            "  " .. self:FormatRequired("Torso", segmentCount(availableWood, 17, 6), 6)
        )
        if headlessEnabled then
            table.insert(lines, "  Head (GlassBoxGray): DISABLED [SUCCESS]")
        else
            table.insert(lines, "  " .. self:FormatRequired("Head (GlassBoxGray)", headCount, 1))
        end
    end

    table.insert(
        lines,
        string.format(
            "Body Overall: %d/%d [%s]",
            availableBodyCount,
            requiredBodyCount,
            self:OverallStatus(availableBodyCount, requiredBodyCount)
        )
    )
    table.insert(lines, "Orbit Materials:")
    table.insert(lines, self:FormatRequired(" FireworkSparkler", inventory.Firework, 1))
    table.insert(
        lines,
        string.format(
            " Firework State: %s | controlled: %d",
            fireworkSpinEnabled and "ON" or "OFF",
            #FireworkSparklers
        )
    )
    for _, spotlightName in ipairs(SPOTLIGHT_OPTIONS) do
        if selectedLookup[spotlightName] then
            table.insert(
                lines,
                self:FormatRequired(" " .. spotlightName, inventory.Spotlights[spotlightName], 1)
            )
        else
            table.insert(
                lines,
                string.format(
                    " %s: %d available [NOT_SELECTED]",
                    spotlightName,
                    inventory.Spotlights[spotlightName]
                )
            )
        end
    end
    table.insert(
        lines,
        string.format(
            " Spotlight State: %s | controlled: %d",
            spotlightSpinEnabled and "ON" or "OFF",
            #Spotlights
        )
    )
    table.insert(
        lines,
        string.format(
            "Orbit Overall: %d/%d [%s]",
            availableOrbitCount,
            requiredOrbitCount,
            self:OverallStatus(availableOrbitCount, requiredOrbitCount)
        )
    )
    return table.concat(lines, "\n")
end

function Window._FaptaBuildSummary:Refresh()
    if self.Paragraph and not self.Paragraph:IsDestroyed() then
        local success, summaryText = pcall(self.BuildText, self)
        if success then
            self.Paragraph:SetDesc(summaryText)
        else
            self.Paragraph:SetDesc("Summary update failed: " .. tostring(summaryText))
        end
    end
end

-- Build one independent assembly for Normal or two independent assemblies for Double.
function buildGiant()
    cleanupGiant()
    local folder, folderLabel = resolveSelectedFolder()
    if not folder then
        Window:Notify("BUILD ERROR", getSelectedFolderError(folderLabel), 6)
        return false
    end

    local woodStyle = Window._FaptaWoodStyle
    local woodCandidates = {}
    local brownCandidates = {}
    local headCandidates = {}
    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Model") then
            if child.Name == TOY_NAME then
                local soundPart = findMatchingSoundPart(child)
                if soundPart then
                    table.insert(woodCandidates, { Model = child, Part = soundPart })
                end
            elseif child.Name == woodStyle.BrownName then
                local boardPart = findBrownBoardPart(child)
                if boardPart then
                    table.insert(brownCandidates, { Model = child, Part = boardPart })
                end
            elseif child.Name == HEAD_TOY_NAME then
                local part = getHeadModelPart(child)
                if part then
                    table.insert(headCandidates, { Model = child, Part = part })
                end
            end
        end
    end

    -- Only boards that pass the size check are used.
    local function keepValidBoards(candidates)
        local valid = {}
        for _, candidate in ipairs(candidates) do
            if validateWoodToyPart(candidate.Part) then
                table.insert(valid, candidate)
            end
        end
        return valid
    end
    woodCandidates = keepValidBoards(woodCandidates)
    brownCandidates = keepValidBoards(brownCandidates)

    -- build Toys always sets up two giants (44 boards and 2 glass boxes). Normal mode can still
    -- start with one giant when only 22 to 43 boards are available.
    local boardTotal = #woodCandidates + #brownCandidates
    local assemblyCount = boardTotal >= 44 and 2 or 1
    local neededBoards = (assemblyCount == 2 or giantMode == "Double") and 44 or 22
    if boardTotal < neededBoards then
        Window:Notify(
            "BUILD ERROR",
            string.format(
                "%d board SoundParts with size 13.75, 7, 0.375 are required for %s; found %d TableWoodTwoLegs and %d TableWoodFourLegsBrown",
                neededBoards,
                giantMode,
                #woodCandidates,
                #brownCandidates
            ),
            7
        )
        return false
    end
    local requiredWoodCount = assemblyCount * 22

    local korbloxLegCandidates = korbloxLegEnabled and findKorbloxLegCandidates(folder) or {}
    local requiredKorbloxCount = giantMode == "Double" and 2 or 1
    if korbloxLegEnabled and #korbloxLegCandidates < requiredKorbloxCount then
        Window:Notify(
            "BUILD ERROR",
            string.format(
                "Toggle Korblox leg requires %d TetracubeI SoundParts with size 1.75, 7, 1.75; found %d",
                requiredKorbloxCount,
                #korbloxLegCandidates
            ),
            7
        )
        return false
    end

    -- Every board gets movers now, so a style swap can use any of them at any time.
    woodStyle.Pool = { Two = {}, Brown = {} }
    for _, candidate in ipairs(woodCandidates) do
        local data = makePartData(candidate.Model, candidate.Part)
        data.BoardStyle = "Two"
        data.InUse = false
        table.insert(woodStyle.Pool.Two, data)
    end
    for _, candidate in ipairs(brownCandidates) do
        local data = makePartData(candidate.Model, candidate.Part)
        data.BoardStyle = "Brown"
        data.InUse = false
        table.insert(woodStyle.Pool.Brown, data)
    end

    local function createAssembly(assemblyIndex)
        local assembly = {
            Index = assemblyIndex,
            OffsetX = giantMode == "Double" and ((assemblyIndex == 1 and -1 or 1) * giantSpacing / 2)
                or 0,
            UserOffset = giantOffsets[assemblyIndex] or Vector3.zero,
            Units = {},
            RightLegWoodParts = {},
            KorbloxRightLegParts = {},
            HeadParts = {},
            TorsoParts = {},
        }
        table.insert(GiantAssemblies, assembly)
        local function makeWoodGroup(boardCount, partName)
            local group = {}
            for _ = 1, boardCount do
                -- The wanted style first; the other style stands in when that one runs out.
                table.insert(group, woodStyle.TakeBoard(woodStyle.GetDesiredStyle(assemblyIndex, partName)))
            end
            return group
        end

        for limbIndex = 1, 3 do
            local group = makeWoodGroup(4, ({ "Left Arm", "Right Arm", "Left Leg" })[limbIndex])
            assignLimbLayout(group)
            local valid, result = validateAssemblySize(
                string.format("giant %d limb %d", assemblyIndex, limbIndex),
                group,
                LIMB_ASSEMBLY_SIZE
            )
            if not valid then
                return nil, result
            end
            assembly.Units[limbIndex] = group
        end

        assembly.RightLegWoodParts = makeWoodGroup(4, "Right Leg")
        assignLimbLayout(assembly.RightLegWoodParts)
        local rightLegValid, rightLegResult = validateAssemblySize(
            string.format("giant %d right leg", assemblyIndex),
            assembly.RightLegWoodParts,
            LIMB_ASSEMBLY_SIZE
        )
        if not rightLegValid then
            return nil, rightLegResult
        end

        if korbloxLegEnabled then
            local candidate = korbloxLegCandidates[assemblyIndex]
            if candidate then
                assembly.KorbloxRightLegParts = {
                    makeKorbloxLegData(candidate.Model, candidate.Part),
                }
                assignKorbloxLegLayout(assembly.KorbloxRightLegParts)
            end
        end

        assembly.TorsoParts = makeWoodGroup(6, "Torso")
        assignTorsoLayout(assembly.TorsoParts)
        local torsoValid, torsoResult = validateAssemblySize(
            string.format("giant %d torso", assemblyIndex),
            assembly.TorsoParts,
            TORSO_ASSEMBLY_SIZE
        )
        if not torsoValid then
            return nil, torsoResult
        end

        -- One glass box per giant.
        local headCandidate = headCandidates[assemblyIndex]
        if headCandidate then
            table.insert(assembly.HeadParts, makePartData(headCandidate.Model, headCandidate.Part))
        end
        return assembly
    end

    for assemblyIndex = 1, assemblyCount do
        local assembly, buildError = createAssembly(assemblyIndex)
        if not assembly then
            cleanupGiant()
            Window:Notify("BUILD ERROR", buildError, 7)
            return false
        end
    end

    isBuilt = true
    moveToWaitPosition()
    woodStyle.ParkSpares()
    local activeRightLegParts = korbloxLegEnabled and assemblyCount or (assemblyCount * 4)
    local headPartCount = 0
    for _, assembly in ipairs(GiantAssemblies) do
        headPartCount = headPartCount + #assembly.HeadParts
    end
    local inUseTwo, inUseBrown, spareBoards = 0, 0, 0
    for style, boards in pairs(woodStyle.Pool) do
        for _, data in ipairs(boards) do
            if data.InUse then
                if style == "Two" then
                    inUseTwo = inUseTwo + 1
                else
                    inUseBrown = inUseBrown + 1
                end
            else
                spareBoards = spareBoards + 1
            end
        end
    end
    Window:Notify(
        "GIANT BUILT",
        string.format(
            "mode %s | folder %s | giants %d | boards %d/%d (TwoLegs %d, brown %d) | spare boards %d | active right-leg parts %d | head parts %d",
            giantMode,
            folder.Name,
            assemblyCount,
            requiredWoodCount,
            requiredWoodCount,
            inUseTwo,
            inUseBrown,
            spareBoards,
            activeRightLegParts,
            headPartCount
        ),
        7
    )
    return true
end
-- Giant trace math and body-part mapping
local R6_LIMB_NAMES = {
    "Left Arm",
    "Right Arm",
    "Left Leg",
    "Right Leg",
}

-- HumanoidRootPart is the live center; Torso supplies position offset and rotation.
-- The movement toggle scales only the Torso-to-HRP XYZ offset by seven.
local function getGiantTorsoTraceCF(torso, humanoidRootPart)
    local movementScale = giantMovementScaleEnabled and POSITION_SCALE or 1
    local torsoOffsetFromCenter = torso.Position - humanoidRootPart.Position
    local scaledTorsoPosition = humanoidRootPart.Position + torsoOffsetFromCenter * movementScale
    return CFrame.new(scaledTorsoPosition) * rotationOnly(torso.CFrame)
end

local function traceHeadAsBefore(torso, head, giantTorsoCF, headParts)
    local headRelativePosition = torso.CFrame:PointToObjectSpace(head.Position)
    local scaledHeadRelativePosition = Vector3.new(
        headRelativePosition.X * POSITION_SCALE,
        (headRelativePosition.Y * 4) + 5.7,
        headRelativePosition.Z * POSITION_SCALE
    )
    local worldHeadPosition = giantTorsoCF:PointToWorldSpace(scaledHeadRelativePosition)
    local headRelativeRotation = rotationOnly(torso.CFrame:ToObjectSpace(head.CFrame))
    local headRotation = rotationOnly(giantTorsoCF)
        * headRelativeRotation
        * CFrame.Angles(math.rad(180), 0, 0)
    local headCF = CFrame.new(worldHeadPosition) * headRotation
    for _, data in ipairs(headParts) do
        local finalCF = headCF * CFrame.new(-4.5, 0, 0)
        setTarget(data, finalCF * CFrame.Angles(math.rad(90), 0, 0))
    end
end

local function getScaledRelativePartCF(sourceTorsoCF, giantTorsoCF, partCF)
    local relativeCF = sourceTorsoCF:ToObjectSpace(partCF)
    local scaledPosition = relativeCF.Position * POSITION_SCALE
    return giantTorsoCF * CFrame.new(scaledPosition) * rotationOnly(relativeCF)
end

-- Apply per-giant XYZ placement in the HumanoidRootPart's stable yaw frame.
-- X is left/right, Y is world up/down, and Z is forward/backward.
-- Torso pitch and roll still rotate each complete giant without changing its center offset.
local function applyStableYawGiantOffset(baseGiantTorsoCF, humanoidRootCF, offset)
    if offset.Magnitude < 1e-4 then
        return baseGiantTorsoCF
    end
    local rootLook = humanoidRootCF.LookVector
    local horizontalLook = Vector3.new(rootLook.X, 0, rootLook.Z)
    local horizontalRight
    if horizontalLook.Magnitude < 1e-4 then
        horizontalLook = Vector3.new(0, 0, -1)
        horizontalRight = Vector3.new(1, 0, 0)
    else
        horizontalLook = horizontalLook.Unit
        horizontalRight = Vector3.new(-horizontalLook.Z, 0, horizontalLook.X)
    end
    local centerPosition = baseGiantTorsoCF.Position
        + horizontalRight * offset.X
        + Vector3.new(0, offset.Y, 0)
        + horizontalLook * offset.Z
    return CFrame.new(centerPosition) * rotationOnly(baseGiantTorsoCF)
end

-- Wait / assemble effects (SETTING tab toggles)
--   Orbit: unused giant parts circle above the player's head (or above the giant's head while a
--          giant is traced) instead of waiting under the map.
--   Assemble: while Be Giant switches on, the giant is built group by group with a tween,
--          one step every 0.5 seconds.
-- State lives in Window._FaptaWait so the main chunk gains no extra top-level locals.
;(function()
    local Wait = Window._FaptaWait

    local function placeData(data, targetCF)
        if Util.isDataAlive(data) then
            data.BP.Position = targetCF.Position
            data.BG.CFrame = targetCF
        end
    end

    local function forEachAssemblyData(assembly, callback)
        forEachAssemblyGroup(assembly, function(group)
            for _, data in ipairs(group) do
                callback(data)
            end
        end)
    end

    -- Every giant part keeps one fixed place in the ring, whatever it is currently doing.
    local function collectAllParts()
        local list = {}
        for _, assembly in ipairs(GiantAssemblies) do
            -- The ring holds only the body boards and the glass boxes (44 boards + 2 glass),
            -- never the Korblox leg, spare boards or any other toy.
            local function addGroup(group)
                for _, data in ipairs(group or {}) do
                    list[#list + 1] = data
                end
            end
            addGroup(assembly.TorsoParts)
            addGroup(assembly.HeadParts)
            for _, limbGroup in ipairs(assembly.Units) do
                addGroup(limbGroup)
            end
            addGroup(assembly.RightLegWoodParts)
        end
        for index, data in ipairs(list) do
            data.OrbitIndex = index
        end
        Wait.AllParts = list
        Wait.OrbitCount = math.max(#list, 1)
    end

    -- The under-the-map parking spot of a part (same layout as parkGiantDataAtSlot).
    Wait.SlotCF = function(data)
        if not data.WaitSlot then
            return data.Part.CFrame
        end
        return Util.getWaitSlotCF(data.WaitSlot, WAIT_POS_Y) * (data.RotationOffset or TOY_ROTATION_OFFSET)
    end

    -- Ring around Wait.Center: fixed radius, with a vertical wave that travels with the ring.
    Wait.OrbitCF = function(data)
        local angle = os.clock() * (math.pi * 2 / Wait.OrbitPeriod)
            + ((data.OrbitIndex or 1) - 1) / Wait.OrbitCount * math.pi * 2
        local position = Wait.Center
            + Vector3.new(
                math.cos(angle) * Wait.OrbitRadius,
                math.sin(angle * Wait.WaveCycles) * Wait.WaveHeight,
                math.sin(angle) * Wait.OrbitRadius
            )
        -- Face the direction of travel: the part's front (-Z) follows the ring's tangent,
        -- including the slope of the vertical wave. Wait.FaceOffset turns it further if the
        -- part's own "front" is a different side.
        local tangent = Vector3.new(
            -math.sin(angle) * Wait.OrbitRadius,
            math.cos(angle * Wait.WaveCycles) * Wait.WaveCycles * Wait.WaveHeight,
            math.cos(angle) * Wait.OrbitRadius
        )
        return CFrame.lookAt(position, position + tangent) * Wait.FaceOffset
    end

    Wait.WaitCF = function(data)
        if Wait.Orbit and data.OrbitIndex then
            return Wait.OrbitCF(data)
        end
        return Wait.SlotCF(data)
    end

    Wait.ClearBlend = function()
        for _, assembly in ipairs(GiantAssemblies) do
            forEachAssemblyData(assembly, function(data)
                data.BlendAlpha = nil
                data.BlendFromCF = nil
            end)
        end
    end

    Wait.BeginAssemble = function()
        Wait.ReleaseStart = nil
        Wait.ClearBlend()
        Wait.AssembleStart = Wait.Assemble and os.clock() or nil
    end

    Wait.CancelAssemble = function()
        Wait.AssembleStart = nil
        Wait.ClearBlend()
    end

    -- Orbit center while no giant is traced: 25 studs above the player's head.
    local function updatePlayerCenter()
        local character = LP.Character
        local head = character and character:FindFirstChild("Head")
        if not head then
            return false
        end
        Wait.Center = head.Position + Vector3.new(0, Wait.OrbitHeight, 0)
        return true
    end

    -- Giant not traced: every part circles the player's head.
    Wait.OrbitAll = function()
        if not updatePlayerCenter() then
            return
        end
        collectAllParts()
        for _, data in ipairs(Wait.AllParts) do
            placeData(data, Wait.OrbitCF(data))
        end
    end

    -- Be Giant switched off with Tween Assemble on: every part glides from where the giant had
    -- it to its waiting spot (the ring when Orbit is on, otherwise under the map).
    Wait.BeginRelease = function()
        collectAllParts()
        for _, data in ipairs(Wait.AllParts) do
            if data.Part and data.Part.Parent and data.BP and data.BG then
                data.ReleaseFromCF = CFrame.new(data.BP.Position) * rotationOnly(data.BG.CFrame)
            else
                data.ReleaseFromCF = nil
            end
        end
        Wait.ReleaseStart = os.clock()
    end

    -- Runs every frame while no giant is traced (release glide, then the orbit ring).
    Wait.WaitFrame = function()
        local releaseStart = Wait.ReleaseStart
        if not releaseStart then
            if Wait.Orbit then
                Wait.OrbitAll()
            end
            return
        end
        local centerReady = updatePlayerCenter()
        collectAllParts()
        local alpha = math.clamp((os.clock() - releaseStart) / Wait.ReleaseTime, 0, 1)
        local eased = alpha * alpha * (3 - 2 * alpha)
        if centerReady or not Wait.Orbit then
            for _, data in ipairs(Wait.AllParts) do
                if data.ReleaseFromCF then
                    placeData(data, data.ReleaseFromCF:Lerp(Wait.WaitCF(data), eased))
                end
            end
        end
        if alpha >= 1 then
            Wait.ReleaseStart = nil
            for _, data in ipairs(Wait.AllParts) do
                data.ReleaseFromCF = nil
            end
            Window._FaptaSword.Park()
            if not Wait.Orbit then
                moveToWaitPosition()
            end
        end
    end

    -- Called at the start of every traced frame: finds the giant head, then sets the tween
    -- progress of each group (torso, head, right arm, left arm, left leg, right leg).
    Wait.BeginTraceFrame = function(baseGiantTorsoCF, humanoidRootCF)
        local firstAssembly = GiantAssemblies[1]
        if not firstAssembly then
            return
        end
        local offset = Vector3.new(firstAssembly.OffsetX, 0, 0) + firstAssembly.UserOffset
        local giantTorsoCF = applyStableYawGiantOffset(baseGiantTorsoCF, humanoidRootCF, offset)
        Wait.GiantTorsoCF = giantTorsoCF
        local headPosition = (giantTorsoCF * CFrame.new(0, 10.5, 0)).Position
            + Vector3.new(0, TORSO_TRACE_Y_OFFSET, 0)
        Wait.Center = headPosition + Vector3.new(0, Wait.OrbitHeight, 0)
        collectAllParts()
        local startTime = Wait.AssembleStart
        if not startTime then
            return
        end
        local elapsed = os.clock() - startTime
        local finished = true
        for assemblyIndex, assembly in ipairs(GiantAssemblies) do
            if giantMode == "Double" or assemblyIndex == 1 then
                local stages = {}
                local function addStage(group)
                    if group then
                        stages[#stages + 1] = group
                    end
                end
                addStage(assembly.TorsoParts)
                addStage(assembly.HeadParts)
                addStage(assembly.Units[2])
                addStage(assembly.Units[1])
                addStage(assembly.Units[3])
                addStage(korbloxLegEnabled and assembly.KorbloxRightLegParts or assembly.RightLegWoodParts)
                for stage, group in ipairs(stages) do
                    local alpha = math.clamp(
                        (elapsed - (stage - 1) * Wait.StepTime) / Wait.StepTime,
                        0,
                        1
                    )
                    for _, data in ipairs(group) do
                        if alpha < 1 then
                            data.BlendAlpha = alpha
                            data.BlendFromCF = Wait.WaitCF(data)
                            finished = false
                        else
                            data.BlendAlpha = nil
                            data.BlendFromCF = nil
                        end
                    end
                end
            end
        end
        if finished then
            Wait.AssembleStart = nil
        end
    end

    -- Called after the traced groups are placed: parts that are not part of the traced giant
    -- (second giant in Normal mode, the unused right-leg set, the head while headless) circle
    -- the giant's head the same way.
    Wait.EndTraceFrame = function()
        if not Wait.Orbit then
            return
        end
        for assemblyIndex, assembly in ipairs(GiantAssemblies) do
            local function orbitGroup(group)
                if group then
                    for _, data in ipairs(group) do
                        placeData(data, Wait.OrbitCF(data))
                    end
                end
            end
            if giantMode == "Double" or assemblyIndex == 1 then
                orbitGroup(korbloxLegEnabled and assembly.RightLegWoodParts or assembly.KorbloxRightLegParts)
                if headlessEnabled then
                    orbitGroup(assembly.HeadParts)
                end
            else
                forEachAssemblyGroup(assembly, orbitGroup)
            end
        end
    end
end)()

function tracePlayer()
    local character = LP.Character
    if not character then
        return
    end
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    if not torso or not humanoidRootPart or not head then
        return
    end
    local baseGiantTorsoCF = getGiantTorsoTraceCF(torso, humanoidRootPart)
    local limbAxisAlignment = CFrame.Angles(0, 0, math.rad(90))
    Window._FaptaWait.BeginTraceFrame(baseGiantTorsoCF, humanoidRootPart.CFrame)
    for assemblyIndex, assembly in ipairs(GiantAssemblies) do
        if giantMode == "Double" or assemblyIndex == 1 then
            local totalOffset = Vector3.new(assembly.OffsetX, 0, 0) + assembly.UserOffset
            local giantTorsoCF =
                applyStableYawGiantOffset(baseGiantTorsoCF, humanoidRootPart.CFrame, totalOffset)
            local limbTargetCFs = {}
            for index, limbName in ipairs(R6_LIMB_NAMES) do
                local limb = character:FindFirstChild(limbName)
                if limb then
                    limbTargetCFs[index] = getScaledRelativePartCF(
                        torso.CFrame,
                        giantTorsoCF,
                        limb.CFrame
                    ) * limbAxisAlignment
                end
            end
            if Window._FaptaSword.Animate then
                -- Sword draw / sheathe animation moves the giant right arm only.
                limbTargetCFs[2] = Window._FaptaSword.Animate(assemblyIndex, giantTorsoCF, limbTargetCFs[2])
            end
            setGroupTarget(assembly.TorsoParts, giantTorsoCF)
            for index, _ in ipairs(R6_LIMB_NAMES) do
                local group
                if index == 4 then
                    group = korbloxLegEnabled and assembly.KorbloxRightLegParts
                        or assembly.RightLegWoodParts
                else
                    group = assembly.Units[index]
                end
                local targetCF = limbTargetCFs[index]
                if group and targetCF then
                    setGroupTarget(group, targetCF)
                end
            end
            if not headlessEnabled then
                traceHeadAsBefore(torso, head, giantTorsoCF, assembly.HeadParts)
            end
            if Window._FaptaSword.Update then
                -- Back mount uses the giant torso; Arm Tip mount uses the giant right arm (index 2).
                Window._FaptaSword.Update(assemblyIndex, giantTorsoCF, limbTargetCFs[2])
            end
        end
    end
    Window._FaptaWait.EndTraceFrame()
end

function refreshGiantAssemblyPlacement()
    for assemblyIndex, assembly in ipairs(GiantAssemblies) do
        assembly.OffsetX = giantMode == "Double"
                and ((assemblyIndex == 1 and -1 or 1) * giantSpacing / 2)
            or 0
        assembly.UserOffset = giantOffsets[assemblyIndex] or Vector3.zero
    end
    if not isBuilt then
        return
    end
    if isTracing then
        if giantMode == "Normal" and GiantAssemblies[2] then
            moveAssemblyToWaitPosition(GiantAssemblies[2], 2)
        end
        tracePlayer()
    else
        moveToWaitPosition()
    end
end

-- Restartable inline auto-save workflow
local function notifyAutoSave(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = Window:_FaptaTranslateText(title),
            Text = Window:_FaptaTranslateText(text),
            Duration = 3,
        })
    end)
end

local function restoreAutoSaveState(state)
    if not state then
        return
    end
    local ocarina = state.Ocarina
    if
        (not ocarina or not ocarina.Parent)
        and state.SpawnRequested
        and not state.OcarinaDestroyed
    then
        local toyFolder = Workspace:FindFirstChild(LP.Name .. "SpawnedInToys")
        ocarina = toyFolder and toyFolder:FindFirstChild("InstrumentWoodwindOcarina")
    end
    if ocarina and ocarina.Parent and state.DestroyToy and not state.OcarinaDestroyed then
        pcall(function()
            state.DestroyToy:FireServer(ocarina)
        end)
        state.OcarinaDestroyed = true
    end
    if state.Humanoid and state.Humanoid.Parent then
        state.Humanoid.WalkSpeed = state.OriginalWalkSpeed
    end
    if state.HRP and state.HRP.Parent then
        state.HRP.CFrame = state.OriginalPos
    end
end

local function resetAutoSaveProgress()
    autoSaveSession = autoSaveSession + 1
    local previousThread = autoSaveThread
    local previousState = autoSaveActiveState
    autoSaveRunning = false
    autoSaveThread = nil
    autoSaveActiveState = nil
    restoreAutoSaveState(previousState)
    if previousThread and previousThread ~= coroutine.running() then
        pcall(function()
            task.cancel(previousThread)
        end)
    end
end

function runAutoSave()
    if autoSaveRunning then
        resetAutoSaveProgress()
        Window:Notify("Console", "auto save progress reset; restarting", 3)
    end
    autoSaveSession = autoSaveSession + 1
    local session = autoSaveSession
    autoSaveRunning = true
    autoSaveThread = coroutine.running()
    local plotItems = Workspace:FindFirstChild("PlotItems")
    if plotItems then
        local playersInPlots = plotItems:FindFirstChild("PlayersInPlots")
        if playersInPlots and playersInPlots:FindFirstChild(LP.Name) then
            notifyAutoSave("error", "get out this house")
            autoSaveRunning = false
            autoSaveThread = nil
            return
        end
    end
    local character = LP.Character
    if not character then
        notifyAutoSave("error", "errorcode:10223")
        autoSaveRunning = false
        autoSaveThread = nil
        return
    end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        notifyAutoSave("error", "HumanoidRootPart")
        autoSaveRunning = false
        autoSaveThread = nil
        return
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        notifyAutoSave("error", "unknown number response")
        autoSaveRunning = false
        autoSaveThread = nil
        return
    end
    local menuToys = ReplicatedStorage:FindFirstChild("MenuToys")
    if not menuToys then
        notifyAutoSave("error", "MenuToys")
        autoSaveRunning = false
        autoSaveThread = nil
        return
    end
    local spawnToyRemoteFunction = menuToys:FindFirstChild("SpawnToyRemoteFunction")
    local destroyToy = menuToys:FindFirstChild("DestroyToy")
    if not spawnToyRemoteFunction or not destroyToy then
        notifyAutoSave("error", "unknown error")
        autoSaveRunning = false
        autoSaveThread = nil
        return
    end
    local originalPos = hrp.CFrame
    local originalWalkSpeed = humanoid.WalkSpeed
    local runState = {
        HRP = hrp,
        Humanoid = humanoid,
        OriginalPos = originalPos,
        OriginalWalkSpeed = originalWalkSpeed,
        DestroyToy = destroyToy,
        SpawnRequested = false,
        Ocarina = nil,
        OcarinaDestroyed = false,
    }
    autoSaveActiveState = runState
    local function ensureCurrentSession()
        if session ~= autoSaveSession then
            error("auto save restarted", 0)
        end
    end
    local success, err = pcall(function()
        humanoid.WalkSpeed = 0
        ensureCurrentSession()
        runState.SpawnRequested = true
        spawnToyRemoteFunction:InvokeServer(
            "InstrumentWoodwindOcarina",
            CFrame.new(184.148834, -5.54824972, 498.136749),
            Vector3.new(0, 34, 0)
        )
        task.wait(0.4)
        ensureCurrentSession()
        local toyFolder = Workspace:FindFirstChild(LP.Name .. "SpawnedInToys")
        local ocarina = toyFolder and toyFolder:FindFirstChild("InstrumentWoodwindOcarina")
        if not ocarina or not ocarina:FindFirstChild("HoldPart") then
            error("cant find this")
        end
        runState.Ocarina = ocarina
        ocarina.HoldPart.HoldItemRemoteFunction:InvokeServer(ocarina, Workspace[LP.Name])
        ensureCurrentSession()
        hrp.CFrame = CFrame.new(304.06, 25.77, 488.54)
        task.wait(0.21)
        ensureCurrentSession()
        destroyToy:FireServer(ocarina)
        runState.OcarinaDestroyed = true
        runState.Ocarina = nil
        hrp.CFrame = originalPos
        task.wait(0.7)
        ensureCurrentSession()
        spawnToyRemoteFunction:InvokeServer(
            "Campfire",
            CFrame.new(257.638672, -5.57392979, 450.103638),
            Vector3.new(0, 161.972)
        )
    end)
    if session ~= autoSaveSession then
        return
    end
    restoreAutoSaveState(runState)
    autoSaveRunning = false
    autoSaveThread = nil
    autoSaveActiveState = nil
    if success then
        notifyAutoSave("Success", "saved")
    else
        notifyAutoSave("Error", "try again later")
        warn("[fapta] auto save failed:", err)
    end
end

-- DEFENSE tab, part 2 (logic): loads the ported defense engine in its own thread (separately
-- compiled and error-checked) and attaches it to the controls built above.
;(function()
    local controls = Window._FaptaDefenseControls
    local ENGINE_SOURCE = [=====[
local FapDefenseEnv = getgenv().__FAPTA_DEFENSE_ENV
local FapDefenseWindow = FapDefenseEnv.Window
local FapDefenseControls = FapDefenseEnv.Controls
local FapDefenseErrors = {}
-- Every start-up statement of the ported engine runs through this guard, so one failing statement
-- is reported (console + summary notice) instead of stopping the whole engine.
local function FapGuard(sourceLine, run)
    local ok, err = pcall(run)
    if not ok then
        FapDefenseErrors[#FapDefenseErrors + 1] = "line " .. tostring(sourceLine) .. ": " .. tostring(err)
        warn("[fapta] DEFENSE engine statement failed (source line " .. tostring(sourceLine) .. "):", err)
    end
end
local requireModule, reloadPath, registerCleanup = nil
local gethui = gethui or get_hidden_gui or function() return game:GetService("CoreGui") end
do
local StarterGui, fn17, flag11, lib, lib2, lib3, options, toggles, Players, Lighting
local UserInputService, ReplicatedStorage, RunService, PhysicsService, HttpService, terrain, map, alwaysHereTweenedObjects, localPlayer, currentCamera
local fieldOfView, cFrame, mouse, v17, v18, parent, screenGui, part2, textButton, part3
local tbl6, n34, n35, tbl7, fn18, tbl8, tbl9, fn19, tbl10, tbl11
local tbl12, fn20, tbl13, tbl14, v19, tbl15
do
-- Compatibility layer: the ported engine expects the Resonance UI library (lib / toggles /
-- options). The DEFENSE tab controls already exist (built by the main script), so these tables
-- simply expose them. Notifications are routed to HertaIX.
lib = {
    Options = FapDefenseControls.Options,
    Toggles = FapDefenseControls.Toggles,
    Labels = FapDefenseControls.Labels,
    IsMobile = game:GetService("UserInputService").TouchEnabled
        and not game:GetService("UserInputService").KeyboardEnabled,
    ScreenGui = Instance.new("Folder"),
    Notify = function(_, info)
        info = info or {}
        FapDefenseWindow:Notify(info.Title or "Defense", tostring(info.Description or ""), info.Time or 5)
    end,
    GiveSignal = function(_, signal)
        return signal
    end,
    Unload = function() end,
}
options = lib.Options
toggles = lib.Toggles

local placeId, now2, scriptKey, fallenPartsDestroyHeight, TextChatService, ContextActionService, GuiService, Stats2, Debris, TeleportService
local jobId, playerGui, isHeld, inPlot, inOwnedPlot, rbxGeneral, v20, highlight, v21
do
local train, v22, selectionBox, particleEmitter
do
do
do
do
do
FapGuard(17195, function()
StarterGui = game:GetService("StarterGui")
end)
FapGuard(17197, function()
fn17 = function(arg, arg2, arg3)
									StarterGui:SetCore("SendNotification", {
										Title = arg or "Resonance",
										Text = arg2 or "Notification",
										Duration = arg3 or 5,
										Icon = "rbxassetid://79685990879972",
									})
								end
end)
FapGuard(17206, function()
placeId = game.PlaceId
end)
FapGuard(17218, function()
now2 = tick()
end)
FapGuard(17220, function()
scriptKey = nil
end)
FapGuard(17221, function()
flag11 = false
end)
FapGuard(17222, function()
fallenPartsDestroyHeight = (0/0)
end)
end
FapGuard(17249, function()
lib = requireModule("Library")
end)
FapGuard(17250, function()
lib2 = requireModule("ThemeManager")
end)
FapGuard(17251, function()
lib3 = requireModule("SaveManager")
end)
end
FapGuard(17261, function()
options = lib.Options
end)
FapGuard(17262, function()
toggles = lib.Toggles
end)
FapGuard(17263, function()
Players = game:GetService("Players")
end)
FapGuard(17264, function()
Lighting = game:GetService("Lighting")
end)
FapGuard(17265, function()
UserInputService = game:GetService("UserInputService")
end)
FapGuard(17266, function()
ReplicatedStorage = game:GetService("ReplicatedStorage")
end)
FapGuard(17267, function()
RunService = game:GetService("RunService")
end)
FapGuard(17268, function()
TextChatService = game:GetService("TextChatService")
end)
FapGuard(17269, function()
PhysicsService = game:GetService("PhysicsService")
end)
FapGuard(17270, function()
ContextActionService = game:GetService("ContextActionService")
end)
FapGuard(17271, function()
GuiService = game:GetService("GuiService")
end)
FapGuard(17272, function()
Stats2 = game:GetService("Stats")
end)
FapGuard(17273, function()
Debris = game:GetService("Debris")
end)
do
FapGuard(17279, function()
TeleportService = game:GetService("TeleportService")
end)
FapGuard(17280, function()
HttpService = game:GetService("HttpService")
end)
FapGuard(17281, function()
terrain = workspace.Terrain
end)
FapGuard(17282, function()
map = workspace:WaitForChild("Map", 30)
end)
FapGuard(17283, function()
alwaysHereTweenedObjects = map and map:WaitForChild("AlwaysHereTweenedObjects", 30)
end)
FapGuard(17284, function()
train = alwaysHereTweenedObjects and alwaysHereTweenedObjects:WaitForChild("Train", 15)
end)
FapGuard(17286, function()
jobId = game.JobId
end)
FapGuard(17287, function()
localPlayer = Players.LocalPlayer
end)
FapGuard(17288, function()
currentCamera = workspace.CurrentCamera
end)
FapGuard(17289, function()
fieldOfView = currentCamera.FieldOfView
end)
FapGuard(17291, function()
cFrame = nil
end)
FapGuard(17292, function()
mouse = localPlayer:GetMouse()
end)
FapGuard(17293, function()
v17 = workspace:WaitForChild(localPlayer.Name .. "SpawnedInToys", 30)
end)
FapGuard(17294, function()
playerGui = localPlayer:WaitForChild("PlayerGui", 30)
end)
FapGuard(17295, function()
isHeld = localPlayer:WaitForChild("IsHeld", 30)
end)
FapGuard(17296, function()
inPlot = localPlayer:WaitForChild("InPlot", 30)
end)
FapGuard(17297, function()
inOwnedPlot = localPlayer:WaitForChild("InOwnedPlot", 30)
end)
end
end
local remoteEvent
do
do
local channels = TextChatService:FindFirstChild("TextChannels")
FapGuard(17311, function()
rbxGeneral = channels and channels:FindFirstChild("RBXGeneral")
end)
FapGuard(17312, function()
v20 = nil
end)
FapGuard(17313, function()
v18 = nil
end)
FapGuard(17314, function()
remoteEvent = nil
end)
FapGuard(17315, function()
v22 = nil
end)
FapGuard(17316, function()
parent = nil
end)
FapGuard(17319, function()
screenGui = Instance.new("ScreenGui")
end)
FapGuard(17320, function()
screenGui.Name = "RSC"
end)
FapGuard(17321, function()
screenGui.ResetOnSpawn = false
end)
FapGuard(17322, function()
screenGui.IgnoreGuiInset = true
end)
FapGuard(17323, function()
screenGui.Parent = gethui()
end)
FapGuard(17324, function()
highlight = Instance.new("Highlight")
end)
FapGuard(17325, function()
highlight.Enabled = false
end)
FapGuard(17326, function()
highlight.FillColor = Color3.fromRGB(255, 0, 0)
end)
FapGuard(17327, function()
highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
end)
FapGuard(17328, function()
highlight.FillTransparency = 0
end)
FapGuard(17329, function()
highlight.OutlineTransparency = 0
end)
FapGuard(17330, function()
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end)
FapGuard(17331, function()
selectionBox = Instance.new("SelectionBox")
end)
FapGuard(17332, function()
selectionBox.LineThickness = 0.04
end)
FapGuard(17333, function()
selectionBox.Transparency = 0
end)
FapGuard(17334, function()
selectionBox.SurfaceTransparency = 0.5
end)
FapGuard(17335, function()
selectionBox.Color3 = Color3.new(0, 0, 0)
end)
FapGuard(17336, function()
selectionBox.Visible = false
end)
FapGuard(17337, function()
part2 = Instance.new("Part")
end)
FapGuard(17338, function()
part2.Name = "partcieslyes"
end)
FapGuard(17339, function()
part2.Transparency = 1
end)
FapGuard(17340, function()
part2.CanCollide = false
end)
FapGuard(17341, function()
part2.CanQuery = false
end)
FapGuard(17342, function()
part2.CanTouch = false
end)
FapGuard(17343, function()
part2.Anchored = true
end)
FapGuard(17344, function()
part2.Parent = workspace
end)
FapGuard(17345, function()
particleEmitter = Instance.new("ParticleEmitter")
end)
FapGuard(17346, function()
particleEmitter.Enabled = false
end)
FapGuard(17347, function()
particleEmitter.Parent = part2
end)
FapGuard(17348, function()
particleEmitter.Shape = Enum.ParticleEmitterShape.Box
end)
FapGuard(17349, function()
particleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
end)
FapGuard(17350, function()
particleEmitter.LightEmission = 0
end)
FapGuard(17351, function()
particleEmitter.LightInfluence = 0
end)
FapGuard(17352, function()
particleEmitter.ZOffset = 0
end)
FapGuard(17353, function()
textButton = Instance.new("TextButton")
end)
FapGuard(17354, function()
textButton.BackgroundTransparency = 1
end)
FapGuard(17355, function()
textButton.Modal = false
end)
FapGuard(17356, function()
textButton.Size = UDim2.fromScale(0, 0)
end)
FapGuard(17357, function()
textButton.AnchorPoint = Vector2.zero
end)
FapGuard(17358, function()
textButton.Text = ""
end)
FapGuard(17359, function()
textButton.ZIndex = -999
end)
FapGuard(17360, function()
textButton.Parent = Instance.new("ScreenGui", localPlayer.PlayerGui)
end)
FapGuard(17361, function()
part3 = Instance.new("Part")
end)
FapGuard(17362, function()
part3.Name = "Safe Platform"
end)
FapGuard(17363, function()
part3.Size = Vector3.new(250, 5, 250)
end)
do
local random = math.random
FapGuard(17367, function()
part3.Position = Vector3.new(math.random(-25000, 25000), -500, random(-25000, 25000))
end)
end
end
FapGuard(17371, function()
part3.Anchored = true
end)
FapGuard(17372, function()
part3.CanCollide = true
end)
FapGuard(17373, function()
part3.Material = Enum.Material.Neon
end)
FapGuard(17374, function()
part3.Parent = workspace
end)
FapGuard(17375, function()
tbl6 = { Gui = Instance.new("ScreenGui") }
end)
FapGuard(17396, function()
v21 = nil
end)
FapGuard(17397, function()
n34 = 97643101798871
end)
FapGuard(17398, function()
n35 = 1
end)
FapGuard(17399, function()
tbl7 = nil
end)
FapGuard(17401, function()
fn18 = function(arg, arg2, arg3, arg4, arg5)
							if flag11 or not arg5 and tbl7 and not tbl7.NotificationSettings.Enabled then
								return
							end

							lib:Notify({
								Title = arg2 or "Resonance",
								Description = arg,
								Time = arg4 or 5,
								SoundId = arg3 or n34,
								BigIcon = "rbxassetid://79685990879972",
								Volume = n35,
								IconColor = Color3.new(1, 1, 1),
							})
						end
end)
FapGuard(17425, function()
tbl8 = {
							WalkSpeed = false,
							JumpPower = false,
							InfJump = false,
							Noclip = false,
							Flight = false,
							MoreLineExtend = false,
							SuperStrength = false,
							Desync = false,
							JerkOff = false,
							LoopTpLocation = false,
							AutoSeatBlobman = false,
							FreezeBlobman = false,
							NetworkOwnerInKick = false,
							DeleteShurInBlobK = true,
							AntiGrab = false,
							GucciAntiGrab = false,
							AntiBurn = false,
							AntiExplosion = false,
							AntiKick = false,
							AntiKick2 = false,
							AntiPaint = false,
							AntiBlobman = false,
							AutoAntiLag = true,
							AntiInputLag = false,
							AntiSticky = false,
							AntiShurikenLag = false,
							AntiBanana = false,
							AntiSnowball = false,
							AntiVoid = false,
							AutoReset = true,
							AutoLeave = true,
							LoopTP = false,
							CounterAttack = false,
							DestroyVoid = false,
							LoopApplyMethod = false,
							LoopApplyMethodServer = false,
							LoopApplyMethodT = false,
							LoopApplyMethodTServer = false,
							RagdollInNK = true,
							RagdollInRG = false,
							DeleteShurInNK = true,
							EKI = false,
							AutoHouse = false,
							Invisibility = false,
							GradientLine = false,
							AutoSlot = false,
							ControllingSomeone = false,
							AutoClicker = false,
							RagdollInAC = true,
							IndependentACPoses = false,
							CustomACPoseCenter = false,
							PlayerESP = false,
							PCLDESP = false,
							SmoothPCLD = true,
							StickyESP = false,
							BlackholeESP = false,
							Shaders = false,
							ChinaHat = false,
							Zoom = false,
							SmoothClickTP = true,
							CustomLine = false,
							CustomCrosshair = false,
							CameraNoclip = false,
							ForcefieldChar = false,
							CustomBlackHole = false,
							CustomBlackholeSound = false,
							BlackholeStaying = false,
							GOI = false,
							NonSwimmableWater = false,
							Grab = false,
							Aura = false,
							ExcludeTarget = true,
							ToyAuras = false,
							AuraVisualizer = false,
							ToyAuraVisualizer = false,
							SilentAim = false,
							SilentAimFOV = false,
							SilentAimIgnoreWhitelist = true,
							SilentAimTargetsOnly = false,
							PositionPrediction = false,
							DirectGrab = false,
							LagServer = false,
							PacketLagServer = false,
							AutoExplodeTarget = false,
							CoconutForms = false,
							BreakAllHoldables = false,
							HighlightBrokenParts = false,
							LoopApplyMethodEFServer = false,
							LoopApplyMethodEF = false,
							AutoClaimPlot = false,
							SoundSpam = false,
							FasterEscape = false,
							AutoServerHop = false,
							ServerHopIncludeFull = false,
							AutoRejoin = false,
							RejoinWithAntiLag = true,
							RejoinWithScript = false,
							OnlyAssignedKeybinds = false,
							WhitelistedBypass = false,
							AutoWhitelistFriends = false,
							ImmunityAntiGrab = false,
							ImmunityAntiKick = false,
							ImmunityAntiExplosion = false,
						}
end)
FapGuard(17531, function()
tbl9 = {
							WalkSpeed = 16,
							JumpPower = 24,
							FlightSpeed = 1,
							SpinSpeed = 15,
							LineDistance = 0,
							IncreaseLineDistance = 1,
							SuperStrength = 400,
							CounterMethod = "Kill",
							ExplosionMethod = "BombMissile",
							MissilesToFire = 1,
							TargetedLimbAura = "All",
							TargetedLimbCA = "All",
							TargetedLimbTE = "All",
							SAIMHitbox = 10,
							SAIMRadius = 250,
							AutoClickerOffset = CFrame.new(0, 0, -5),
							AutoClickerTransparency = 0,
							SelectedACPose = "Default",
							CustomACPresetName = "",
							AntiLagSens = 3,
							InputLgDelay = 0.05,
							GucciType = "CreatureBlobman",
							AKType = "Shuriken",
							AntiInputType = "FoodHamburger",
							FasterEscape = 3,
							AGType = "Normal",
							AILTransparency = 1,
							UnstickGrab = "All Toys Near",
							BlobMethod = "Kick",
							BKMethod = 1,
							NKOffset = 15,
							NKDelayMode = "Normal",
							KickServerMethod = "Circle + Lag",
							KickFlags = 0,
							AuraDistance = 25,
							ToyAuraDistance = 31,
							CustomLine = "Chain 2",
							CustomCrosshairSize = 32,
							CustomCrosshairColor = Color3.new(1, 1, 1),
							CustomBlackhole = "rbxassetid://9920612764",
							CustomBHColor = Color3.new(1, 1, 1),
							CursorIconSize = 20,
							CursorIconColor = Color3.new(1, 1, 1),
							ChinaHatColor = Color3.fromRGB(255, 170, 70),
							ForcefieldColor = Color3.new(1, 1, 1),
							ZoomFOV = 20,
							ZoomMinFOV = 10,
							ZoomMaxFOV = 120,
							ZoomStep = 5,
							ZoomCameraSmoothness = 9,
							WaterYOffset = -4,
							AspectRatio = 1,
							TeleportLocation = workspace.Waypoints.BlueHouse,
							SoundsExternalDelay = 0.1,
							CustomNotificationSound = "97643101798871",
							ShiftLockKey = "LeftAlt",
							IsBarrierBroken = false,
							LagLines = 11,
							BlackHoles = 0,
							Packets = 0.35,
							PacketPrefix = "RSC | ",
							PacketDelay = 0.1,
							LoboStrength = 166.6,
							AutoServerHopTime = 30,
							ServerHopMinPlayers = 0,
							ServerHopMaxPlayers = Players.MaxPlayers,
							ServerHopSort = "Closest Datacenter",
							ServerHopRegion = "Automatic",
						}
end)
FapGuard(17602, function()
tbl7 = {
							Whitelisted = {},
							SelectedPlayers = {},
							SelectedPlayersBlob = {},
							SelectedPlayersExp = {},
							SelectedPlayersAC = {},
							SelectedPlayersEffect = {},
							SelectedTeleportPlayers = {},
							SelectedToysAuraPlayers = {},
							SelectedSilentAimPlayers = {},
							AdminImmune = {},
							PlayerDropdowns = {},
							PlayerList = Players:GetPlayers(),
							LineTypes = {
								Laser = "rbxassetid://8922958725",
								Chain = "rbxassetid://81358145120405",
								["Chain 2"] = "rbxassetid://132910145874066",
								["Chain 3"] = "rbxassetid://128466395060514",
								["Chain 4"] = "rbxassetid://73368670987191",
								Pulse = "rbxassetid://82163767314193",
								Rope = "rbxassetid://78999022056924",
								Dots = "rbxassetid://9169659357",
								Bubbles = "rbxassetid://1249690853",
								Spring = "rbxassetid://18837732116",
								Gamepass = "rbxassetid://8933355899",
								["Non-Gamepass"] = "rbxassetid://8933346550",
							},
							AutoClicker = {},
							AutoClickerTargetPoses = {},
							SelectedACPoseCenters = {},
							CustomACPresets = {},
							ACOffset = {
								["Right Leg"] = Vector3.new(0, 1, 0),
								["Left Leg"] = Vector3.new(0, 1, 0),
								["Right Arm"] = Vector3.new(1, 0.5, 0),
								["Left Arm"] = Vector3.new(-1, 0.5, 0),
								Head = Vector3.new(0, 1, 0),
							},
							ACRotation = {
								["Right Arm"] = Vector3.zero,
								["Left Arm"] = Vector3.zero,
								["Right Leg"] = Vector3.zero,
								["Left Leg"] = Vector3.zero,
								Head = Vector3.zero,
								Torso = Vector3.zero,
							},
							AutoClickerPoses = {
								Default = {
									["Right Arm"] = { 0, 0, 0 },
									["Left Arm"] = { 0, 0, 0 },
									["Right Leg"] = { 0, 0, 0 },
									["Left Leg"] = { 0, 0, 0 },
									Head = { 0, 0, 0 },
									Torso = { 0, 0, 0 },
									BodyPos = { 0, 0, -5 },
								},
								["Shoulder-Sitting"] = {
									["Right Arm"] = { 30, 0, -40 },
									["Left Arm"] = { 30, 0, 40 },
									["Right Leg"] = { 76, 7, 29 },
									["Left Leg"] = { 76, 7, -29 },
									Head = { -20, 0, 0 },
									Torso = { 8, 0, 0 },
									BodyPos = { 0, 2.3, 1 },
								},
								["JoJo Stand"] = {
									["Right Arm"] = { -16, 0.3, -6.7 },
									["Left Arm"] = { -2, 0, 0 },
									["Right Leg"] = { -16, 22.5, -1 },
									["Left Leg"] = { -18.4, 40, -2 },
									Head = { -21.9, 17.8, 0 },
									Torso = { 9.6, 27.1, 0 },
									BodyPos = { -2.8, 1.3, 2.75 },
								},
								Blowjob = {
									["Right Arm"] = { 90, 0, 0 },
									["Left Arm"] = { 90, 0, 0 },
									["Right Leg"] = { -95, 0, 15 },
									["Left Leg"] = { -95, 0, -15 },
									Head = { -25, 0, 0 },
									Torso = { 0, 0, 0 },
									BodyPos = { 0, -2.1, -1.4 },
								},
								["Standing Sex"] = {
									["Right Arm"] = { 110, 0, -30 },
									["Left Arm"] = { 110, 0, 30 },
									["Right Leg"] = { 75, 0, 20 },
									["Left Leg"] = { 75, 0, -20 },
									Head = { -10, 0, 0 },
									Torso = { 0, 0, 0 },
									BodyPos = { 0, 0, -1.2 },
								},
								["Doggy-Pose Sex"] = {
									["Right Arm"] = { 100, 0, 0 },
									["Left Arm"] = { 100, 0, 0 },
									["Right Leg"] = { 90, 0, 40 },
									["Left Leg"] = { 90, 0, -40 },
									Head = { 90, 0, 0 },
									Torso = { 100, -180, 0 },
									BodyPos = { 0, -1.4, -1.4 },
								},
								["Missionary Sex"] = {
									["Right Arm"] = { 0, 0, 0 },
									["Left Arm"] = { 0, 0, 0 },
									["Right Leg"] = { 0, 0, 45 },
									["Left Leg"] = { 0, 0, -45 },
									Head = { -45, 0, 0 },
									Torso = { 90, 0, 0 },
									BodyPos = { 0, -1.4, -1.4 },
								},
							},
							KickLogs = {},
							KickServerCooldowns = setmetatable({}, { __mode = "k" }),
							KickServerState = { Running = false },
							Anchored = {},
							ObjectGroups = {},
							ObjectStates = {},
							AnchorSettings = {
								FillColor = Color3.fromRGB(182, 38, 186),
								OutlineColor = Color3.new(1, 1, 1),
								Physics = PhysicalProperties.new(100, 2, 0, 100, 100),
							},
							TeleportLocations = {},
							Inventories = {},
							TargetMethods = {},
							PCLD = {},
							PCLDParts = {},
							PCLDTracker = {
								PartStates = {},
								Players = {},
								Positions = {},
								Confirmations = 3,
								MaxDistance = 6,
								MinMargin = 0.75,
							},
							ParticleSettings = {
								Enabled = false,
								BoxSize = 500,
								Texture = "rbxassetid://242109931",
								Color = Color3.fromRGB(255, 255, 255),
								Transparency = 0,
								ParticleSize = 1,
								Count = 2500,
								SpeedMin = 0.5,
								SpeedMax = 2,
								LifeTime = 10,
							},
							ToysAuraSettings = {
								Enabled = false,
								LimitEnabled = false,
								Limit = 100,
								OwnInventoryOnly = false,
								AutoRotate = false,
								AutoMove = false,
								Bob = false,
								RotationSpeed = 1.5,
								MoveSpeed = 5,
								BobSpeed = 2,
								BobHeight = 3,
								Rotation = Vector3.zero,
								Offset = CFrame.new(0, 10, 0),
								Collisions = false,
								Models = {},
								Shape = "Circle",
								Center = CFrame.new(0, 50, 0),
								CustomPos = CFrame.new(0, 50, 0),
								Spacing = 1,
								Radius = 20,
								Height = 20,
								Rows = 5,
								Rotations = 3,
								Responsiveness = 55,
								FaceCenter = true,
								OwnType = "Aura",
								PosType = "You",
							},
							ToyAuras = {},
							ToyAuraReserved = setmetatable({}, { __mode = "k" }),
							ToyAuraRoots = setmetatable({}, { __mode = "k" }),
							AuraVisualSettings = {
								AuraColor = Color3.fromRGB(255, 80, 80),
								ToyAuraColor = Color3.fromRGB(80, 180, 255),
							},
							AimSettings = {
								AimbotEnabled = false,
								AlwaysOn = lib.IsMobile,
								TriggerbotEnabled = false,
								AimDebounce = false,
								TriggerBotDebounce = false,
								AimKey = Enum.KeyCode.X,
								Smoothness = 0.15,
								SADist = 40,
								TriggerDist = 20,
								TargetPart = "Head",
								TriggerDelay = 0.05,
								TriggerCooldown = 0.4,
								TriggerVersion = 0,
								TriggerTricks = false,
								TriggerTrick = "360 Spin",
								TriggerTrickSpeed = 1,
								FOVEnabled = false,
								FOVRadius = 150,
							},
							AimRaycastFilter = {},
							Gradients = {
		Color1 = Color3.fromRGB(255, 0, 0),
		Color2 = Color3.fromRGB(255, 165, 0),
		Color3 = Color3.fromRGB(255, 255, 0),
		Color4 = Color3.fromRGB(0, 255, 0),
		Color5 = Color3.fromRGB(0, 255, 255),
		Color6 = Color3.fromRGB(0, 0, 255),
		Color7 = Color3.fromRGB(170, 0, 255),
		Color8 = Color3.fromRGB(255, 255, 255),
		DotColor = Color3.fromRGB(255, 255, 255),
							},
							BreakParts = {
								InnerUFO = function()
									local object = alwaysHereTweenedObjects.InnerUFO.Object
									return object and object.ObjectModel
								end,
								OuterUFO = function()
									local object = alwaysHereTweenedObjects.OuterUFO.Object
									return object and object.ObjectModel
								end,
								CaveCart = function()
									local object = alwaysHereTweenedObjects.CaveCart.Object
									return object and object.ObjectModel
								end,
								Train = function()
									local object = alwaysHereTweenedObjects.Train.Object
									return object and object.ObjectModel
								end,
								["Flying Rock 1"] = function()
									local object = alwaysHereTweenedObjects.SmlDebris.Object
									return object and object.ObjectModel
								end,
								["Flying Rock 2"] = function()
									local object = alwaysHereTweenedObjects.SmlDebris2.Object
									return object and object.ObjectModel
								end,
								["Flying Rock 3"] = function()
									local object = alwaysHereTweenedObjects.LrgDebris.Object
									return object and object.ObjectModel
								end,
								["Flying Rock 4"] = function()
									local object = alwaysHereTweenedObjects.LrgDebris2.Object
									return object and object.ObjectModel
								end,
							},
							ESPFonts = {
								"Gotham",
								"Arial",
								"SourceSans",
								"Code",
								"Highway",
								"SciFi",
								"Arcade",
								"Fantasy",
								"Cartoon",
								"Antique",
								"Garamond",
								"Bodoni",
								"Roboto",
								"RobotoMono",
								"Ubuntu",
							},
							ESPConfig = {
								Player = {
									Objects = {},
									HighlightEnabled = true,
									FillColor = Color3.new(1, 0, 0),
									OutlineColor = Color3.new(1, 1, 1),
									FillTransparency = 0,
									OutlineTransparency = 0,
									NameEnabled = true,
									NameFont = "Arial|Bold",
									NameSize = 11,
									NameTransparency = 0,
									NameOutlineTransparency = 0,
									NameColor = Color3.new(1, 1, 1),
									NameOutlineColor = Color3.new(0, 0, 0),
									NameShowIcon = true,
									NameIconSize = 32,
									NameYOffset = 2.5,
								},
								Server = {
									Objects = {},
									FillColor = Color3.fromRGB(197, 0, 204),
									OutlineColor = Color3.new(0, 0, 0),
									OutlineThickness = 0.04,
									FillTransparency = 0.5,
									OutlineTransparency = 0,
									NameEnabled = true,
									NameDistance = 25,
									NameYOffset = 0,
									NameSize = 12,
									NameFont = "Arial",
									NameColor = Color3.new(1, 1, 1),
									NameOutlineColor = Color3.new(0, 0, 0),
									NameTransparency = 0,
									NameOutlineTransparency = 0,
								},
								Sticky = {
									Objects = {},
									FillColor = Color3.new(1, 0, 0),
									OutlineColor = Color3.new(0, 0, 0),
									FillTransparency = 0,
									OutlineTransparency = 0,
									OutlineThickness = 2,
								},
								Blackhole = {
									Objects = {},
									FillColor = Color3.new(0, 1, 1),
									OutlineColor = Color3.new(1, 1, 1),
									FillTransparency = 0,
									OutlineTransparency = 0,
									NameEnabled = true,
									NameFont = "Arial",
									NameYOffset = 5,
									NameSize = 13,
									NameColor = Color3.new(0, 0, 0),
									NameOutlineColor = Color3.new(1, 1, 1),
									NameTransparency = 0,
									NameOutlineTransparency = 0,
								},
							},
							Sounds = {},
							Auras = {},
							Grabs = {},
							GrabbableParts = {},
							ToyEffects = {},
							FailedToys = {},
							BrokenPlots = {},
							BrokenParts = setmetatable({}, { __mode = "k" }),
							BrokenPartHighlight = {
								FillColor = Color3.fromRGB(0, 170, 255),
								OutlineColor = Color3.new(1, 1, 1),
								FillTransparency = 0.7,
								OutlineTransparency = 0.3,
							},
							BreakPartWelds = setmetatable({}, { __mode = "k" }),
							ShurikenLagWelds = setmetatable({}, { __mode = "k" }),
							PartOwnerCache = setmetatable({}, { __mode = "k" }),
							CharacterHighlightAffects = {
								Character = true,
								["Coconut Forms"] = true,
								["China Hat"] = true,
								["Anti Kick"] = true,
							},
							CharacterHighlightParts = setmetatable({}, { __mode = "k" }),
							CoconutForms = {
								Selected = {},
								Order = {},
								Offsets = {},
								Models = {},
								Parts = {},
								WingRipple = {},
								Acquiring = {},
								Names = { "Boobs", "Ass", "Penis", "Wings", "Cape", "67" },
								Counts = {
									Boobs = 2,
									Ass = 2,
									Penis = 7,
									Wings = 12,
									Cape = 12,
									["67"] = 13,
								},
								Points67 = {
									Vector2.new(-1.75, 1.6499999761581421),
									Vector2.new(-0.64999997615814209, 1.6499999761581421),
									Vector2.new(-1.75, 0.55000001192092896),
									Vector2.new(-1.75, -0.55000001192092896),
									Vector2.new(-0.64999997615814209, -0.55000001192092896),
									Vector2.new(-1.75, -1.6499999761581421),
									Vector2.new(-0.64999997615814209, -1.6499999761581421),
									Vector2.new(0.5, 1.6499999761581421),
									Vector2.new(1.6000000238418579, 1.6499999761581421),
									Vector2.new(2.7000000476837158, 1.6499999761581421),
									Vector2.new(2.1500000953674316, 0.55000001192092896),
									Vector2.new(1.6000000238418579, -0.55000001192092896),
									Vector2.new(1.0499999523162842, -1.6499999761581421),
								},
								Limit = 13,
								ShaftLength = 5,
								ShaftSpacing = 0.9,
								WingSpacing = 1.1,
								Transparency = 0.5,
								Spacing67 = 0.4,
								Display67 = "Show to Back",
								CapeMode = "4x3",
								WingPhase = 0,
								WingSpeed = 1.4,
								CapePhase = 0,
								CapeSpeed = 0,
								CapeWind = Vector3.zero,
								Spawning = false,
								Generation = 0,
							},
							AnimationWhitelist = { ["180426354"] = true, ["168268306"] = true },
							States = {},
							SpawnQueue = {},
							SpawnOrder = 0,
							RuntimeGates = {},
							RuntimeConnections = {},
							AutoRejoinBusy = false,
							CustomAssets = { Files = {}, Requests = {} },
							RegisteredKeybinds = {},
							KeybindNames = {},
							KeybindMenuDefaults = setmetatable({}, { __mode = "k" }),
							ToggleStates = {},
							ActiveDraggableButtons = {},
							CustomCrosshair = { Hidden = {} },
							NotificationSettings = {
								Enabled = true,
								Events = {
									["Kicked Player"] = true,
									["Player Left"] = true,
									["Player Rejoined"] = true,
								},
								Templates = {
									["Kicked Player"] = "%kickedPlayer% has been kicked.",
									["Player Left"] = "%leftPlayer% left and was removed from %listCount% list(s).",
									["Player Rejoined"] = "%rejoinedPlayer% rejoined and was restored to %listCount% list(s).",
								},
							},
							ImmunePlayers = {},
							ImmuneShurikens = {},
							AntiKickSettings = {
								Highlight = false,
								HighlightFill = Color3.new(1, 0, 0),
								HighlightOutl = Color3.new(1, 1, 1),
								HighlightFT = 0.5,
								HighlightOT = 0,
								Transparency = 0.9,
							},
							WaterPartStates = {},
							WaterParts = {},
							WaterRegions = {},
							WaterSettings = {
								WaterColor = terrain.WaterColor,
								WaterWaveSize = terrain.WaterWaveSize,
								WaterWaveSpeed = terrain.WaterWaveSpeed,
								WaterTransparency = terrain.WaterTransparency,
								WaterReflectance = terrain.WaterReflectance,
							},
							ServerHop = {
								CachePath = "ResonanceServerHop_" .. tostring(placeId) .. ".json",
								Busy = false,
								Token = 0,
								AutoToken = 0,
								LastFetchError = nil,
								LastCacheError = nil,
								Rejected = {},
								CachedRegions = {},
								Regions = {},
								RegionNames = {
									"Automatic",
									"EU",
									"North America",
									"South America",
									"Asia",
									"Oceania",
								},
								AutomaticCountry = nil,
								PlayerCoordinates = nil,
								ResolvedRegions = {},
								ContinentCountries = {
									EU = " AD AL AT AX BA BE BG BY CH CY CZ DE DK EE ES FI FO FR GB GG GI GR HR HU IE IM IS IT JE LI LT LU LV MC MD ME MK MT NL NO PL PT RO RS RU SE SI SJ SK SM TR UA VA XK ",
									["North America"] = " AG AI AW BB BL BM BQ BS BZ CA CR CU CW DM DO GD GL GP GT HN HT JM KN KY LC MF MQ MS MX NI PA PM PR SV SX TC TT US VC VG VI ",
									["South America"] = " AR BO BR CL CO EC FK GF GY PE PY SR UY VE ",
									Asia = " AE AF AM AZ BD BH BN BT CN GE HK ID IL IN IQ IR JO JP KG KH KP KR KW KZ LA LB LK MM MN MO MV MY NP OM PH PK PS QA SA SG SY TH TJ TL TM TW UZ VN YE ",
									Oceania = " AS AU CC CK CX FJ FM GU KI MH MP NC NF NR NU NZ PF PG PN PW SB TK TO TV UM VU WF WS ",
								},
								CountryCoordinates = {
									AX = Vector2.new(60.180000305175781, 19.920000076293945),
									BQ = Vector2.new(12.180000305175781, -68.239997863769531),
									CW = Vector2.new(12.170000076293945, -68.989997863769531),
									BL = Vector2.new(17.899999618530273, -62.830001831054688),
									MF = Vector2.new(18.069999694824219, -63.049999237060547),
									SX = Vector2.new(18.040000915527344, -63.049999237060547),
									SS = Vector2.new(6.880000114440918, 31.309999465942383),
								},
							},
							LimbOffsetsRL = {
								Head = CFrame.new(0, 1.5, 0),
								["Left Arm"] = CFrame.new(-1.5, 0, 0),
								["Right Arm"] = CFrame.new(1.5, 0, 0),
								["Left Leg"] = CFrame.new(-0.5, -2, 0),
								["Right Leg"] = CFrame.new(0.5, -2, 0),
								Torso = CFrame.new(),
							},
							PacketData = {},
							LineData = {},
							FlingState = { Method = "PalletLightBrown" },
						}
end)
end
do
FapGuard(18101, function()
tbl10 = { Workers = {}, Generations = {}, LoopTokens = {}, Epoch = 0 }
end)
do
local obj = setmetatable({}, { __mode = "k" })
FapGuard(18106, function()
Players.PlayerAdded:Connect(function(player)
								tbl7.PlayerList[#tbl7.PlayerList + 1] = player
							end)
end)
FapGuard(18110, function()
Players.PlayerRemoving:Connect(function(player)
								local v24 = table.find(tbl7.PlayerList, player)

								if v24 then
									table.remove(tbl7.PlayerList, v24)
								end

								tbl7.AdminImmune[player] = nil
							end)
end)
local function fn21(arg, arg2, arg3)
								local v24 = ReplicatedStorage
								local waitForChild = v24.WaitForChild
								local str6

								if arg3 then
									str6 = ""
								else
									str6 = "Events"
								end

								local v25 = waitForChild(v24, arg .. str6, 0.5)
								return v25 and v25:WaitForChild(arg2, 0.5)
							end
FapGuard(18135, function()
tbl11 = {
								SetNetworkOwner = fn21("Grab", "SetNetworkOwner"),
								CreateGrabLine = fn21("Grab", "CreateGrabLine"),
								DestroyGrabLine = fn21("Grab", "DestroyGrabLine"),
								StickyPartEvent = fn21("Player", "StickyPartEvent"),
								SpawnToy = fn21("MenuToys", "SpawnToyRemoteFunction", true),
								DestroyToy = fn21("MenuToys", "DestroyToy", true),
								Struggle = fn21("Character", "Struggle"),
								RagdollRemote = fn21("Character", "RagdollRemote"),
								UseFood = fn21("Hold", "Use"),
								Explode = fn21("Bomb", "BombExplode"),
								Packet = fn21("Grab", "ExtendGrabLine"),
							}
end)
FapGuard(18178, function()
tbl12 = {}
end)
FapGuard(18201, function()
fn20 = function(arg)
								local n36 = arg or 0
								local heartbeat2 = RunService.Heartbeat
								local now3 = tick()

								repeat
									heartbeat2:Wait()
								until n36 <= tick() - now3

								return true
							end
end)
FapGuard(18213, function()
tbl12.GetRuntimeGate = function(arg)
								local v24 = tbl7.RuntimeGates[arg]
								if v24 then
									return v24
								end
								local bindableEvent = Instance.new("BindableEvent")
								tbl7.RuntimeGates[arg] = bindableEvent
								return bindableEvent
							end
end)
FapGuard(18223, function()
tbl12.SetRuntimeToggle = function(arg, arg2)
								tbl8[arg] = arg2
								local v24 = tbl7.RuntimeGates[arg]

								if v24 then
									v24:Fire()
								end
							end
end)
FapGuard(18232, function()
tbl12.WaitForRuntimeToggle = function(arg)
								if tbl8[arg] then
									return true
								end
								local v24 = tbl12.GetRuntimeGate(arg)

								while true do
									v24.Event:Wait()
									if not (flag11 or tbl8[arg]) then
										continue
									end
									break
								end

								return not flag11
							end
end)
FapGuard(18255, function()
tbl12.WakeRuntimeGate = function(arg)
								local v24 = tbl7.RuntimeGates[arg]

								if v24 then
									v24:Fire()
								end
							end
end)
FapGuard(18298, function()
tbl12.SetRuntimeConnection = function(arg, arg2, arg3, arg4)
								local v24 = tbl7.RuntimeConnections[arg]

								if not arg3 then
									if v24 then
										v24:Disconnect()
									end

									tbl7.RuntimeConnections[arg] = nil
									return
								end

								if v24 and v24.Connected then
									return
								end
								tbl7.RuntimeConnections[arg] = arg2:Connect(arg4)
							end
end)
FapGuard(18532, function()
tbl12.Char = function(arg)
								if arg == nil then
									arg = localPlayer
								end

								if arg then
									if obj[arg] then
										local character = obj[arg].Character
										local rootPart = obj[arg].RootPart
										local humanoid = obj[arg].Humanoid
										if character and character.Parent and rootPart and rootPart.Parent and humanoid and humanoid.Parent then
											return character, rootPart, humanoid
										end
										obj[arg] = nil
									end

									local character = arg.Character

									if character then
										local realHrp = character:FindFirstChild("realHrp") or character:FindFirstChild("HumanoidRootPart")
										local humanoid = character:FindFirstChild("Humanoid")
										obj[arg] = { Character = character, RootPart = realHrp, Humanoid = humanoid }
										return character, realHrp, humanoid
									end
								end
							end
end)
end
end
do
FapGuard(18593, function()
tbl12.RepositionLimbs = function(arg, arg2)
							local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
							local torso = arg:FindFirstChild("Torso")
							if not humanoidRootPart or not torso then
								return
							end
							local neck = torso:FindFirstChild("Neck")
							if neck and neck.Enabled then
								return
							end
							local lookVector = humanoidRootPart.CFrame.LookVector
							local vector = Vector3.new(lookVector.X, 0, lookVector.Z)
							if vector.Magnitude < 0.001 then
								return
							end
							local cframe = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + vector.Unit)

							for k, v24 in pairs(tbl7.LimbOffsetsRL) do
								local v25 = arg:FindFirstChild(k)

								if v25 and v25:IsA("BasePart") then
									local cFrame2 = cframe * v24

									if v25.CFrame ~= cFrame2 then
										v25.CFrame = cFrame2
									end

									if arg2 then
										tbl12.ResetVelocity(v25)
									end
								end
							end
						end
end)
FapGuard(18662, function()
tbl12.LightPhysicalProperties = PhysicalProperties.new(0.01, 0.01, 0.01, 0.01, 0.01)
end)
FapGuard(18664, function()
tbl12.ToggleCollisions = function(arg, canCollide, arg2, arg3)
							if canCollide == nil then
								canCollide = false
							end

							local lightPhysicalProperties

							if arg3 then
								lightPhysicalProperties = tbl12.LightPhysicalProperties
							else
								lightPhysicalProperties = nil
							end

							for _, child in pairs(arg:GetChildren()) do
								if child:IsA("BasePart") then
									local flag12

									if canCollide then
										flag12 = child.Name == "Torso" or child.Name == "Head"
									else
										flag12 = canCollide
									end

									if flag12 then
										if child.CanCollide ~= canCollide then
											child.CanCollide = canCollide
										end
									elseif not canCollide then
										if child.CanCollide ~= canCollide then
											child.CanCollide = canCollide
										end

										if not arg2 then
											local ragdollLimbPart = child:FindFirstChild("RagdollLimbPart")

											if ragdollLimbPart and ragdollLimbPart.CanCollide then
												ragdollLimbPart.CanCollide = false
											end
										end
									end

									if child.Name ~= "HumanoidRootPart" and child.CustomPhysicalProperties ~= lightPhysicalProperties then
										child.CustomPhysicalProperties = lightPhysicalProperties
									end
								end
							end
						end
end)
FapGuard(18751, function()
tbl12.ResetVelocity = function(arg)
							if not arg or not arg:IsA("BasePart") then
								return false
							end

							if arg.AssemblyAngularVelocity ~= Vector3.zero then
								arg.AssemblyAngularVelocity = Vector3.zero
							end

							if arg.AssemblyLinearVelocity ~= Vector3.zero then
								arg.AssemblyLinearVelocity = Vector3.zero
							end

							return true
						end
end)
FapGuard(18767, function()
tbl12.Teleport = function(arg, cFrame2, arg2, arg3)
							if not arg or not arg:IsA("BasePart") or not cFrame2 then
								return false
							end
							local v24 = tbl12.Char()
							local v25 = v24 and arg:IsDescendantOf(v24)

							if typeof(cFrame2) == "CFrame" then
								if arg2 then
									cFrame2 *= arg2
								end
							elseif typeof(cFrame2) == "Vector3" then
								local cframe = CFrame.new

								if arg2 then
									cFrame2 += arg2.Position
								end

								cFrame2 = cframe(cFrame2)
							else
								if not (typeof(cFrame2) == "Instance" and cFrame2:IsA("BasePart")) then
									return false
								end

								if arg2 then
									cFrame2 = cFrame2.CFrame * arg2
								else
									cFrame2 = cFrame2.CFrame
								end
							end

							if v25 and (arg.Name == "HumanoidRootPart" or arg.Name == "Torso") and tbl7.States["Anti Grab"] then
								v22 = cFrame2
							end

							if arg.CFrame ~= cFrame2 then
								arg.CFrame = cFrame2
							end

							if arg3 ~= false then
								tbl12.ResetVelocity(arg)
							end

							return true
						end
end)
FapGuard(18813, function()
tbl12.PivotTo = function(arg, arg2, arg3, arg4)
							if not arg or not arg:IsA("Model") or typeof(arg2) ~= "CFrame" then
								return false
							end
							local n36 = arg2 * arg:GetPivot():Inverse()
							arg3 = arg3 or arg:QueryDescendants("BasePart")
							arg4 = arg4 or {}
							table.clear(arg4)

							for i, v24 in ipairs(arg3) do
								local assemblyRootPart = v24:IsDescendantOf(arg) and v24.AssemblyRootPart

								if assemblyRootPart and not v24.Anchored and not assemblyRootPart.Anchored then
									arg4[i] = n36 * v24.CFrame
								end
							end

							for k, v24 in pairs(arg4) do
								arg3[k].CFrame = v24
							end

							return true
						end
end)
FapGuard(18867, function()
tbl12.GetMagnitude = function(arg, arg2)
							if not arg or not arg2 then
								return
							end
							return (arg.Position - arg2.Position).Magnitude
						end
end)
FapGuard(18918, function()
tbl12.WhichPlot = function(arg)
							local plots = workspace:FindFirstChild("Plots")
							if not plots then
								return
							end

							for _, child in pairs(plots:GetChildren()) do
								local plotArea = child:FindFirstChild("PlotArea")
								if not plotArea then
									continue
								end
								local partsInPart = workspace:GetPartsInPart(plotArea)

								for _, v24 in pairs(partsInPart) do
									if Players:GetPlayerFromCharacter(v24.Parent) == arg then
										local inOwnedPlot2 = arg:FindFirstChild("InOwnedPlot")
										return child, inOwnedPlot2 and inOwnedPlot2.Value
									end
								end
							end
						end
end)
FapGuard(18961, function()
tbl12.BreakPlot = function(arg)
							local inPlot2 = nil

							if arg:IsA("Player") then
								inPlot2 = arg:FindFirstChild("InPlot")
								if not inPlot2 then
									return
								end
								arg = tbl12.WhichPlot(arg)
								if not arg then
									return
								end
							end

							if tbl7.BrokenPlots[arg.Name] then
								return true
							end
							local plotArea = arg:FindFirstChild("PlotArea")
							if not plotArea then
								return
							end
							local NinjaShuriken = tbl12.SpawnToy("NinjaShuriken")
							if not NinjaShuriken then
								return
							end
							local stickyPart = NinjaShuriken and NinjaShuriken:WaitForChild("StickyPart", 0.4)
							local stickyWeld = stickyPart and stickyPart:WaitForChild("StickyWeld", 0.4)
							local cframe = CFrame.new(1099511627776, 1099511627776, 1099511627776)

							if arg.Name == "Plot5" then
								cframe = CFrame.new(2147483648, 2147483648, 2147483648)
							end

							if not stickyWeld or not tbl12.SNO(stickyPart) then
								return
							end
							tbl11.StickyPartEvent:FireServer(stickyPart, plotArea, cframe)
							local now3 = tick()

							while true do
								task.wait()
								if not (stickyWeld.Part1 == plotArea and (not inPlot2 or not inPlot2.Value) or not stickyWeld.Parent or tick() - now3 > 0.8) then
									continue
								end
								break
							end

							if not stickyWeld.Parent or stickyWeld.Part1 ~= plotArea or inPlot2 and inPlot2.Value == true then
								if NinjaShuriken then
									tbl12.DestroyToy(NinjaShuriken)
								end

								return false
							end

							tbl7.BrokenPlots[arg.Name] = NinjaShuriken

							NinjaShuriken.Destroying:Once(function()
								tbl7.BrokenPlots[arg.Name] = nil
							end)

							return NinjaShuriken
						end
end)
FapGuard(19112, function()
tbl12.IsNetworkOwner = function(arg)
							if not (arg and arg:IsA("BasePart")) then
								return
							end
							local assemblyRootPart = arg.AssemblyRootPart or arg
							return not assemblyRootPart.Anchored and assemblyRootPart.ReceiveAge == 0
						end
end)
FapGuard(19120, function()
tbl12.IsPartOwner = function(arg)
							if not (arg and arg:IsA("BasePart")) then
								return
							end
							local v24 = tbl7.PartOwnerCache[arg]
							if v24 and v24.Parent then
								return v24.Value == localPlayer.Name
							end
							local parent2 = arg.Parent
							local head = arg.Name == "HumanoidRootPart" and parent2 and parent2:FindFirstChild("Head")
							head = head and head:FindFirstChild("PartOwner")
							if head and head.Value == localPlayer.Name then
								tbl7.PartOwnerCache[arg] = head
								return true
							end
							local partOwner = arg:FindFirstChild("PartOwner")
							if partOwner and partOwner.Value == localPlayer.Name then
								tbl7.PartOwnerCache[arg] = partOwner
								return true
							end
							parent2 = parent2 and parent2:FindFirstChild("PartOwner", true)
							if parent2 then
								tbl7.PartOwnerCache[arg] = parent2
								return parent2.Value == localPlayer.Name
							end
							return false
						end
end)
do
local obj = setmetatable({}, { __mode = "k" })
FapGuard(19161, function()
tbl12.GetCustomVelocity = function(arg)
								local now3 = os.clock()
								local position = arg.Position
								local v24 = obj[arg]
								if not v24 then
									obj[arg] = { Position = position, Time = now3, Linear = Vector3.zero }
									return Vector3.zero
								end
								local n36 = now3 - v24.Time
								if n36 < 0.001 then
									return v24.Linear
								end
								local n37 = (position - v24.Position) / n36

								if n36 > 0.25 or n37.Magnitude > 300 then
									v24.Linear = Vector3.zero
								else
									v24.Linear = v24.Linear:Lerp(n37, 1 - math.exp(-n36 * 40))

									if v24.Linear.Magnitude < 0.05 then
										v24.Linear = Vector3.zero
									end
								end

								v24.Position = position
								v24.Time = now3
								return v24.Linear
							end
end)
end
end
FapGuard(19192, function()
tbl12.PredictCFrame = function(arg, arg2)
						local cFrame2 = arg2 or arg.CFrame
						if not tbl8.PositionPrediction then
							return cFrame2
						end
						local n36 = math.clamp(localPlayer:GetNetworkPing(), 0, 0.35)
						return cFrame2 + tbl12.GetCustomVelocity(arg) * n36
					end
end)
FapGuard(19201, function()
tbl12.Grab = function(arg, arg2)
						local v24, v25, v26 = tbl12.Char()
						if not v25 or not v26 or v26.Health == 0 or not arg or not arg.Parent or not arg:IsA("BasePart") then
							return
						end
						local n36 = (arg2 or v25.CFrame) * CFrame.new(0, 1.593, 0)
						local cframe = tbl12.PredictCFrame(arg)

						if not tbl8.DirectGrab then
							cframe = CFrame.new(n36.Position, cframe.Position)
						end

						tbl11.SetNetworkOwner:FireServer(arg, cframe)
					end
end)
FapGuard(19216, function()
tbl12.SNO = function(arg, arg2, arg3)
						local v24, v25, v26 = tbl12.Char()
						local head = v24 and v24:FindFirstChild("Head")
						local ragdolled = v26 and v26:FindFirstChild("Ragdolled")
						if not (head and ragdolled and v25 and v26 and v26.Health > 0) then
							return false
						end

						if not arg or not arg:IsA("BasePart") or not arg.Parent or tbl12.GetMagnitude(arg, workspace.SpawnLocation) > 10000000 then
							return false
						end

						if tbl12.IsPartOwner(arg) then
							return true
						end

						if tbl7.States.Owning or arg3 and not arg3() then
							return false
						end
						local flag12 = false
						local cframe = CFrame.new()
						local cframe2 = CFrame.new()
						local cframe3 = CFrame.new()
						local connection = nil

						if (v25.Position - arg.Position).Magnitude >= 31 then
							flag12 = true
						end

						local flag13 = arg.Name == "HumanoidRootPart" or arg.Name == "Torso"
						local v27 = nil

						if flag13 then
							local v28 = Players:FindFirstChild(arg.Parent.Name)
							v27 = nil

							if v28 then
								local v29, v30, v31 = tbl12.Char(v28)
								if not v31 or v31.Health == 0 then
									return false
								end
								local inPlot2 = v28:FindFirstChild("InPlot")
								inPlot2 = inPlot2 and inPlot2.Value == true
								v27 = nil

								if inPlot2 then
									v27 = tbl12.BreakPlot(v28)
									if not v27 then
										return false
									end
								end
							end
						end

						tbl7.States.Owning = true

						local function fn21()
							cframe2 = v25.CFrame
							cframe = head.CFrame
							cframe3 = v25.CFrame

							RunService:BindToRenderStep("RSCClient", Enum.RenderPriority.Camera.Value - 1, function()
								v25.CFrame = cframe2
								head.CFrame = cframe
							end)

							connection = RunService.Heartbeat:Connect(function()
								cframe2 = v25.CFrame
								cframe = head.CFrame
								v25.CFrame = cframe3
								head.CFrame = cframe3
							end)
						end

						local function fn22()
							RunService:UnbindFromRenderStep("RSCClient")

							if connection then
								connection:Disconnect()
								connection = nil
							end

							head.CFrame = cframe
							v25.CFrame = cframe2
						end

						local ok, result = pcall(function()
							if flag12 then
								fn21()
							end

							arg2 = arg2 or 0.65
							local now3 = tick()

							while not flag11 and arg.Parent and not tbl12.IsPartOwner(arg) and v26.Health ~= 0 and v25.Parent and (not arg3 or arg3()) and tick() - now3 < arg2 do
								if flag12 then
									cframe3 = tbl12.PredictCFrame(arg) - Vector3.new(0, 22, 0)
								end

								RunService.Heartbeat:Wait()
								local grab = tbl12.Grab
								local v28

								if flag12 then
									v28 = cframe3
								else
									v28 = nil
								end

								grab(arg, v28)
							end
						end)

						if flag12 then
							pcall(fn22)
						end

						if v27 then
							task.delay(1, tbl12.DestroyToy, v27)
						end

						tbl7.States.Owning = false
						if not ok then
							return warn(result)
						end
						return tbl12.IsPartOwner(arg)
					end
end)
FapGuard(19344, function()
tbl12.RNO = function(arg)
						tbl11.DestroyGrabLine:FireServer(arg)
					end
end)
FapGuard(19348, function()
tbl12.DisableEndGrabEarly = function()
						local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents")
						if not grabEvents then
							return
						end
						local endGrabEarly = grabEvents:FindFirstChild("EndGrabEarly")
						if endGrabEarly == remoteEvent then
							return endGrabEarly
						end

						if endGrabEarly then
							endGrabEarly:Destroy()
						end

						remoteEvent = Instance.new("RemoteEvent")
						remoteEvent.Name = "EndGrabEarly"
						remoteEvent.Parent = grabEvents
						return remoteEvent
					end
end)
do
FapGuard(19373, function()
tbl12.FormatPlayer = function(arg, arg2, arg3)
							local v24

							if type(arg) ~= "string" then
								v24 = arg
							else
								v24 = Players:FindFirstChild(arg)
							end

							if v24 == nil then
								return "???"
							end

							if v24 == localPlayer and arg3 then
								return "You"
							end
							local str6 = "%*%* (@%*)"
							local format = str6.format
							local displayName = v24.DisplayName
							local str7

							if arg2 then
								str7 = "\n"
							else
								str7 = ""
							end

							return (format(str6, displayName, str7, v24.Name))
						end
end)
end
end
FapGuard(20599, function()
tbl12.Ragdoll = function(arg)
					if not arg or not arg.Parent or tbl7.States.Ragdolling then
						return
					end
					local head = arg:FindFirstChild("Head")
					local torso = head and arg:FindFirstChild("Torso")
					local humanoid = torso and arg:FindFirstChild("Humanoid")
					humanoid = humanoid and humanoid:FindFirstChild("Ragdolled")

					if humanoid and humanoid.Value == false then
						tbl7.States.Ragdolling = true
						local ragdollRSC = v17:FindFirstChild("RagdollRSC") or tbl12.SpawnToy("PalletLightBrown")
						local soundPart = ragdollRSC and ragdollRSC:WaitForChild("SoundPart", 0.5)
						local main = soundPart and ragdollRSC:WaitForChild("Main", 0.5)
						if not main or not tbl12.SNO(soundPart) then
							tbl7.States.Ragdolling = false
							return tbl12.DestroyToy(ragdollRSC)
						end
						ragdollRSC.Name = "RagdollRSC"

						for _, child in pairs(ragdollRSC:GetChildren()) do
							if child:IsA("BasePart") then
								child.CanCollide = false
							end
						end

						if not main:FindFirstChild("RagdollBP") then
							local bodyPosition = Instance.new("BodyPosition")
							bodyPosition.Name = "RagdollBP"
							bodyPosition.D = 1500
							bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							bodyPosition.Position = Vector3.new(0, 100000, 0)
							bodyPosition.Parent = main
						end

						local now3 = tick()

						while true do
							soundPart.Position = torso.Position
							soundPart.Velocity = Vector3.new(0, -10, 0)
							task.wait(0.1)
							if not (humanoid.Value or not main.Parent or not arg.Parent or not head:FindFirstChild("PartOwner") or tick() - now3 > 0.5) then
								continue
							end
							break
						end

						tbl7.States.Ragdolling = false
						return humanoid.Value
					end
				end
end)
FapGuard(20723, function()
tbl12.BreakLimb = function(arg, arg2)
					local flag12 = arg == localPlayer
					if flag12 and tbl8.GucciAntiGrab then
						return fn18("Can't break limbs while in Gucci!")
					end
					local v24, v25, v26 = tbl12.Char(arg)
					local ragdolled = v26 and v26:FindFirstChild("Ragdolled")
					if not (v25 and v26 and v26.Health ~= 0 and ragdolled) then
						return
					end
					local children = v24:GetChildren()
					local flag13 = false

					for _, child in ipairs(children) do
						if child:IsA("BasePart") then
							if child.Name:find("Arm") and (arg2 == "Arms" or arg2 == "All") or child.Name:find("Leg") and (arg2 == "Legs" or arg2 == "All") then
								flag13 = true
								break
							end
						end
					end

					if not flag13 then
						return
					end

					if flag12 then
						tbl11.RagdollRemote:FireServer(v25, 0.35)
						local now3 = tick()

						while true do
							task.wait()
							if not (ragdolled.Value or tick() - now3 > 0.5) then
								continue
							end
							break
						end
					elseif not (tbl12.SNO(v25) and tbl12.Ragdoll(v24)) then
						return
					end

					if not ragdolled.Value then
						return
					end
					local cFrame2 = v25.CFrame

					for _, child in ipairs(children) do
						if child:IsA("BasePart") then
							if child.Name:find("Arm") and (arg2 == "Arms" or arg2 == "All") then
								tbl12.Teleport(child, CFrame.new(0, -100000, 0))
							elseif child.Name:find("Leg") and (arg2 == "Legs" or arg2 == "All") then
								tbl12.Teleport(child, CFrame.new(0, -100000, 0))
							end
						end
					end

					task.wait(0.15)
					if not v25.Parent then
						return
					end

					if flag12 then
						tbl12.Grab(v25)
						task.wait()

						for _, v27 in children, nil, nil do
							if v27.Parent then
								tbl12.ResetVelocity(v27)
							end
						end

						tbl11.RagdollRemote:FireServer(v25, 0)
					else
						workspace.FallenPartsDestroyHeight = -10000
						tbl12.Teleport(v25, CFrame.new(0, -11000, 0))
						task.wait()
						local v27 = workspace
						local fallenPartsDestroyHeight2

						if tbl8.DestroyVoid then
							fallenPartsDestroyHeight2 = (0/0)
						else
							fallenPartsDestroyHeight2 = -100
						end

						v27.FallenPartsDestroyHeight = fallenPartsDestroyHeight2

						if v25.Parent then
							tbl12.Teleport(v25, cFrame2)

							for _, v28 in children, nil, nil do
								if v28.Parent then
									tbl12.ResetVelocity(v28)
								end
							end

							RunService.Heartbeat:Wait()

							for _, v28 in children, nil, nil do
								if v28.Parent then
									tbl12.ResetVelocity(v28)
								end
							end

							if v25.Parent then
								tbl12.RNO(v25)
							end
						end
					end
				end
end)
end
do
do
do
local lookFigures = {
							Enabled = false,
							Preview = true,
							Figure = "Sideways",
							Clock = 0,
							Cycle = 0,
						}
FapGuard(21102, function()
tbl7.LookFigures = lookFigures
end)
end
FapGuard(21228, function()
tbl12.AntiGrab = function()
						if flag11 then
							return
						end

						if isHeld.Value and tbl8.AntiGrab and not tbl7.States["Anti Grab"] then
							tbl11.Struggle:FireServer()
							local v23, v24, v25 = tbl12.Char()
							local torso = v23 and v23:FindFirstChild("Torso")
							local neck = torso and torso:FindFirstChild("Neck")
							if not (v25 and torso) then
								return
							end
							v25.RequiresNeck = false
							v25.AutoRotate = false
							tbl12.ResetVelocity(v24 or torso)
							local position = torso.Position
							local lookVector = torso.CFrame.LookVector
							local unit = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
							tbl7.States["Anti Grab"] = true
							local flag12 = tbl9.AGType == "Escapes Anything, but buggy"
							local sit = tbl9.AGType == "Anti-Kill"
							local flag13 = tbl9.AGType == "No Ragdoll"

							if flag12 then
								task.spawn(tbl12.ExtraEscape)
							end

							local now3 = tick()
							local connection = nil
							local n36 = tick() + 0.033333333333333333
							local n37 = 0

							connection = RunService.RenderStepped:Connect(function(deltaTime)
								local now4 = tick()

								if now4 >= n36 then
									tbl11.Struggle:FireServer()
									n36 = now4 + 0.033333333333333333
								end

								if v24 and not flag12 and not flag13 and now4 >= n37 then
									local ragdollRemote = tbl11.RagdollRemote
									local fireServer = ragdollRemote.FireServer
									local n38

									if sit then
										n38 = 0.11
									else
										n38 = 0
									end

									fireServer(ragdollRemote, v24, n38)
									n37 = now4 + 0.033333333333333333
								end

								if flag12 and tick() - now3 > 2 then
									task.spawn(tbl12.ExtraEscape)
									now3 = tick()
								end

								local moveDirection = v25.MoveDirection
								local walkSpeed

								if tbl8.WalkSpeed and tbl9.WalkSpeed > 16 then
									walkSpeed = tbl9.WalkSpeed
								else
									walkSpeed = 16
								end

								if moveDirection.Magnitude > 0 then
									position += moveDirection * walkSpeed * deltaTime
								end

								if (currentCamera.CFrame.Position - currentCamera.Focus.Position).Magnitude < 1 then
									moveDirection = currentCamera.CFrame.LookVector
								end

								local vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)

								if vector.Magnitude > 0 then
									unit = unit:Lerp(vector.Unit, math.min(deltaTime * 12, 1)).Unit
								end

								tbl12.ResetVelocity(v24 or torso)

								if v22 then
									local v26 = torso
									local v27 = v22
									position = v22.Position
									v26.CFrame = v27
									v22 = nil
								else
									torso.CFrame = CFrame.lookAt(position, position + unit)
								end

								v25.Sit = sit

								if not neck or not neck.Enabled then
									tbl12.ToggleCollisions(v23, false)
									tbl12.RepositionLimbs(v23, true)
								end

								for _, v26 in ipairs(v25:GetPlayingAnimationTracks()) do
									if v26.Animation.AnimationId == "rbxassetid://7047322890" then
										v26:Stop()
									end
								end

								if v24 and v24:FindFirstChild("Scream") then
									v24.Scream.Playing = false
								end

								if not isHeld.Value or not tbl8.AntiGrab then
									tbl7.States["Anti Grab"] = false

									if sit then
										task.delay(0.1, function()
											if not v25.SeatPart then
												v25.Sit = false
												v25:ChangeState(Enum.HumanoidStateType.Running)
											end
										end)
									end

									v25.AutoRotate = true
									connection:Disconnect()
								end
							end)
						end
					end
end)
do
local tbl16 = nil
local flag12 = nil
local function fn21(arg)
							if not arg.Parent or arg.Health <= 0 then
								return
							end
							arg.Sit = true
							task.wait(0.05)

							if arg.Parent then
								arg.Sit = false
							end

							task.wait(0.05)
						end
local function fn22()
							if not tbl16 then
								return
							end

							for _, v23 in tbl16.Connections, nil, nil do
								v23:Disconnect()
							end

							table.clear(tbl16.Connections)

							if tbl16.BP then
								tbl16.BP:Destroy()
								tbl16.BP = nil
							end

							local hum = tbl16.Hum
							local hrp = tbl16.HRP

							if hum and hum.Parent then
								hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, tbl16.Jumping)

								if hum.SeatPart == tbl16.Seat or not hum.SeatPart then
									hum.Sit = false
								end
							end

							if tbl16.Ragdoll and hrp and hrp.Parent then
								tbl11.RagdollRemote:FireServer(hrp, 0.15)
							end

							local v23 = tbl16
							local v24 = tbl16
							tbl16.Hum = nil
							v23.HRP = nil
							v24.Ragdoll = nil
						end
local function fn23()
							if not tbl16 then
								return
							end
							fn22()

							if tbl16.InvConn then
								tbl16.InvConn:Disconnect()
							end

							local vehicle = tbl16.Vehicle
							local seat = tbl16.Seat

							if vehicle then
								tbl7.ToyAuraReserved[vehicle] = tbl16.Reserved

								if tbl16.Type == "Train" then
									if seat and seat.Parent then
										seat.Transparency = tbl16.Transparency
										seat.CanCollide = tbl16.CanCollide
									end
								else
									tbl12.DestroyToy(vehicle)
								end
							end

							tbl16 = nil
						end
local function fn24()
							local character = localPlayer.Character
							local n36 = 0
							local v23 = nil
							local v24, v25, v26, gucciType, ragdolled, object, v27, seat

							while tbl8.GucciAntiGrab do
								local exitTo = nil
								local vehicle, root, flag13, fn25, flag14, now3, cFrame2, n37, connection, flag15, flag16, now4, flag17, parent2, v28, bodyPosition, random, parent3, seatPart, flag18, occupant, playerFromCharacter

								while true do
									task.wait()
									v24, v25, v26 = tbl12.Char()
									gucciType = tbl9.GucciType

									if v24 ~= character then
										character = v24
										n36 = os.clock() + 1
									end

									if tbl16 and (tbl16.Type ~= gucciType or not tbl16.Vehicle.Parent or not tbl16.Seat.Parent or tbl16.Char ~= v24) then
										fn23()
									end

									if tbl8.GucciAntiGrab then
										ragdolled = v26 and v26:FindFirstChild("Ragdolled")

										if not (v25 and v26 and v26.Health > 0 and ragdolled) or isHeld.Value or ragdolled.Value then
											exitTo = 1
											break
										elseif not tbl16 then
											local seat2, v29, v30, flag19, flag20, parent4, parent5, fn26

											if gucciType == "Train" then
												object = train:FindFirstChild("Object")
												object = object and object:FindFirstChild("ObjectModel")
												seat2 = object and object:FindFirstChildWhichIsA("Seat")

												if not seat2 then
													exitTo = 25
													break
												else
													v29 = tbl7.ToyAuraReserved[object]
													v30 = nil
													flag19 = not tbl8.GucciAntiGrab or tbl9.GucciType ~= gucciType or localPlayer.Character ~= v24

													if flag19 then
														flag20 = flag19
													else
														parent4 = object and object.Parent
														parent5 = parent4 and seat2 and seat2.Parent
														flag20 = not parent5
													end

													if flag20 then
														exitTo = 26
														break
													else
														tbl16 = {
															Vehicle = object,
															Seat = seat2,
															Root = v30,
															Char = v24,
															Type = gucciType,
															Reserved = v29,
															Connections = {},
															Transparency = seat2.Transparency,
															CanCollide = seat2.CanCollide,
														}

														tbl7.ToyAuraReserved[object] = true
														v23 = nil

														if gucciType == "Train" then
															v27 = tbl16
															vehicle = v27.Vehicle
															seat = v27.Seat
															root = v27.Root
															flag13 = seat.Occupant and seat.Occupant ~= v26

															if flag13 then
																exitTo = 32
																break
															else
																fn25 = function()
																	local flag21 = tbl16 == v27 and tbl8.GucciAntiGrab and tbl9.GucciType == gucciType and localPlayer.Character == v24 and vehicle.Parent and seat.Parent and v25.Parent and v26.Parent and v26.Health > 0 and not isHeld.Value and not ragdolled.Value

																	if flag21 then
																		flag21 = not (seat.Occupant and seat.Occupant ~= v26)
																	end

																	return flag21
																end

																v27.Hum = v26
																v27.HRP = v25
																v27.Jumping = v26:GetStateEnabled(Enum.HumanoidStateType.Jumping)
																seat.Transparency = 1
																seat.CanCollide = false
																v26.Sit = false
																flag14 = false

																table.insert(v27.Connections, seat.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child.Name == "SeatWeld" then
																		child.Enabled = false
																		child:Destroy()
																		flag14 = true
																	end
																end))

																table.insert(v27.Connections, v24.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child:IsA("LocalScript") and child.Name:lower():find("control") then
																		child.Enabled = false
																		child:Destroy()
																	end
																end))

																now3 = os.clock()
																cFrame2 = v25.CFrame
																n37 = nil
																v27.Ragdoll = true
																connection = nil

																connection = RunService.Heartbeat:Connect(function()
																	if not fn25() then
																		connection:Disconnect()
																	elseif n37 and os.clock() >= n37 then
																		v27.Ragdoll = false
																		tbl11.RagdollRemote:FireServer(v25, 0.15)
																		connection:Disconnect()
																	else
																		tbl11.RagdollRemote:FireServer(v25, 0)
																	end
																end)

																table.insert(v27.Connections, connection)
																tbl11.RagdollRemote:FireServer(v25, 0)
																task.wait()

																if not fn25() then
																	exitTo = 33
																	break
																else
																	seat:Sit(v26)

																	while true do
																		task.wait()

																		if not fn25() then
																			break
																		else
																			flag15 = flag14 or os.clock() - now3 > 0.75
																			if not flag15 then
																				continue
																			end
																			break
																		end
																	end

																	flag16 = not fn25() or not flag14

																	if flag16 then
																		exitTo = 34
																		break
																	else
																		v26.Sit = false
																		now4 = os.clock()
																		n37 = now4 + 0.15

																		if now4 < n36 then
																			tbl12.Teleport(v25, cFrame2)
																		end

																		flag17 = gucciType ~= "Train" and root
																		parent2 = flag17 and root.Parent

																		if parent2 then
																			v28 = root:IsDescendantOf(workspace.PlotItems)
																			parent2 = v28 or tbl12.IsNetworkOwner(root) or tbl12.SNO(root)
																		end

																		if parent2 then
																			if not fn25() then
																				exitTo = 36
																				break
																			else
																				bodyPosition = Instance.new("BodyPosition")
																				bodyPosition.Name = "GucciBP"
																				bodyPosition.D = 200
																				bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
																				random = math.random
																				bodyPosition.Position = Vector3.new(math.random(-100000, 100000), 100000, random(-100000, 100000))
																				v27.BP = bodyPosition
																				vehicle.Name = "GucciRSC"
																				bodyPosition.Parent = root
																				v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

																				while fn25() do
																					task.wait()
																				end

																				parent3 = v26.Parent
																				seatPart = parent3 and v26.Health > 0 and v26.SeatPart
																				flag18 = seatPart and v26.SeatPart ~= seat

																				if flag18 then
																					fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
																				end

																				if tbl16 == v27 then
																					occupant = seat.Occupant
																					playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

																					if playerFromCharacter then
																						fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
																					end

																					fn22()

																					if playerFromCharacter then
																						fn23()
																					end
																				end

																				fn21(v26)
																				if tbl8.GucciAntiGrab then
																					continue
																				end
																			end
																		else
																			exitTo = 35
																			break
																		end
																	end
																end
															end
														else
															fn26 = function(descendant)
																if descendant:IsA("BasePart") then
																	descendant.Transparency = 1
																	descendant.CanCollide = false
																elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
																	descendant.Transparency = 1
																elseif descendant.Name == "ItemSpawnSound" then
																	descendant:Destroy()
																end
															end

															for _, v31 in object:GetDescendants() do
																fn26(v31)
															end

															tbl16.InvConn = object.DescendantAdded:Connect(fn26)
															v23 = nil
															v27 = tbl16
															vehicle = v27.Vehicle
															seat = v27.Seat
															root = v27.Root
															flag13 = seat.Occupant and seat.Occupant ~= v26

															if flag13 then
																exitTo = 27
																break
															else
																fn25 = function()
																	local flag21 = tbl16 == v27 and tbl8.GucciAntiGrab and tbl9.GucciType == gucciType and localPlayer.Character == v24 and vehicle.Parent and seat.Parent and v25.Parent and v26.Parent and v26.Health > 0 and not isHeld.Value and not ragdolled.Value

																	if flag21 then
																		flag21 = not (seat.Occupant and seat.Occupant ~= v26)
																	end

																	return flag21
																end

																v27.Hum = v26
																v27.HRP = v25
																v27.Jumping = v26:GetStateEnabled(Enum.HumanoidStateType.Jumping)
																seat.Transparency = 1
																seat.CanCollide = false
																v26.Sit = false
																flag14 = false

																table.insert(v27.Connections, seat.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child.Name == "SeatWeld" then
																		child.Enabled = false
																		child:Destroy()
																		flag14 = true
																	end
																end))

																table.insert(v27.Connections, v24.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child:IsA("LocalScript") and child.Name:lower():find("control") then
																		child.Enabled = false
																		child:Destroy()
																	end
																end))

																now3 = os.clock()
																cFrame2 = v25.CFrame
																n37 = nil
																v27.Ragdoll = true
																connection = nil

																connection = RunService.Heartbeat:Connect(function()
																	if not fn25() then
																		connection:Disconnect()
																	elseif n37 and os.clock() >= n37 then
																		v27.Ragdoll = false
																		tbl11.RagdollRemote:FireServer(v25, 0.15)
																		connection:Disconnect()
																	else
																		tbl11.RagdollRemote:FireServer(v25, 0)
																	end
																end)

																table.insert(v27.Connections, connection)
																tbl11.RagdollRemote:FireServer(v25, 0)
																task.wait()

																if not fn25() then
																	exitTo = 28
																	break
																else
																	seat:Sit(v26)

																	while true do
																		task.wait()

																		if not fn25() then
																			break
																		else
																			flag15 = flag14 or os.clock() - now3 > 0.75
																			if not flag15 then
																				continue
																			end
																			break
																		end
																	end

																	flag16 = not fn25() or not flag14

																	if flag16 then
																		exitTo = 29
																		break
																	else
																		v26.Sit = false
																		now4 = os.clock()
																		n37 = now4 + 0.15

																		if now4 < n36 then
																			tbl12.Teleport(v25, cFrame2)
																		end

																		flag17 = gucciType ~= "Train" and root
																		parent2 = flag17 and root.Parent

																		if parent2 then
																			v28 = root:IsDescendantOf(workspace.PlotItems)
																			parent2 = v28 or tbl12.IsNetworkOwner(root) or tbl12.SNO(root)
																		end

																		if parent2 then
																			if not fn25() then
																				exitTo = 31
																				break
																			else
																				bodyPosition = Instance.new("BodyPosition")
																				bodyPosition.Name = "GucciBP"
																				bodyPosition.D = 200
																				bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
																				random = math.random
																				bodyPosition.Position = Vector3.new(math.random(-100000, 100000), 100000, random(-100000, 100000))
																				v27.BP = bodyPosition
																				vehicle.Name = "GucciRSC"
																				bodyPosition.Parent = root
																				v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

																				while fn25() do
																					task.wait()
																				end

																				parent3 = v26.Parent
																				seatPart = parent3 and v26.Health > 0 and v26.SeatPart
																				flag18 = seatPart and v26.SeatPart ~= seat

																				if flag18 then
																					fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
																				end

																				if tbl16 == v27 then
																					occupant = seat.Occupant
																					playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

																					if playerFromCharacter then
																						fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
																					end

																					fn22()

																					if playerFromCharacter then
																						fn23()
																					end
																				end

																				fn21(v26)
																				if tbl8.GucciAntiGrab then
																					continue
																				end
																			end
																		else
																			exitTo = 30
																			break
																		end
																	end
																end
															end
														end
													end
												end
											else
												object = tbl12.SpawnToy(gucciType, CFrame.new(100000, 500000, 0), 2, true)
												seat2 = object and object:WaitForChild("VehicleSeat", 1.25)
												v29 = nil

												if seat2 then
													v30 = tbl12.FindNicePart(object)
													v29 = nil
													flag19 = not tbl8.GucciAntiGrab or tbl9.GucciType ~= gucciType or localPlayer.Character ~= v24

													if flag19 then
														flag20 = flag19
													else
														parent4 = object and object.Parent
														parent5 = parent4 and seat2 and seat2.Parent
														flag20 = not parent5
													end

													if flag20 then
														exitTo = 14
														break
													else
														tbl16 = {
															Vehicle = object,
															Seat = seat2,
															Root = v30,
															Char = v24,
															Type = gucciType,
															Reserved = v29,
															Connections = {},
															Transparency = seat2.Transparency,
															CanCollide = seat2.CanCollide,
														}

														tbl7.ToyAuraReserved[object] = true
														v23 = nil

														if gucciType == "Train" then
															v27 = tbl16
															vehicle = v27.Vehicle
															seat = v27.Seat
															root = v27.Root
															flag13 = seat.Occupant and seat.Occupant ~= v26

															if flag13 then
																exitTo = 20
																break
															else
																fn25 = function()
																	local flag21 = tbl16 == v27 and tbl8.GucciAntiGrab and tbl9.GucciType == gucciType and localPlayer.Character == v24 and vehicle.Parent and seat.Parent and v25.Parent and v26.Parent and v26.Health > 0 and not isHeld.Value and not ragdolled.Value

																	if flag21 then
																		flag21 = not (seat.Occupant and seat.Occupant ~= v26)
																	end

																	return flag21
																end

																v27.Hum = v26
																v27.HRP = v25
																v27.Jumping = v26:GetStateEnabled(Enum.HumanoidStateType.Jumping)
																seat.Transparency = 1
																seat.CanCollide = false
																v26.Sit = false
																flag14 = false

																table.insert(v27.Connections, seat.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child.Name == "SeatWeld" then
																		child.Enabled = false
																		child:Destroy()
																		flag14 = true
																	end
																end))

																table.insert(v27.Connections, v24.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child:IsA("LocalScript") and child.Name:lower():find("control") then
																		child.Enabled = false
																		child:Destroy()
																	end
																end))

																now3 = os.clock()
																cFrame2 = v25.CFrame
																n37 = nil
																v27.Ragdoll = true
																connection = nil

																connection = RunService.Heartbeat:Connect(function()
																	if not fn25() then
																		connection:Disconnect()
																	elseif n37 and os.clock() >= n37 then
																		v27.Ragdoll = false
																		tbl11.RagdollRemote:FireServer(v25, 0.15)
																		connection:Disconnect()
																	else
																		tbl11.RagdollRemote:FireServer(v25, 0)
																	end
																end)

																table.insert(v27.Connections, connection)
																tbl11.RagdollRemote:FireServer(v25, 0)
																task.wait()

																if not fn25() then
																	exitTo = 21
																	break
																else
																	seat:Sit(v26)

																	while true do
																		task.wait()

																		if not fn25() then
																			break
																		else
																			flag15 = flag14 or os.clock() - now3 > 0.75
																			if not flag15 then
																				continue
																			end
																			break
																		end
																	end

																	flag16 = not fn25() or not flag14

																	if flag16 then
																		exitTo = 22
																		break
																	else
																		v26.Sit = false
																		now4 = os.clock()
																		n37 = now4 + 0.15

																		if now4 < n36 then
																			tbl12.Teleport(v25, cFrame2)
																		end

																		flag17 = gucciType ~= "Train" and root
																		parent2 = flag17 and root.Parent

																		if parent2 then
																			v28 = root:IsDescendantOf(workspace.PlotItems)
																			parent2 = v28 or tbl12.IsNetworkOwner(root) or tbl12.SNO(root)
																		end

																		if parent2 then
																			if not fn25() then
																				exitTo = 24
																				break
																			else
																				bodyPosition = Instance.new("BodyPosition")
																				bodyPosition.Name = "GucciBP"
																				bodyPosition.D = 200
																				bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
																				random = math.random
																				bodyPosition.Position = Vector3.new(math.random(-100000, 100000), 100000, random(-100000, 100000))
																				v27.BP = bodyPosition
																				vehicle.Name = "GucciRSC"
																				bodyPosition.Parent = root
																				v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

																				while fn25() do
																					task.wait()
																				end

																				parent3 = v26.Parent
																				seatPart = parent3 and v26.Health > 0 and v26.SeatPart
																				flag18 = seatPart and v26.SeatPart ~= seat

																				if flag18 then
																					fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
																				end

																				if tbl16 == v27 then
																					occupant = seat.Occupant
																					playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

																					if playerFromCharacter then
																						fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
																					end

																					fn22()

																					if playerFromCharacter then
																						fn23()
																					end
																				end

																				fn21(v26)
																				if tbl8.GucciAntiGrab then
																					continue
																				end
																			end
																		else
																			exitTo = 23
																			break
																		end
																	end
																end
															end
														else
															fn26 = function(arg)
																if arg:IsA("BasePart") then
																	arg.Transparency = 1
																	arg.CanCollide = false
																elseif arg:IsA("Decal") or arg:IsA("Texture") then
																	arg.Transparency = 1
																elseif arg.Name == "ItemSpawnSound" then
																	arg:Destroy()
																end
															end

															for _, v31 in object:GetDescendants() do
																fn26(v31)
															end

															tbl16.InvConn = object.DescendantAdded:Connect(fn26)
															v23 = nil
															v27 = tbl16
															vehicle = v27.Vehicle
															seat = v27.Seat
															root = v27.Root
															flag13 = seat.Occupant and seat.Occupant ~= v26

															if flag13 then
																exitTo = 15
																break
															else
																fn25 = function()
																	local flag21 = tbl16 == v27 and tbl8.GucciAntiGrab and tbl9.GucciType == gucciType and localPlayer.Character == v24 and vehicle.Parent and seat.Parent and v25.Parent and v26.Parent and v26.Health > 0 and not isHeld.Value and not ragdolled.Value

																	if flag21 then
																		flag21 = not (seat.Occupant and seat.Occupant ~= v26)
																	end

																	return flag21
																end

																v27.Hum = v26
																v27.HRP = v25
																v27.Jumping = v26:GetStateEnabled(Enum.HumanoidStateType.Jumping)
																seat.Transparency = 1
																seat.CanCollide = false
																v26.Sit = false
																flag14 = false

																table.insert(v27.Connections, seat.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child.Name == "SeatWeld" then
																		child.Enabled = false
																		child:Destroy()
																		flag14 = true
																	end
																end))

																table.insert(v27.Connections, v24.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child:IsA("LocalScript") and child.Name:lower():find("control") then
																		child.Enabled = false
																		child:Destroy()
																	end
																end))

																now3 = os.clock()
																cFrame2 = v25.CFrame
																n37 = nil
																v27.Ragdoll = true
																connection = nil

																connection = RunService.Heartbeat:Connect(function()
																	if not fn25() then
																		connection:Disconnect()
																	elseif n37 and os.clock() >= n37 then
																		v27.Ragdoll = false
																		tbl11.RagdollRemote:FireServer(v25, 0.15)
																		connection:Disconnect()
																	else
																		tbl11.RagdollRemote:FireServer(v25, 0)
																	end
																end)

																table.insert(v27.Connections, connection)
																tbl11.RagdollRemote:FireServer(v25, 0)
																task.wait()

																if not fn25() then
																	exitTo = 16
																	break
																else
																	seat:Sit(v26)

																	while true do
																		task.wait()

																		if not fn25() then
																			break
																		else
																			flag15 = flag14 or os.clock() - now3 > 0.75
																			if not flag15 then
																				continue
																			end
																			break
																		end
																	end

																	flag16 = not fn25() or not flag14

																	if flag16 then
																		exitTo = 17
																		break
																	else
																		v26.Sit = false
																		now4 = os.clock()
																		n37 = now4 + 0.15

																		if now4 < n36 then
																			tbl12.Teleport(v25, cFrame2)
																		end

																		flag17 = gucciType ~= "Train" and root
																		parent2 = flag17 and root.Parent

																		if parent2 then
																			v28 = root:IsDescendantOf(workspace.PlotItems)
																			parent2 = v28 or tbl12.IsNetworkOwner(root) or tbl12.SNO(root)
																		end

																		if parent2 then
																			if not fn25() then
																				exitTo = 19
																				break
																			else
																				bodyPosition = Instance.new("BodyPosition")
																				bodyPosition.Name = "GucciBP"
																				bodyPosition.D = 200
																				bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
																				random = math.random
																				bodyPosition.Position = Vector3.new(math.random(-100000, 100000), 100000, random(-100000, 100000))
																				v27.BP = bodyPosition
																				vehicle.Name = "GucciRSC"
																				bodyPosition.Parent = root
																				v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

																				while fn25() do
																					task.wait()
																				end

																				parent3 = v26.Parent
																				seatPart = parent3 and v26.Health > 0 and v26.SeatPart
																				flag18 = seatPart and v26.SeatPart ~= seat

																				if flag18 then
																					fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
																				end

																				if tbl16 == v27 then
																					occupant = seat.Occupant
																					playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

																					if playerFromCharacter then
																						fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
																					end

																					fn22()

																					if playerFromCharacter then
																						fn23()
																					end
																				end

																				fn21(v26)
																				if tbl8.GucciAntiGrab then
																					continue
																				end
																			end
																		else
																			exitTo = 18
																			break
																		end
																	end
																end
															end
														end
													end
												else
													v30 = seat2
													flag19 = not tbl8.GucciAntiGrab or tbl9.GucciType ~= gucciType or localPlayer.Character ~= v24

													if flag19 then
														flag20 = flag19
													else
														parent4 = object and object.Parent
														parent5 = parent4 and seat2 and seat2.Parent
														flag20 = not parent5
													end

													if flag20 then
														exitTo = 3
														break
													else
														tbl16 = {
															Vehicle = object,
															Seat = seat2,
															Root = v30,
															Char = v24,
															Type = gucciType,
															Reserved = v29,
															Connections = {},
															Transparency = seat2.Transparency,
															CanCollide = seat2.CanCollide,
														}

														tbl7.ToyAuraReserved[object] = true
														v23 = nil

														if gucciType == "Train" then
															v27 = tbl16
															vehicle = v27.Vehicle
															seat = v27.Seat
															root = v27.Root
															flag13 = seat.Occupant and seat.Occupant ~= v26

															if flag13 then
																exitTo = 9
																break
															else
																fn25 = function()
																	local flag21 = tbl16 == v27 and tbl8.GucciAntiGrab and tbl9.GucciType == gucciType and localPlayer.Character == v24 and vehicle.Parent and seat.Parent and v25.Parent and v26.Parent and v26.Health > 0 and not isHeld.Value and not ragdolled.Value

																	if flag21 then
																		flag21 = not (seat.Occupant and seat.Occupant ~= v26)
																	end

																	return flag21
																end

																v27.Hum = v26
																v27.HRP = v25
																v27.Jumping = v26:GetStateEnabled(Enum.HumanoidStateType.Jumping)
																seat.Transparency = 1
																seat.CanCollide = false
																v26.Sit = false
																flag14 = false

																table.insert(v27.Connections, seat.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child.Name == "SeatWeld" then
																		child.Enabled = false
																		child:Destroy()
																		flag14 = true
																	end
																end))

																table.insert(v27.Connections, v24.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child:IsA("LocalScript") and child.Name:lower():find("control") then
																		child.Enabled = false
																		child:Destroy()
																	end
																end))

																now3 = os.clock()
																cFrame2 = v25.CFrame
																n37 = nil
																v27.Ragdoll = true
																connection = nil

																connection = RunService.Heartbeat:Connect(function()
																	if not fn25() then
																		connection:Disconnect()
																	elseif n37 and os.clock() >= n37 then
																		v27.Ragdoll = false
																		tbl11.RagdollRemote:FireServer(v25, 0.15)
																		connection:Disconnect()
																	else
																		tbl11.RagdollRemote:FireServer(v25, 0)
																	end
																end)

																table.insert(v27.Connections, connection)
																tbl11.RagdollRemote:FireServer(v25, 0)
																task.wait()

																if not fn25() then
																	exitTo = 10
																	break
																else
																	seat:Sit(v26)

																	while true do
																		task.wait()

																		if not fn25() then
																			break
																		else
																			flag15 = flag14 or os.clock() - now3 > 0.75
																			if not flag15 then
																				continue
																			end
																			break
																		end
																	end

																	flag16 = not fn25() or not flag14

																	if flag16 then
																		exitTo = 11
																		break
																	else
																		v26.Sit = false
																		now4 = os.clock()
																		n37 = now4 + 0.15

																		if now4 < n36 then
																			tbl12.Teleport(v25, cFrame2)
																		end

																		flag17 = gucciType ~= "Train" and root
																		parent2 = flag17 and root.Parent

																		if parent2 then
																			v28 = root:IsDescendantOf(workspace.PlotItems)
																			parent2 = v28 or tbl12.IsNetworkOwner(root) or tbl12.SNO(root)
																		end

																		if parent2 then
																			if not fn25() then
																				exitTo = 13
																				break
																			else
																				bodyPosition = Instance.new("BodyPosition")
																				bodyPosition.Name = "GucciBP"
																				bodyPosition.D = 200
																				bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
																				random = math.random
																				bodyPosition.Position = Vector3.new(math.random(-100000, 100000), 100000, random(-100000, 100000))
																				v27.BP = bodyPosition
																				vehicle.Name = "GucciRSC"
																				bodyPosition.Parent = root
																				v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

																				while fn25() do
																					task.wait()
																				end

																				parent3 = v26.Parent
																				seatPart = parent3 and v26.Health > 0 and v26.SeatPart
																				flag18 = seatPart and v26.SeatPart ~= seat

																				if flag18 then
																					fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
																				end

																				if tbl16 == v27 then
																					occupant = seat.Occupant
																					playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

																					if playerFromCharacter then
																						fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
																					end

																					fn22()

																					if playerFromCharacter then
																						fn23()
																					end
																				end

																				fn21(v26)
																				if tbl8.GucciAntiGrab then
																					continue
																				end
																			end
																		else
																			exitTo = 12
																			break
																		end
																	end
																end
															end
														else
															fn26 = function(arg)
																if arg:IsA("BasePart") then
																	arg.Transparency = 1
																	arg.CanCollide = false
																elseif arg:IsA("Decal") or arg:IsA("Texture") then
																	arg.Transparency = 1
																elseif arg.Name == "ItemSpawnSound" then
																	arg:Destroy()
																end
															end

															for _, v31 in object:GetDescendants() do
																fn26(v31)
															end

															tbl16.InvConn = object.DescendantAdded:Connect(fn26)
															v23 = nil
															v27 = tbl16
															vehicle = v27.Vehicle
															seat = v27.Seat
															root = v27.Root
															flag13 = seat.Occupant and seat.Occupant ~= v26

															if flag13 then
																exitTo = 4
																break
															else
																fn25 = function()
																	local flag21 = tbl16 == v27 and tbl8.GucciAntiGrab and tbl9.GucciType == gucciType and localPlayer.Character == v24 and vehicle.Parent and seat.Parent and v25.Parent and v26.Parent and v26.Health > 0 and not isHeld.Value and not ragdolled.Value

																	if flag21 then
																		flag21 = not (seat.Occupant and seat.Occupant ~= v26)
																	end

																	return flag21
																end

																v27.Hum = v26
																v27.HRP = v25
																v27.Jumping = v26:GetStateEnabled(Enum.HumanoidStateType.Jumping)
																seat.Transparency = 1
																seat.CanCollide = false
																v26.Sit = false
																flag14 = false

																table.insert(v27.Connections, seat.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child.Name == "SeatWeld" then
																		child.Enabled = false
																		child:Destroy()
																		flag14 = true
																	end
																end))

																table.insert(v27.Connections, v24.ChildAdded:Connect(function(child)
																	if tbl16 == v27 and child:IsA("LocalScript") and child.Name:lower():find("control") then
																		child.Enabled = false
																		child:Destroy()
																	end
																end))

																now3 = os.clock()
																cFrame2 = v25.CFrame
																n37 = nil
																v27.Ragdoll = true
																connection = nil

																connection = RunService.Heartbeat:Connect(function()
																	if not fn25() then
																		connection:Disconnect()
																	elseif n37 and os.clock() >= n37 then
																		v27.Ragdoll = false
																		tbl11.RagdollRemote:FireServer(v25, 0.15)
																		connection:Disconnect()
																	else
																		tbl11.RagdollRemote:FireServer(v25, 0)
																	end
																end)

																table.insert(v27.Connections, connection)
																tbl11.RagdollRemote:FireServer(v25, 0)
																task.wait()

																if not fn25() then
																	exitTo = 5
																	break
																else
																	seat:Sit(v26)

																	while true do
																		task.wait()

																		if not fn25() then
																			break
																		else
																			flag15 = flag14 or os.clock() - now3 > 0.75
																			if not flag15 then
																				continue
																			end
																			break
																		end
																	end

																	flag16 = not fn25() or not flag14

																	if flag16 then
																		exitTo = 6
																		break
																	else
																		v26.Sit = false
																		now4 = os.clock()
																		n37 = now4 + 0.15

																		if now4 < n36 then
																			tbl12.Teleport(v25, cFrame2)
																		end

																		flag17 = gucciType ~= "Train" and root
																		parent2 = flag17 and root.Parent

																		if parent2 then
																			v28 = root:IsDescendantOf(workspace.PlotItems)
																			parent2 = v28 or tbl12.IsNetworkOwner(root) or tbl12.SNO(root)
																		end

																		if parent2 then
																			if not fn25() then
																				exitTo = 8
																				break
																			else
																				bodyPosition = Instance.new("BodyPosition")
																				bodyPosition.Name = "GucciBP"
																				bodyPosition.D = 200
																				bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
																				random = math.random
																				bodyPosition.Position = Vector3.new(math.random(-100000, 100000), 100000, random(-100000, 100000))
																				v27.BP = bodyPosition
																				vehicle.Name = "GucciRSC"
																				bodyPosition.Parent = root
																				v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

																				while fn25() do
																					task.wait()
																				end

																				parent3 = v26.Parent
																				seatPart = parent3 and v26.Health > 0 and v26.SeatPart
																				flag18 = seatPart and v26.SeatPart ~= seat

																				if flag18 then
																					fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
																				end

																				if tbl16 == v27 then
																					occupant = seat.Occupant
																					playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

																					if playerFromCharacter then
																						fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
																					end

																					fn22()

																					if playerFromCharacter then
																						fn23()
																					end
																				end

																				fn21(v26)
																				if tbl8.GucciAntiGrab then
																					continue
																				end
																			end
																		else
																			exitTo = 7
																			break
																		end
																	end
																end
															end
														end
													end
												end
											end
										else
											exitTo = 2
											break
										end
									end

									break
								end

								if exitTo == 1 then
									continue
								else
									local flag19, flag20

									if exitTo == 2 then
										v27 = tbl16
										vehicle = v27.Vehicle
										seat = v27.Seat
										root = v27.Root
										flag13 = seat.Occupant and seat.Occupant ~= v26

										if flag13 then
											fn23()
										else
											fn25 = function()
												local flag21 = tbl16 == v27 and tbl8.GucciAntiGrab and tbl9.GucciType == gucciType and localPlayer.Character == v24 and vehicle.Parent and seat.Parent and v25.Parent and v26.Parent and v26.Health > 0 and not isHeld.Value and not ragdolled.Value

												if flag21 then
													flag21 = not (seat.Occupant and seat.Occupant ~= v26)
												end

												return flag21
											end

											v27.Hum = v26
											v27.HRP = v25
											v27.Jumping = v26:GetStateEnabled(Enum.HumanoidStateType.Jumping)
											seat.Transparency = 1
											seat.CanCollide = false
											v26.Sit = false
											flag14 = false

											table.insert(v27.Connections, seat.ChildAdded:Connect(function(child)
												if tbl16 == v27 and child.Name == "SeatWeld" then
													child.Enabled = false
													child:Destroy()
													flag14 = true
												end
											end))

											table.insert(v27.Connections, v24.ChildAdded:Connect(function(child)
												if tbl16 == v27 and child:IsA("LocalScript") and child.Name:lower():find("control") then
													child.Enabled = false
													child:Destroy()
												end
											end))

											now3 = os.clock()
											cFrame2 = v25.CFrame
											n37 = nil
											v27.Ragdoll = true
											connection = nil

											connection = RunService.Heartbeat:Connect(function()
												if not fn25() then
													connection:Disconnect()
												elseif n37 and os.clock() >= n37 then
													v27.Ragdoll = false
													tbl11.RagdollRemote:FireServer(v25, 0.15)
													connection:Disconnect()
												else
													tbl11.RagdollRemote:FireServer(v25, 0)
												end
											end)

											table.insert(v27.Connections, connection)
											tbl11.RagdollRemote:FireServer(v25, 0)
											task.wait()

											if not fn25() then
												if tbl16 == v27 then
													fn22()
												end

												fn21(v26)
											else
												seat:Sit(v26)

												while true do
													task.wait()

													if not fn25() then
														break
													else
														flag15 = flag14 or os.clock() - now3 > 0.75
														if not flag15 then
															continue
														end
														break
													end
												end

												flag16 = not fn25() or not flag14

												if flag16 then
													flag19 = v26.Sit and seat.Occupant == v26
													flag20 = not flag19

													if tbl16 == v27 then
														fn23()
													end

													if flag20 then
														fn21(v26)
													end
												else
													v26.Sit = false
													now4 = os.clock()
													n37 = now4 + 0.15

													if now4 < n36 then
														tbl12.Teleport(v25, cFrame2)
													end

													flag17 = gucciType ~= "Train" and root
													parent2 = flag17 and root.Parent

													if parent2 then
														v28 = root:IsDescendantOf(workspace.PlotItems)
														parent2 = v28 or tbl12.IsNetworkOwner(root) or tbl12.SNO(root)
													end

													if parent2 then
														if not fn25() then
															if tbl16 == v27 then
																fn23()
															end

															fn21(v26)
														else
															bodyPosition = Instance.new("BodyPosition")
															bodyPosition.Name = "GucciBP"
															bodyPosition.D = 200
															bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
															random = math.random
															bodyPosition.Position = Vector3.new(math.random(-100000, 100000), 100000, random(-100000, 100000))
															v27.BP = bodyPosition
															vehicle.Name = "GucciRSC"
															bodyPosition.Parent = root
															v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

															while fn25() do
																task.wait()
															end

															parent3 = v26.Parent
															seatPart = parent3 and v26.Health > 0 and v26.SeatPart
															flag18 = seatPart and v26.SeatPart ~= seat

															if flag18 then
																fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
															end

															if tbl16 == v27 then
																occupant = seat.Occupant
																playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

																if playerFromCharacter then
																	fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
																end

																fn22()

																if playerFromCharacter then
																	fn23()
																end
															end

															fn21(v26)
														end
													else
														v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

														while fn25() do
															task.wait()
														end

														parent3 = v26.Parent
														seatPart = parent3 and v26.Health > 0 and v26.SeatPart
														flag18 = seatPart and v26.SeatPart ~= seat

														if flag18 then
															fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
														end

														if tbl16 == v27 then
															occupant = seat.Occupant
															playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

															if playerFromCharacter then
																fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
															end

															fn22()

															if playerFromCharacter then
																fn23()
															end
														end

														fn21(v26)
													end
												end
											end
										end

										continue
									else
										local flag21

										if exitTo == 3 then
											flag21 = object and gucciType ~= "Train"

											if flag21 then
												tbl7.ToyAuraReserved[object] = nil
												tbl12.DestroyToy(object)
											end

											continue
										elseif exitTo == 4 then
											fn23()
											continue
										elseif exitTo == 5 then
											if tbl16 == v27 then
												fn22()
											end

											fn21(v26)
											continue
										elseif exitTo == 6 then
											flag19 = v26.Sit and seat.Occupant == v26
											flag20 = not flag19

											if tbl16 == v27 then
												fn23()
											end

											if flag20 then
												fn21(v26)
											end

											continue
										elseif exitTo == 7 then
											v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

											while fn25() do
												task.wait()
											end

											parent3 = v26.Parent
											seatPart = parent3 and v26.Health > 0 and v26.SeatPart
											flag18 = seatPart and v26.SeatPart ~= seat

											if flag18 then
												fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
											end

											if tbl16 == v27 then
												occupant = seat.Occupant
												playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

												if playerFromCharacter then
													fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
												end

												fn22()

												if playerFromCharacter then
													fn23()
												end
											end

											fn21(v26)
											continue
										elseif exitTo == 8 then
											if tbl16 == v27 then
												fn23()
											end

											fn21(v26)
											continue
										elseif exitTo == 9 then
											fn23()
											continue
										elseif exitTo == 10 then
											if tbl16 == v27 then
												fn22()
											end

											fn21(v26)
											continue
										elseif exitTo == 11 then
											flag19 = v26.Sit and seat.Occupant == v26
											flag20 = not flag19

											if tbl16 == v27 then
												fn23()
											end

											if flag20 then
												fn21(v26)
											end

											continue
										elseif exitTo == 12 then
											v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

											while fn25() do
												task.wait()
											end

											parent3 = v26.Parent
											seatPart = parent3 and v26.Health > 0 and v26.SeatPart
											flag18 = seatPart and v26.SeatPart ~= seat

											if flag18 then
												fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
											end

											if tbl16 == v27 then
												occupant = seat.Occupant
												playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

												if playerFromCharacter then
													fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
												end

												fn22()

												if playerFromCharacter then
													fn23()
												end
											end

											fn21(v26)
											continue
										elseif exitTo == 13 then
											if tbl16 == v27 then
												fn23()
											end

											fn21(v26)
											continue
										elseif exitTo == 14 then
											flag21 = object and gucciType ~= "Train"

											if flag21 then
												tbl7.ToyAuraReserved[object] = nil
												tbl12.DestroyToy(object)
											end

											continue
										elseif exitTo == 15 then
											fn23()
											continue
										elseif exitTo == 16 then
											if tbl16 == v27 then
												fn22()
											end

											fn21(v26)
											continue
										elseif exitTo == 17 then
											flag19 = v26.Sit and seat.Occupant == v26
											flag20 = not flag19

											if tbl16 == v27 then
												fn23()
											end

											if flag20 then
												fn21(v26)
											end

											continue
										elseif exitTo == 18 then
											v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

											while fn25() do
												task.wait()
											end

											parent3 = v26.Parent
											seatPart = parent3 and v26.Health > 0 and v26.SeatPart
											flag18 = seatPart and v26.SeatPart ~= seat

											if flag18 then
												fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
											end

											if tbl16 == v27 then
												occupant = seat.Occupant
												playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

												if playerFromCharacter then
													fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
												end

												fn22()

												if playerFromCharacter then
													fn23()
												end
											end

											fn21(v26)
											continue
										elseif exitTo == 19 then
											if tbl16 == v27 then
												fn23()
											end

											fn21(v26)
											continue
										elseif exitTo == 20 then
											fn23()
											continue
										elseif exitTo == 21 then
											if tbl16 == v27 then
												fn22()
											end

											fn21(v26)
											continue
										elseif exitTo == 22 then
											flag19 = v26.Sit and seat.Occupant == v26
											flag20 = not flag19

											if tbl16 == v27 then
												fn23()
											end

											if flag20 then
												fn21(v26)
											end

											continue
										elseif exitTo == 23 then
											v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

											while fn25() do
												task.wait()
											end

											parent3 = v26.Parent
											seatPart = parent3 and v26.Health > 0 and v26.SeatPart
											flag18 = seatPart and v26.SeatPart ~= seat

											if flag18 then
												fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
											end

											if tbl16 == v27 then
												occupant = seat.Occupant
												playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

												if playerFromCharacter then
													fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
												end

												fn22()

												if playerFromCharacter then
													fn23()
												end
											end

											fn21(v26)
											continue
										elseif exitTo == 24 then
											if tbl16 == v27 then
												fn23()
											end

											fn21(v26)
											continue
										elseif exitTo == 25 then
											if v23 ~= gucciType then
												local v29 = fn18
												local str5

												if object then
													str5 = "Train doesn't have seats!"
												else
													str5 = "Train doesn't exist!"
												end

												v29(str5)
												v23 = gucciType
											end

											continue
										elseif exitTo == 26 then
											flag21 = object and gucciType ~= "Train"

											if flag21 then
												tbl7.ToyAuraReserved[object] = nil
												tbl12.DestroyToy(object)
											end

											continue
										elseif exitTo == 27 then
											fn23()
											continue
										elseif exitTo == 28 then
											if tbl16 == v27 then
												fn22()
											end

											fn21(v26)
											continue
										elseif exitTo == 29 then
											flag19 = v26.Sit and seat.Occupant == v26
											flag20 = not flag19

											if tbl16 == v27 then
												fn23()
											end

											if flag20 then
												fn21(v26)
											end

											continue
										elseif exitTo == 30 then
											v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

											while fn25() do
												task.wait()
											end

											parent3 = v26.Parent
											seatPart = parent3 and v26.Health > 0 and v26.SeatPart
											flag18 = seatPart and v26.SeatPart ~= seat

											if flag18 then
												fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
											end

											if tbl16 == v27 then
												occupant = seat.Occupant
												playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

												if playerFromCharacter then
													fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
												end

												fn22()

												if playerFromCharacter then
													fn23()
												end
											end

											fn21(v26)
											continue
										elseif exitTo == 31 then
											if tbl16 == v27 then
												fn23()
											end

											fn21(v26)
											continue
										elseif exitTo == 32 then
											fn23()
											continue
										elseif exitTo == 33 then
											if tbl16 == v27 then
												fn22()
											end

											fn21(v26)
											continue
										elseif exitTo == 34 then
											flag19 = v26.Sit and seat.Occupant == v26
											flag20 = not flag19

											if tbl16 == v27 then
												fn23()
											end

											if flag20 then
												fn21(v26)
											end

											continue
										elseif exitTo == 35 then
											v26:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

											while fn25() do
												task.wait()
											end

											parent3 = v26.Parent
											seatPart = parent3 and v26.Health > 0 and v26.SeatPart
											flag18 = seatPart and v26.SeatPart ~= seat

											if flag18 then
												fn18("You can't sit on other Vehicles while in Gucci!", "Invincibility")
											end

											if tbl16 == v27 then
												occupant = seat.Occupant
												playerFromCharacter = occupant and occupant ~= v26 and Players:GetPlayerFromCharacter(occupant.Parent)

												if playerFromCharacter then
													fn18(playerFromCharacter.DisplayName .. " sat on your gucci!")
												end

												fn22()

												if playerFromCharacter then
													fn23()
												end
											end

											fn21(v26)
											continue
										elseif exitTo == 36 then
											if tbl16 == v27 then
												fn23()
											end

											fn21(v26)
											continue
										end
									end
								end

								break
							end
						end
FapGuard(23267, function()
tbl12.SetGucciAntiGrab = function(arg)
							tbl8.GucciAntiGrab = arg and not flag11
							if not tbl8.GucciAntiGrab then
								fn23()
								return
							end

							if flag12 then
								return
							end
							flag12 = true

							task.spawn(function()
								local ok, result = pcall(fn24)
								fn23()
								flag12 = nil

								if not ok then
									warn("[GUCCI Anti Grab] " .. tostring(result))

									if not flag11 then
										toggles.GucciAntiGrab:SetValue(false)
									end
								end
							end)
						end
end)
end
end
do
do
FapGuard(23300, function()
tbl12.IsWaitingPCLD = function(arg)
							return arg and arg.Position == Vector3.zero
						end
end)
FapGuard(23499, function()
tbl12.DetectPCLD = function(arg)
							return tbl7.PCLD[arg]
						end
end)
end
end
end
do
local function fn21(arg, arg2)
					tbl7.CharacterHighlightParts[arg] = nil
					arg2.MaterialConnection:Disconnect()
					arg2.ColorConnection:Disconnect()

					if arg.Parent then
						local color = arg2.Color
						local physical = arg2.Physical
						arg.Material = arg2.Material
						arg.Color = color
						arg.CustomPhysicalProperties = physical
					end
				end
FapGuard(24390, function()
tbl12.ApplyCharacterHighlightPart = function(arg, affect)
					if not (arg and arg:IsA("BasePart")) then
						return
					end
					local tbl17 = tbl7.CharacterHighlightParts[arg]

					if arg.Parent and not flag11 and tbl8.ForcefieldChar and tbl7.CharacterHighlightAffects[affect] then
						if not tbl17 then
							tbl17 = {
								Material = arg.Material,
								Color = arg.Color,
								Affect = affect,
								Physical = arg.CustomPhysicalProperties,
								CurrentPhysical = arg.CurrentPhysicalProperties,
							}

							tbl7.CharacterHighlightParts[arg] = tbl17

							tbl17.MaterialConnection = arg:GetPropertyChangedSignal("Material"):Connect(function()
								if arg.Material ~= Enum.Material.ForceField and tbl7.CharacterHighlightParts[arg] == tbl17 and not flag11 and tbl8.ForcefieldChar and tbl7.CharacterHighlightAffects[tbl17.Affect] then
									arg.Material = Enum.Material.ForceField
								end
							end)

							tbl17.ColorConnection = arg:GetPropertyChangedSignal("Color"):Connect(function()
								if arg.Color ~= tbl9.ForcefieldColor and tbl7.CharacterHighlightParts[arg] == tbl17 and not flag11 and tbl8.ForcefieldChar and tbl7.CharacterHighlightAffects[tbl17.Affect] then
									arg.Color = tbl9.ForcefieldColor
								end
							end)
						end

						tbl17.Affect = affect

						if affect == "Character" and arg.CustomPhysicalProperties ~= tbl17.CurrentPhysical then
							arg.CustomPhysicalProperties = tbl17.CurrentPhysical
						end

						if arg.Material ~= Enum.Material.ForceField then
							arg.Material = Enum.Material.ForceField
						end

						if arg.Color ~= tbl9.ForcefieldColor then
							arg.Color = tbl9.ForcefieldColor
						end
					elseif tbl17 then
						fn21(arg, tbl17)
					end
				end
end)
end
end
do
do
do
do
local fn30
do
local fn31
do
do
local n37 = 2147483648
local n38 = 1e9
FapGuard(24982, function()
fn31 = function(arg)
										local function fn32(arg2)
											if not arg2 or not arg2:IsA("BasePart") then
												return false
											end
											local position = arg2.Position
											return math.abs(math.abs(position.X) - n37) > n38 and math.abs(math.abs(position.Z) - n37) > n38
										end

										return fn32(arg.Part0) and fn32(arg.Part1)
									end
end)
end
end
FapGuard(24996, function()
fn30 = function(arg, arg2)
								local v22 = tbl7.ShurikenLagWelds[arg]
								if not v22 then
									return
								end

								for _, v23 in v22.Connections, nil, nil do
									v23:Disconnect()
								end

								tbl7.ShurikenLagWelds[arg] = nil

								if arg2 and not arg.Parent and v22.Parent and v22.Parent.Parent then
									arg.Parent = v22.Parent
								end
							end
end)
do
local function fn32(arg)
									if not tbl8.AntiShurikenLag or not arg:IsA("WeldConstraint") or arg.Name ~= "StickyWeld" or tbl7.BreakPartWelds[arg] or tbl7.ShurikenLagWelds[arg] then
										return
									end
									local tbl17 = { Parent = arg.Parent, Connections = {} }
									tbl7.ShurikenLagWelds[arg] = tbl17

									local function fn33()
										if tbl7.BreakPartWelds[arg] then
											if not arg.Parent and tbl17.Parent and tbl17.Parent.Parent then
												arg.Parent = tbl17.Parent
											end

											return
										end

										if arg.Part0 and arg.Part1 and not fn31(arg) then
											if arg.Parent then
												local v22 = arg
												tbl17.Parent = arg.Parent
												v22.Parent = nil
											end
										elseif not arg.Parent and tbl17.Parent and tbl17.Parent.Parent then
											arg.Parent = tbl17.Parent
										end
									end

									local connections = {}
									local connection = arg:GetPropertyChangedSignal("Enabled"):Connect(fn33)
									local connection2 = arg:GetPropertyChangedSignal("Part0"):Connect(fn33)
									local connection3 = arg:GetPropertyChangedSignal("Part1"):Connect(fn33)
									local destroying = arg.Destroying
									local connect = destroying.Connect

									local function fn34()
										fn30(arg, false)
									end

									connections[1] = connection
									connections[2] = connection2
									connections[3] = connection3

									do
										local values = table.pack(connect(destroying, fn34))
										table.move(values, 1, values.n, 4, connections)
									end

									tbl17.Connections = connections
									fn33()
								end
FapGuard(25065, function()
tbl12.SetAntiShurikenLag = function(antiShurikenLag)
									tbl8.AntiShurikenLag = antiShurikenLag
									tbl12.SetRuntimeConnection("AntiShurikenLag", workspace.DescendantAdded, antiShurikenLag, fn32)

									if antiShurikenLag then
										for _, v22 in workspace:QueryDescendants("WeldConstraint#StickyWeld") do
											fn32(v22)
										end
									else
										for k in table.clone(tbl7.ShurikenLagWelds), nil, nil do
											fn30(k, true)
										end
									end
								end
end)
end
end
end
FapGuard(25152, function()
tbl12.SpawnToy = function(arg, arg2, arg3, arg4)
						if type(arg) ~= "string" or arg == "" then
							return
						end

						if tbl7.FailedToys[arg] then
							return
						end
						local n37 = tonumber(arg3) or 0

						if tbl7.States.Spawning or #tbl7.SpawnQueue > 0 then
							if n37 <= 0 then
								return
							end
							tbl7.SpawnOrder = tbl7.SpawnOrder + 1
							local tbl17 = { Priority = n37, Order = tbl7.SpawnOrder }
							table.insert(tbl7.SpawnQueue, tbl17)

							table.sort(tbl7.SpawnQueue, function(arg5, arg6)
								local flag12

								if arg5.Priority == arg6.Priority then
									flag12 = arg5.Order < arg6.Order
								else
									flag12 = arg5.Priority > arg6.Priority
								end

								return flag12
							end)

							while true do
								task.wait()
								if not (flag11 or not tbl7.States.Spawning and tbl7.SpawnQueue[1] == tbl17) then
									continue
								end
								break
							end

							table.remove(tbl7.SpawnQueue, table.find(tbl7.SpawnQueue, tbl17))
							if flag11 then
								return
							end
						end

						local v22, v23 = tbl12.Char()
						if not v23 then
							return
						end
						local flag12 = inPlot.Value and not inOwnedPlot.Value
						if flag12 and tbl7.States.Owning then
							return
						end
						tbl7.States.Spawning = true

						if flag12 then
							tbl7.States.Owning = true
						end

						if localPlayer.CanSpawnToy.Value == false then
							repeat
								task.wait()
							until localPlayer.CanSpawnToy.Value
						end

						local cframe

						if flag12 then
							cframe = CFrame.new(0, 25, 0)
						else
							cframe = v23.CFrame + Vector3.new(0, 15, 0)
						end

						local n38 = CFrame.new((arg2 or cframe).Position) + Vector3.new(0, 0, 20)
						local rotation

						if workspace:FindFirstChild("RotateOrientPart") then
							rotation = workspace.RotateOrientPart.Rotation
						else
							rotation = Vector3.zero
						end

						local v24 = rotation
						local v25 = nil
						local connection = nil

						connection = v17.ChildAdded:Connect(function(child)
							if child.Name == arg then
								v25 = child

								if arg4 then
									tbl7.ToyAuraReserved[child] = true
								end

								if connection then
									connection:Disconnect()
								end
							end
						end)

						local cFrame2 = v23.CFrame
						local cframe2 = CFrame.new(0, 10, 0)
						local connection2 = nil

						if flag12 then
							RunService:BindToRenderStep("STClient", Enum.RenderPriority.Camera.Value - 1, function()
								v23.CFrame = cFrame2
							end)

							connection2 = RunService.Heartbeat:Connect(function()
								cFrame2 = v23.CFrame
								v23.CFrame = cframe2
							end)
						end

						local now3 = tick()

						task.spawn(function()
							tbl11.SpawnToy:InvokeServer(arg, n38, v24)
						end)

						while true do
							RunService.Heartbeat:Wait()

							if flag12 then
								task.spawn(function()
									tbl11.SpawnToy:InvokeServer(arg, n38, v24)
								end)
							end

							if not (v25 or tick() - now3 > 1.3) then
								continue
							end
							break
						end

						if flag12 then
							RunService:UnbindFromRenderStep("STClient")

							if connection2 then
								connection2:Disconnect()
							end

							if v23 then
								v23.CFrame = cFrame2
							end
						end

						if connection then
							connection:Disconnect()
						end

						if not v25 then
							tbl7.FailedToys[arg] = true

							task.delay(2, function()
								tbl7.FailedToys[arg] = nil
							end)
						end

						tbl7.States.Spawning = false

						if flag12 then
							tbl7.States.Owning = false
						end

						return v25
					end
end)
FapGuard(25320, function()
tbl12.DestroyToy = function(arg)
						if arg and arg:IsA("Model") then
							tbl11.DestroyToy:FireServer(arg)
						end
					end
end)
FapGuard(25965, function()
tbl12.FindNicePart = function(arg)
						if not arg or not arg:IsA("Model") then
							return
						end
						local v22 = tbl7.GrabbableParts[arg]
						if v22 and v22:IsDescendantOf(arg) and v22.CanQuery and not v22.Anchored then
							return v22
						end
						tbl7.GrabbableParts[arg] = nil
						local v23 = nil

						for _, v24 in ipairs(arg:QueryDescendants("BasePart")) do
							if v24.CanQuery and not v24.Anchored and v24.Name ~= "Button" then
								v23 = v23 or v24
								if (v24.AssemblyRootPart or v24) == v24 then
									tbl7.GrabbableParts[arg] = v24
									return v24
								end
							end
						end

						tbl7.GrabbableParts[arg] = v23
						return v23
					end
end)
FapGuard(26210, function()
tbl12.ExtraEscape = function()
						local v22, v23, v24 = tbl12.Char()
						if not v23 or not v24 or v24.Health == 0 or tbl7.States.Escaping or localPlayer.InPlot.Value then
							return
						end
						tbl7.States.Escaping = true
						local TractorGreen = tbl12.SpawnToy("TractorGreen", workspace.Waypoints.TudorHouse.CFrame)
						if not TractorGreen then
							tbl7.States.Escaping = false
							return
						end
						local vehicleSeat = TractorGreen:WaitForChild("VehicleSeat", 1)
						if not vehicleSeat then
							tbl7.States.Escaping = false
							return tbl12.DestroyToy(TractorGreen)
						end
						local now3 = tick()
						local flag12 = false
						v24.Sit = false
						vehicleSeat:Sit(v24)

						local connection = vehicleSeat.ChildAdded:Connect(function(child)
							if child.Name == "SeatWeld" then
								child.Enabled = false
								flag12 = true
								child:Destroy()
							end
						end)

						while true do
							fn20()
							if not (flag12 or tick() - now3 > 0.7) then
								continue
							end
							break
						end

						connection:Disconnect()
						v24.Sit = false
						tbl7.States.Escaping = false
						return tbl12.DestroyToy(TractorGreen)
					end
end)
end
do
do
do
FapGuard(27963, function()
tbl13 = {
								Shapes = {},
								ShapeNames = {},
								ShapeCache = {},
								Models = {},
								Movers = {},
								Candidates = {},
								Inventories = {},
								ActiveInventories = {},
								CharacterParts = {},
								CharacterRoots = {},
							}
end)
end
end
end
end
end
do
local v22 = nil
local bodyPosition = nil
local bodyGyro = nil
local function fn21()
				if bodyPosition then
					bodyPosition:Destroy()
					bodyPosition = nil
				end

				if bodyGyro then
					bodyGyro:Destroy()
					bodyGyro = nil
				end

				v22 = nil
			end
FapGuard(29628, function()
tbl14 = {
				GetBlobmanComponents = function()
					if not parent then
						return
					end
					local blobmanSeatAndOwnerScript = parent:FindFirstChild("BlobmanSeatAndOwnerScript")
					local rightDetector = parent:FindFirstChild("RightDetector")
					local leftDetector = parent:FindFirstChild("LeftDetector")

					return {
						Blobman = parent,
						BSAOS = blobmanSeatAndOwnerScript,
						CreatureGrab = blobmanSeatAndOwnerScript and blobmanSeatAndOwnerScript:FindFirstChild("CreatureGrab"),
						CreatureDrop = blobmanSeatAndOwnerScript and blobmanSeatAndOwnerScript:FindFirstChild("CreatureDrop"),
						CreatureRelease = blobmanSeatAndOwnerScript and blobmanSeatAndOwnerScript:FindFirstChild("CreatureRelease"),
						RightDetector = rightDetector,
						RightWeld = rightDetector and rightDetector:FindFirstChild("RightWeld"),
						RightOri = rightDetector and rightDetector:FindFirstChild("RightAlignOrientation"),
						LeftDetector = leftDetector,
						LeftWeld = leftDetector and leftDetector:FindFirstChild("LeftWeld"),
						LeftOri = leftDetector and leftDetector:FindFirstChild("LeftAlignOrientation"),
					}
				end,
				UpdateFreeze = function()
					local humanoidRootPart = parent and parent:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart ~= v22 then
						fn21()
						if not humanoidRootPart then
							return
						end
						v22 = humanoidRootPart
						bodyPosition = Instance.new("BodyPosition", humanoidRootPart)
						local v23 = bodyPosition
						local v24 = bodyPosition
						local v25 = bodyPosition
						local position = humanoidRootPart.Position
						bodyPosition.Name = "FreezeBP"
						v23.Position = position
						v24.MaxForce = Vector3.one * math.huge
						v25.D = 500
						bodyGyro = Instance.new("BodyGyro", humanoidRootPart)
						local v26 = bodyGyro
						local v27 = bodyGyro
						local v28 = bodyGyro
						local cFrame2 = humanoidRootPart.CFrame
						bodyGyro.Name = "FreezeBG"
						v26.CFrame = cFrame2
						v27.MaxTorque = Vector3.one * math.huge
						v28.D = 500
					end

					tbl12.ResetVelocity(humanoidRootPart)
				end,
				SetFrozen = function(freezeBlobman)
					tbl8.FreezeBlobman = freezeBlobman
					tbl12.SetRuntimeConnection("FreezeBlobman", RunService.Heartbeat, freezeBlobman, tbl14.UpdateFreeze)

					if not freezeBlobman then
						fn21()
					end
				end,
			}
end)
end
FapGuard(29741, function()
tbl14.Grab = function(arg, arg2)
			if not parent then
				return
			end
			local v22 = tbl14.GetBlobmanComponents()
			if not (v22.CreatureGrab and v22.RightWeld) then
				return
			end
			local v23, v24, v25 = tbl12.Char()
			if not (v24 and v25 and v25.Health > 0) or not parent then
				return
			end
			local v26, v27, v28 = tbl12.Char(arg)
			local rootAttachment = v27 and v27:FindFirstChild("RootAttachment")
			if not (rootAttachment and v28 and v28.Health > 0) or not parent then
				return
			end
			local now3 = tick()

			if tbl12.GetMagnitude(v24, v27) > 40 then
				local cFrame2 = v24.CFrame
				currentCamera.CameraType = Enum.CameraType.Scriptable

				while true do
					local flag12 = parent and v27 and v27.Parent and v25.Health > 0 and v28.Health > 0 and rootAttachment and v22.RightWeld.Attachment0 ~= rootAttachment

					if flag12 then
						flag12 = tick() - now3 < (arg2 or 0.7)
					end

					if flag12 then
						tbl12.Teleport(v24, tbl12.PredictCFrame(v27) - Vector3.new(0, 15, 0))
						task.wait()
						v22.CreatureGrab:FireServer(nil, v27, v22.RightWeld)
						continue
					end

					break
				end

				tbl12.Teleport(v24, cFrame2, CFrame.new(0, 5, 0))
				currentCamera.CameraType = Enum.CameraType.Custom
			else
				v22.CreatureGrab:FireServer(nil, v27, v22.RightWeld)
				task.wait(0.1)
			end

			if v22.RightWeld and v22.RightWeld.Attachment0 == rootAttachment then
				return true
			end
		end
end)
FapGuard(31741, function()
if inOwnedPlot.Value then
			local plotItems = workspace.PlotItems

			for _, child in pairs(workspace.Plots:GetChildren()) do
				for _, child2 in pairs(child.PlotSign.ThisPlotsOwners:GetChildren()) do
					if child2:IsA("StringValue") and child2.Value == localPlayer.Name then
						task.spawn(function()
							local v22 = plotItems:FindFirstChild(child.Name)
							v17 = v22
							v20 = child2
							table.insert(tbl7.Inventories, v22)

							repeat
								task.wait()
							until not child2.Parent

							v20 = nil
							local v23 = table.find(tbl7.Inventories, v22)

							if v23 then
								table.remove(tbl7.Inventories, v23)
							end
						end)
					end
				end
			end
		end
end)
FapGuard(31769, function()
inOwnedPlot:GetPropertyChangedSignal("Value"):Connect(function()
			if inOwnedPlot.Value then
				local plotItems = workspace.PlotItems

				for _, child in pairs(workspace.Plots:GetChildren()) do
					for _, child2 in pairs(child.PlotSign.ThisPlotsOwners:GetChildren()) do
						if child2:IsA("StringValue") and child2.Value == localPlayer.Name then
							local v22 = plotItems:FindFirstChild(child.Name)
							v17 = v22
							v20 = child2
							table.insert(tbl7.Inventories, v22)

							repeat
								task.wait()
							until not child2.Parent

							v20 = nil
							local v23 = table.find(tbl7.Inventories, v22)

							if v23 then
								table.remove(tbl7.Inventories, v23)
							end
						end
					end
				end
			else
				v17 = workspace:FindFirstChild(localPlayer.Name .. "SpawnedInToys")
			end
		end)
end)
FapGuard(31799, function()
task.spawn(function()
			local connection = nil

			local function fn21()
				local v22, v23, v24 = tbl12.Char()

				if connection then
					connection:Disconnect()
					connection = nil
				end

				connection = v24.Seated:Connect(function(arg, arg2)
					if arg and arg2 and arg2.Parent and arg2.Parent.Name == "CreatureBlobman" then
						parent = arg2.Parent
					else
						parent = nil
					end
				end)
			end

			fn21()

			localPlayer.CharacterAdded:Connect(function(character)
				while true do
					task.wait()
					local humanoid = flag11

					if not flag11 then
						humanoid = character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid")
					end

					if not humanoid then
						continue
					end
					break
				end

				if flag11 then
					return
				end
				fn21()
			end)
		end)
end)
FapGuard(32805, function()
isHeld:GetPropertyChangedSignal("Value"):Connect(tbl12.AntiGrab)
end)
FapGuard(32807, function()
task.spawn(function()
			local v22 = nil
			local boolValue = nil

			local function fn21()
				local v23
				v23, v23 = tbl12.Char()

				if v22 then
					if v22.Parent and v23 then
						v22.Parent = v23
					end

					v22 = nil
				end

				if boolValue then
					if boolValue.Parent then
						boolValue:Destroy()
					end

					boolValue = nil
				end
			end

			while task.wait() do
				if flag11 then
					fn21()
					return
				end

				if not tbl8.AntiBlobman then
					if v22 or boolValue then
						fn21()
					end

					if not tbl12.WaitForRuntimeToggle("AntiBlobman") then
						return
					end
				end

				local v23, v24, v25 = tbl12.Char()

				if not v24 or not v25 then
					if v22 then
						v22:Destroy()
						v22 = nil
					end

					if boolValue then
						if boolValue.Parent then
							boolValue:Destroy()
						end

						boolValue = nil
					end
				else
					local rootAttachment = not (v22 and v22.Parent) and v24:FindFirstChild("RootAttachment")

					if rootAttachment then
						task.wait(0.5)
						v22 = rootAttachment
						v22.Parent = ReplicatedStorage
						boolValue = Instance.new("BoolValue", v24)
						boolValue.Name = "RootAttachment"
					end

					if v24.Massless then
						v24.Massless = false
					end
				end
			end
		end)
end)
FapGuard(32881, function()
task.spawn(function()
			local v22 = nil
			local v23 = nil

			while true do
				task.wait(tbl9.InputLgDelay)

				if flag11 then
					if v22 then
						tbl12.DestroyToy(v22)
					end

					return
				else
					if not tbl8.AntiInputLag then
						if v22 then
							tbl12.DestroyToy(v22)
							v22 = nil
						end

						if not tbl12.WaitForRuntimeToggle("AntiInputLag") then
							break
						end
					end

					if not v23 or not v23.Parent then
						v23 = tbl12.DisableEndGrabEarly()
					end

					local v24, v25, v26 = tbl12.Char()

					if not v22 or not v22.Parent then
						v22 = tbl12.SpawnToy(tbl9.AntiInputType, CFrame.new(0, 1e20, 0), nil, true)
						if not v22 then
							continue
						end
					end

					local holdPart = v22 and v22:WaitForChild("HoldPart", 2)
					local holdItemRemoteFunction = holdPart and holdPart:WaitForChild("HoldItemRemoteFunction", 2)
					local dropItemRemoteFunction = holdItemRemoteFunction and holdPart:WaitForChild("DropItemRemoteFunction", 2)

					if v22.Name ~= tbl9.AntiInputType then
						tbl12.DestroyToy(v22)
					end

					pcall(function()
						if holdPart.RigidConstraint.Attachment1 ~= v24["Left Arm"].LeftGripAttachment and holdPart.RigidConstraint.Attachment1 ~= nil and holdPart.RigidConstraint.Attachment1 ~= v24["Right Arm"].RightGripAttachment then
							tbl12.DestroyToy(v22)
						end
					end)

					task.spawn(function()
						for _, v27 in pairs(v22:QueryDescendants("BasePart")) do
							v27.CanCollide = false

							if v27:IsA("MeshPart") or v27.Name == "Part" then
								v27.Transparency = tbl9.AILTransparency
							end
						end
					end)

					if v24 and v26 and v26.Health ~= 0 and holdItemRemoteFunction and dropItemRemoteFunction then
						task.spawn(function()
							local vector = Vector3.new
							dropItemRemoteFunction:InvokeServer(v22, CFrame.new(0, 1e20, 0), vector())
						end)

						task.spawn(function()
							holdItemRemoteFunction:InvokeServer(v22, v24)
						end)
					elseif not holdItemRemoteFunction or not dropItemRemoteFunction then
						tbl12.DestroyToy(v22)
						v22 = nil
					end
				end
			end
		end)
end)
FapGuard(32960, function()
if not tbl11.Explode then
			return
		end
end)
FapGuard(32964, function()
workspace.ChildAdded:Connect(function(child)
			local v22, v23, v24 = tbl12.Char()

			if child.Name == "Part" and tbl8.AntiExplosion and v23 and v24 then
				if (child.Position - v23.Position).Magnitude <= 20 then
					v23.Anchored = true
					task.wait(0.02)

					if not v24.SeatPart then
						v24.Sit = false
					end

					for _, v25 in pairs(v22:QueryDescendants("#RagdollLimbPart")) do
						v25.CanCollide = false
					end

					tbl12.ResetVelocity(v23)
					v23.Anchored = false
				end
			end
		end)
end)
FapGuard(32986, function()
task.spawn(function()
			local extinguishPart = map.Hole.PoisonSmallHole:FindFirstChild("ExtinguishPart")
			if not extinguishPart then
				return
			end

			if extinguishPart:FindFirstChild("Tex") then
				extinguishPart.Tex:Destroy()
			end

			extinguishPart.Transparency = 1

			local function fn21(character)
				if flag11 then
					return
				end
				local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 2)
				if not humanoidRootPart then
					return
				end

				humanoidRootPart.ChildAdded:Connect(function(child)
					if flag11 then
						return
					end

					if child.Name == "FireParticleEmitter" and tbl8.AntiBurn then
						local cFrame2 = extinguishPart.CFrame
						local fireLight = humanoidRootPart:FindFirstChild("FireLight")

						if fireLight then
							fireLight:Destroy()
						end

						child.Enabled = false
						local screenOverlayGui = playerGui:FindFirstChild("ScreenOverlayGui")
						screenOverlayGui = screenOverlayGui and screenOverlayGui:FindFirstChild("FireFade")

						if screenOverlayGui then
							screenOverlayGui.Visible = false
						end

						while true do
							extinguishPart.CFrame = humanoidRootPart.CFrame
							task.wait()
							if not (not child.Parent or not humanoidRootPart.Parent) then
								continue
							end
							break
						end

						extinguishPart.CFrame = cFrame2
					end
				end)
			end

			localPlayer.CharacterAdded:Connect(fn21)
			local v22 = tbl12.Char()

			if v22 then
				fn21(v22)
			end
		end)
end)
FapGuard(33050, function()
task.spawn(function()
			while task.wait(0.03) do
				if flag11 then
					return
				end

				if not tbl8.AntiVoid and not tbl12.WaitForRuntimeToggle("AntiVoid") then
					return
				end
				local v22, v23 = tbl12.Char()
				local flag12

				if v23 then
					flag12 = v23.Position.Y >= 10000 or v23.Position.Y <= -500
				else
					flag12 = v23
				end

				flag12 = flag12 and not ((v23.Position - part3.Position).Magnitude < 150)

				if flag12 then
					tbl12.Teleport(v23, CFrame.new(0, 15, 0))
				end
			end
		end)
end)
do
local function fn21()
				local n36 = os.clock() + 0.35

				repeat
					local v22 = tbl12.DetectPCLD(localPlayer)
					if v22 and v22.Parent and not tbl12.IsWaitingPCLD(v22) then
						return v22
					end
					task.wait(0.05)
				until flag11 or not tbl8.AntiKick or os.clock() >= n36
			end
local function fn22(arg)
				local NinjaShuriken = tbl12.SpawnToy("NinjaShuriken", arg.CFrame + Vector3.new(0, 15, 0), 3, true)
				local stickyPart = NinjaShuriken and NinjaShuriken:WaitForChild("StickyPart", 1.5)
				local stickyWeld = stickyPart and stickyPart:WaitForChild("StickyWeld", 1.5)
				if stickyPart and stickyWeld and tbl12.SNO(stickyPart) then
					return NinjaShuriken, stickyPart, stickyWeld
				end
				tbl12.DestroyToy(NinjaShuriken)
			end
FapGuard(33099, function()
task.spawn(function()
				while task.wait(0.03) do
					if flag11 then
						return
					end

					if not tbl8.AntiKick then
						if v18 then
							tbl12.DestroyToy(v18)
							v18 = nil
						end

						if not tbl12.WaitForRuntimeToggle("AntiKick") then
							return
						end
					end

					local antiKickSettings = tbl7.AntiKickSettings
					local v22, v23, v24 = tbl12.Char()
					local ragdollTouchedHitbox = v23 and v23:FindFirstChild("RagdollTouchedHitbox")

					if v23 and v24 and ragdollTouchedHitbox and v24.Health > 0 then
						if localPlayer.InPlot.Value then
							while true do
								task.wait()
								if not (not localPlayer.InPlot.Value or localPlayer.InOwnedPlot.Value) then
									continue
								end
								break
							end
						end

						if tbl9.AKType == "Shuriken" then
							local parent2, shurHighlight, highlight2, antiKick, forcefieldChar, transparency, isMeshPart

							if not (v18 and v18.Name == "ShurikenRSC" and v18:FindFirstChild("StickyPart") and v18.StickyPart:FindFirstChild("StickyWeld") and v18.StickyPart.StickyWeld.Part1 == ragdollTouchedHitbox) then
								local stickyPart = nil
								local stickyWeld, now3, flag12, flag13

								if not v18 or not v18.Parent then
									tbl12.DestroyToy(v18)
									v18 = nil
									local v25 = fn21()
									stickyWeld = nil

									if v25 then
										local v26
										v26, stickyPart, stickyWeld = fn22(v25)
										v18 = v26
									end

									if not v18 then
										local v26
										v26, stickyPart, stickyWeld = fn22(v23)
										v18 = v26

										if v18 then
											v18.Name = "ShurikenRSC"

											task.spawn(function()
												local touchInterest = stickyPart:WaitForChild("TouchInterest", 2.5)

												if touchInterest then
													touchInterest:Destroy()
												end
											end)

											tbl11.StickyPartEvent:FireServer(stickyPart, ragdollTouchedHitbox, CFrame.new(0, -0.3, 0) * CFrame.Angles(1.5707963267948966, 0, 0))
											now3 = tick()

											while true do
												fn20()
												flag12 = stickyWeld.Part1 == ragdollTouchedHitbox or not stickyWeld.Parent or not ragdollTouchedHitbox.Parent or not v24.Parent
												flag13 = flag12 or v24.Health == 0 or tick() - now3 > 0.5
												if not flag13 then
													continue
												end
												break
											end

											parent2 = v18 and v18.Parent

											if parent2 then
												if not tbl8.AntiKick then
													tbl12.DestroyToy(v18)
													v18 = nil
												else
													shurHighlight = v18:FindFirstChild("ShurHighlight")

													if not shurHighlight then
														shurHighlight = Instance.new("Highlight")
														shurHighlight.Name = "ShurHighlight"
														shurHighlight.Adornee = v18
														shurHighlight.Parent = v18
													end

													if shurHighlight.Enabled ~= antiKickSettings.Highlight then
														shurHighlight.Enabled = antiKickSettings.Highlight
													end

													if shurHighlight.FillColor ~= antiKickSettings.HighlightFill then
														shurHighlight.FillColor = antiKickSettings.HighlightFill
													end

													if shurHighlight.OutlineColor ~= antiKickSettings.HighlightOutl then
														shurHighlight.OutlineColor = antiKickSettings.HighlightOutl
													end

													if shurHighlight.FillTransparency ~= antiKickSettings.HighlightFT then
														shurHighlight.FillTransparency = antiKickSettings.HighlightFT
													end

													if shurHighlight.OutlineTransparency ~= antiKickSettings.HighlightOT then
														shurHighlight.OutlineTransparency = antiKickSettings.HighlightOT
													end

													highlight2 = antiKickSettings.Highlight

													if highlight2 then
														antiKick = highlight2
													else
														forcefieldChar = tbl8.ForcefieldChar
														antiKick = forcefieldChar and tbl7.CharacterHighlightAffects["Anti Kick"]
													end

													if antiKick then
														transparency = 0
													else
														transparency = antiKickSettings.Transparency
													end

													for _, child in ipairs(v18:GetChildren()) do
														if child:IsA("BasePart") then
															if tbl12.ApplyCharacterHighlightPart then
																tbl12.ApplyCharacterHighlightPart(child, "Anti Kick")
															end

															isMeshPart = child.Transparency ~= transparency and (child:IsA("MeshPart") or child.Name == "Part")

															if isMeshPart then
																child.Transparency = transparency
															end

															if child.CanCollide then
																child.CanCollide = false
															end

															if child.CanQuery then
																child.CanQuery = false
															end
														end
													end
												end
											end
										end
									elseif v18 then
										v18.Name = "ShurikenRSC"

										task.spawn(function()
											local touchInterest = stickyPart:WaitForChild("TouchInterest", 2.5)

											if touchInterest then
												touchInterest:Destroy()
											end
										end)

										tbl11.StickyPartEvent:FireServer(stickyPart, ragdollTouchedHitbox, CFrame.new(0, -0.3, 0) * CFrame.Angles(1.5707963267948966, 0, 0))
										now3 = tick()

										while true do
											fn20()
											flag12 = stickyWeld.Part1 == ragdollTouchedHitbox or not stickyWeld.Parent or not ragdollTouchedHitbox.Parent or not v24.Parent
											flag13 = flag12 or v24.Health == 0 or tick() - now3 > 0.5
											if not flag13 then
												continue
											end
											break
										end

										parent2 = v18 and v18.Parent

										if parent2 then
											if not tbl8.AntiKick then
												tbl12.DestroyToy(v18)
												v18 = nil
											else
												shurHighlight = v18:FindFirstChild("ShurHighlight")

												if not shurHighlight then
													shurHighlight = Instance.new("Highlight")
													shurHighlight.Name = "ShurHighlight"
													shurHighlight.Adornee = v18
													shurHighlight.Parent = v18
												end

												if shurHighlight.Enabled ~= antiKickSettings.Highlight then
													shurHighlight.Enabled = antiKickSettings.Highlight
												end

												if shurHighlight.FillColor ~= antiKickSettings.HighlightFill then
													shurHighlight.FillColor = antiKickSettings.HighlightFill
												end

												if shurHighlight.OutlineColor ~= antiKickSettings.HighlightOutl then
													shurHighlight.OutlineColor = antiKickSettings.HighlightOutl
												end

												if shurHighlight.FillTransparency ~= antiKickSettings.HighlightFT then
													shurHighlight.FillTransparency = antiKickSettings.HighlightFT
												end

												if shurHighlight.OutlineTransparency ~= antiKickSettings.HighlightOT then
													shurHighlight.OutlineTransparency = antiKickSettings.HighlightOT
												end

												highlight2 = antiKickSettings.Highlight

												if highlight2 then
													antiKick = highlight2
												else
													forcefieldChar = tbl8.ForcefieldChar
													antiKick = forcefieldChar and tbl7.CharacterHighlightAffects["Anti Kick"]
												end

												if antiKick then
													transparency = 0
												else
													transparency = antiKickSettings.Transparency
												end

												for _, child in ipairs(v18:GetChildren()) do
													if child:IsA("BasePart") then
														if tbl12.ApplyCharacterHighlightPart then
															tbl12.ApplyCharacterHighlightPart(child, "Anti Kick")
														end

														isMeshPart = child.Transparency ~= transparency and (child:IsA("MeshPart") or child.Name == "Part")

														if isMeshPart then
															child.Transparency = transparency
														end

														if child.CanCollide then
															child.CanCollide = false
														end

														if child.CanQuery then
															child.CanQuery = false
														end
													end
												end
											end
										end
									end
								else
									stickyPart = v18:WaitForChild("StickyPart", 1.5)
									stickyWeld = stickyPart and stickyPart:WaitForChild("StickyWeld", 1.5)

									if not (stickyPart and stickyWeld) or not tbl12.SNO(stickyPart) then
										tbl12.DestroyToy(v18)
										v18 = nil
									elseif v18 then
										v18.Name = "ShurikenRSC"

										task.spawn(function()
											local touchInterest = stickyPart:WaitForChild("TouchInterest", 2.5)

											if touchInterest then
												touchInterest:Destroy()
											end
										end)

										tbl11.StickyPartEvent:FireServer(stickyPart, ragdollTouchedHitbox, CFrame.new(0, -0.3, 0) * CFrame.Angles(1.5707963267948966, 0, 0))
										now3 = tick()

										while true do
											fn20()
											flag12 = stickyWeld.Part1 == ragdollTouchedHitbox or not stickyWeld.Parent or not ragdollTouchedHitbox.Parent or not v24.Parent
											flag13 = flag12 or v24.Health == 0 or tick() - now3 > 0.5
											if not flag13 then
												continue
											end
											break
										end

										parent2 = v18 and v18.Parent

										if parent2 then
											if not tbl8.AntiKick then
												tbl12.DestroyToy(v18)
												v18 = nil
											else
												shurHighlight = v18:FindFirstChild("ShurHighlight")

												if not shurHighlight then
													shurHighlight = Instance.new("Highlight")
													shurHighlight.Name = "ShurHighlight"
													shurHighlight.Adornee = v18
													shurHighlight.Parent = v18
												end

												if shurHighlight.Enabled ~= antiKickSettings.Highlight then
													shurHighlight.Enabled = antiKickSettings.Highlight
												end

												if shurHighlight.FillColor ~= antiKickSettings.HighlightFill then
													shurHighlight.FillColor = antiKickSettings.HighlightFill
												end

												if shurHighlight.OutlineColor ~= antiKickSettings.HighlightOutl then
													shurHighlight.OutlineColor = antiKickSettings.HighlightOutl
												end

												if shurHighlight.FillTransparency ~= antiKickSettings.HighlightFT then
													shurHighlight.FillTransparency = antiKickSettings.HighlightFT
												end

												if shurHighlight.OutlineTransparency ~= antiKickSettings.HighlightOT then
													shurHighlight.OutlineTransparency = antiKickSettings.HighlightOT
												end

												highlight2 = antiKickSettings.Highlight

												if highlight2 then
													antiKick = highlight2
												else
													forcefieldChar = tbl8.ForcefieldChar
													antiKick = forcefieldChar and tbl7.CharacterHighlightAffects["Anti Kick"]
												end

												if antiKick then
													transparency = 0
												else
													transparency = antiKickSettings.Transparency
												end

												for _, child in ipairs(v18:GetChildren()) do
													if child:IsA("BasePart") then
														if tbl12.ApplyCharacterHighlightPart then
															tbl12.ApplyCharacterHighlightPart(child, "Anti Kick")
														end

														isMeshPart = child.Transparency ~= transparency and (child:IsA("MeshPart") or child.Name == "Part")

														if isMeshPart then
															child.Transparency = transparency
														end

														if child.CanCollide then
															child.CanCollide = false
														end

														if child.CanQuery then
															child.CanQuery = false
														end
													end
												end
											end
										end
									end
								end
							else
								parent2 = v18 and v18.Parent

								if parent2 then
									if not tbl8.AntiKick then
										tbl12.DestroyToy(v18)
										v18 = nil
									else
										shurHighlight = v18:FindFirstChild("ShurHighlight")

										if not shurHighlight then
											shurHighlight = Instance.new("Highlight")
											shurHighlight.Name = "ShurHighlight"
											shurHighlight.Adornee = v18
											shurHighlight.Parent = v18
										end

										if shurHighlight.Enabled ~= antiKickSettings.Highlight then
											shurHighlight.Enabled = antiKickSettings.Highlight
										end

										if shurHighlight.FillColor ~= antiKickSettings.HighlightFill then
											shurHighlight.FillColor = antiKickSettings.HighlightFill
										end

										if shurHighlight.OutlineColor ~= antiKickSettings.HighlightOutl then
											shurHighlight.OutlineColor = antiKickSettings.HighlightOutl
										end

										if shurHighlight.FillTransparency ~= antiKickSettings.HighlightFT then
											shurHighlight.FillTransparency = antiKickSettings.HighlightFT
										end

										if shurHighlight.OutlineTransparency ~= antiKickSettings.HighlightOT then
											shurHighlight.OutlineTransparency = antiKickSettings.HighlightOT
										end

										highlight2 = antiKickSettings.Highlight

										if highlight2 then
											antiKick = highlight2
										else
											forcefieldChar = tbl8.ForcefieldChar
											antiKick = forcefieldChar and tbl7.CharacterHighlightAffects["Anti Kick"]
										end

										if antiKick then
											transparency = 0
										else
											transparency = antiKickSettings.Transparency
										end

										for _, child in ipairs(v18:GetChildren()) do
											if child:IsA("BasePart") then
												if tbl12.ApplyCharacterHighlightPart then
													tbl12.ApplyCharacterHighlightPart(child, "Anti Kick")
												end

												isMeshPart = child.Transparency ~= transparency and (child:IsA("MeshPart") or child.Name == "Part")

												if isMeshPart then
													child.Transparency = transparency
												end

												if child.CanCollide then
													child.CanCollide = false
												end

												if child.CanQuery then
													child.CanQuery = false
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end)
end)
end
FapGuard(33542, function()
task.spawn(function()
			while task.wait(0.2) do
				if flag11 then
					return
				end

				if not tbl8.AntiKick2 and not tbl12.WaitForRuntimeToggle("AntiKick2") then
					return
				end
				local v22, v23, v24 = tbl12.Char()

				if v24 then
					if not v24:GetAttribute("BrokenPCLD") or v24.Health <= 0 then
						local result = nil

						if v24.Health > 0 then
							fn18("Starting PCLD Break...", "PCLD Breaker")

							task.spawn(function()
								repeat
									v24.Health = 0
									v24:ChangeState(Enum.HumanoidStateType.Dead)
									fn20()
								until result
							end)
						else
							fn18("Detected death, breaking PCLD again...", "PCLD Breaker")
						end

						result = localPlayer.CharacterAdded:Wait()
						local humanoid = result:WaitForChild("Humanoid", 5)

						if humanoid then
							local result2 = nil

							task.spawn(function()
								repeat
									humanoid.Health = 0
									humanoid:ChangeState(Enum.HumanoidStateType.Dead)
									fn20()
								until result2
							end)

							result2 = localPlayer.CharacterAdded:Wait()
							local humanoid2 = result2:WaitForChild("Humanoid", 5)

							if humanoid2 then
								humanoid2:SetAttribute("BrokenPCLD", true)
								fn18("Done!", "PCLD Breaker")
							end
						end
					end
				end
			end
		end)
end)
do
local flag12 = false
FapGuard(33601, function()
task.delay(2.5, function()
				flag12 = true
			end)
end)
FapGuard(33605, function()
RunService.Heartbeat:Connect(function(deltaTime)
				if flag11 or not flag12 or not tbl8.AutoAntiLag then
					return
				end
				local antiLagSens = tbl9.AntiLagSens

				if math.floor(1 / deltaTime) < antiLagSens and toggles.AntiLag and not toggles.AntiLag.Value then
					fn18("Anti Lag Enabled || Too low fps", "Auto Anti Lag")
					toggles.AntiLag:SetValue(true)
				end
			end)
end)
end
FapGuard(33618, function()
task.spawn(function()
			task.wait(0.5)

			while task.wait(0.03) do
				if flag11 then
					return
				end

				if not tbl8.AntiSnowball and not tbl12.WaitForRuntimeToggle("AntiSnowball") then
					return
				end

				if tbl8.GucciAntiGrab then
					repeat
						task.wait()
					until not tbl8.GucciAntiGrab

					task.wait(1)
				end

				if tbl8.AntiBanana then
					local v22 = tbl12.Char()

					if v22 and v22:FindFirstChild("Right Leg") then
						while true do
							task.wait()
							local v23 = tbl12.Char()
							if v23 and v23:FindFirstChild("Right Leg") then
								continue
							end
							break
						end
					end
				end

				local v22, v23, v24 = tbl12.Char()
				local weldHRP = v23 and v23:FindFirstChild("WeldHRP")

				if not (not weldHRP or not v24 or v24.Health == 0 or not v23) then
					tbl11.RagdollRemote:FireServer(v23, 0.5)

					if not v24.SeatPart then
						v24.Sit = false
					end

					v24.AutoRotate = true

					if weldHRP.Enabled then
						ContextActionService:UnbindAction("JumpRemover")
						v24:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
						tbl12.RepositionLimbs(v22)
						tbl12.ToggleCollisions(v22, false, false, true)
					end
				end
			end
		end)
end)
FapGuard(33675, function()
task.spawn(function()
			task.wait(2)

			while task.wait(0.03) do
				if flag11 then
					return
				end

				if not tbl8.AntiBanana and not tbl12.WaitForRuntimeToggle("AntiBanana") then
					return
				end
				local rightLeg, v22, v23 = tbl12.Char()
				rightLeg = rightLeg and rightLeg:FindFirstChild("Right Leg")
				local gucciAntiGrab = tbl8.GucciAntiGrab

				if rightLeg and v22 and v23 and v23.Health ~= 0 and tbl12.IsNetworkOwner(v22) then
					if gucciAntiGrab then
						toggles.GucciAntiGrab:SetValue(false)
						task.wait(0.25)
					end

					v23.Sit = false
					v23.HipHeight = 2
					tbl12.BreakLimb(localPlayer, "Legs")
					local connection = nil

					connection = v23:GetPropertyChangedSignal("HipHeight"):Connect(function()
						if not tbl8.AntiBanana then
							return connection:Disconnect()
						end
						v23.HipHeight = 2
					end)

					local now3 = tick()

					while true do
						task.wait()
						if not (not rightLeg.Parent or v23.Health == 0 or tick() - now3 > 0.75) then
							continue
						end
						break
					end

					if gucciAntiGrab then
						toggles.GucciAntiGrab:SetValue(true)
					end
				elseif v23 and v23.Health == 0 then
					localPlayer.CharacterAdded:Wait()
					task.wait(0.5)
				end
			end
		end)
end)
do
local gameCorrectionsNotify = ReplicatedStorage.GameCorrectionEvents.GameCorrectionsNotify
FapGuard(33731, function()
if gameCorrectionsNotify then
				local n36 = 0

				gameCorrectionsNotify.OnClientEvent:Connect(function(arg)
					if flag11 then
						return
					end

					if arg == "Flying" then
						local now3 = tick()

						if now3 - n36 > 1 then
							n36 = now3
							tbl9.KickFlags = 1
						else
							tbl9.KickFlags = tbl9.KickFlags + 1
						end

						if tbl8.AutoReset then
							if tbl9.KickFlags >= 4 and tbl8.AutoLeave then
								return localPlayer:Kick("Resonance (Auto Reset)\nAvoided Kick")
							end
							local v22, v23, v24 = tbl12.Char()

							if v24 then
								v24:ChangeState(Enum.HumanoidStateType.Running)
								v24:ChangeState(Enum.HumanoidStateType.Dead)

								if tbl9.KickFlags == 1 then
									fn18("Reset due to kick flag", "Auto Reset")
								end
							end
						end
					end
				end)
			end
end)
end
do
local connection = nil
local function fn21()
				local v22, head = tbl12.Char()
				head = head and v22:FindFirstChild("Head")
				if not head then
					return
				end

				connection = head.ChildAdded:Connect(function(child)
					if flag11 then
						return
					end

					if not child:IsA("StringValue") then
						return
					end
					local v23 = Players:FindFirstChild(child.Value)

					if child.Name == "PartOwner" and v23 then
						tbl9.WhoGrabbed = tbl12.FormatPlayer(v23)

						if tbl12.UpdateLastGrabbedLabel then
							tbl12.UpdateLastGrabbedLabel()
						end

						-- (Counter-attack removed: it applied Kill/Void/Fling to other players)
					end
				end)
			end
FapGuard(33801, function()
localPlayer.CharacterAdded:Connect(function(character)
				if connection then
					connection:Disconnect()
				end

				while true do
					task.wait()
					local head = flag11

					if not flag11 then
						head = character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head")
					end

					if not head then
						continue
					end
					break
				end

				if flag11 then
					return
				end
				fn21()
			end)
end)
FapGuard(33826, function()
fn21()
end)
end
do
-- Binds the ported tab code to the controls that already exist on the DEFENSE tab.
-- The tab code calls AddToggle / AddSlider / AddDropdown with a Callback; here that callback is
-- attached to the matching existing control and run once with its current value so the engine
-- starts in the same state as the visible control.
do
    local function newGroup()
        local group = {}

        function group:AddToggle(key, info)
            local entry = FapDefenseControls.Toggles[key]
            entry.Callback = info.Callback
            entry.AddKeyPicker = function(self)
                return self
            end
            entry.AddColorPicker = function(self, colorKey, colorInfo)
                local colorEntry = FapDefenseControls.Options[colorKey]
                if colorEntry then
                    colorEntry.Callback = colorInfo.Callback
                    if colorInfo.Callback then
                        colorInfo.Callback(colorEntry.Value)
                    end
                end
                return self
            end
            -- Toggles that are already on (default or pressed before the engine was ready).
            if entry.Value and info.Callback then
                info.Callback(true)
            end
            return entry
        end

        function group:AddSlider(key, info)
            local entry = FapDefenseControls.Options[key]
            entry.Callback = info.Callback
            if info.Callback then
                info.Callback(entry.Value)
            end
            return entry
        end

        function group:AddDropdown(key, info)
            local entry = FapDefenseControls.Options[key]
            entry.Callback = info.Callback
            if info.Callback and entry.Value ~= nil then
                info.Callback(entry.Value)
            end
            return entry
        end

        function group:AddLabel(first, second)
            if type(second) == "table" and FapDefenseControls.Labels[first] then
                return FapDefenseControls.Labels[first]
            end
            return {
                SetText = function() end,
                SetVisible = function() end,
            }
        end

        function group:AddDivider() end

        return group
    end

    tbl15 = {
        Invincibility = {
            AddLeftGroupbox = function()
                return newGroup()
            end,
            AddRightGroupbox = function()
                return newGroup()
            end,
        },
    }
end

local Antis = tbl15.Invincibility:AddLeftGroupbox("Antis", "brick-wall-shield")
Antis:AddToggle("AntiGrab", {
			Text = "Anti Grab",
			Default = false,
			Tooltip = "The most default anti-grab",
			Callback = function(antiGrab)
				tbl8.AntiGrab = antiGrab
				tbl12.AntiGrab()
			end,
		})
Antis:AddToggle("GucciAntiGrab", {
			Text = "[GUCCI] Anti Grab",
			Default = false,
			Tooltip = "Can't be touched.",
			Callback = function(arg)
				tbl12.SetGucciAntiGrab(arg)
			end,
		}):AddKeyPicker("GucciK", {
			Text = "[GUCCI] Anti Grab",
			Default = nil,
			Mode = "Toggle",
			NoUI = false,
			SyncToggleState = true,
		})
Antis:AddToggle("AntiBlobman", {
			Text = "Anti Blobman",
			Default = false,
			Tooltip = "People can't grab you using Blobman",
			Callback = function(arg)
				tbl12.SetRuntimeToggle("AntiBlobman", arg)
			end,
		})
Antis:AddToggle("AntiInputLag", {
			Text = "Anti Network Ownership",
			Default = false,
			Tooltip = "Anti Blob-kill, etc.",
			Callback = function(arg)
				tbl12.SetRuntimeToggle("AntiInputLag", arg)
			end,
		}):AddKeyPicker("AntiNetK", {
			Text = "Anti Network Ownership",
			Default = nil,
			Mode = "Toggle",
			NoUI = false,
			SyncToggleState = true,
		})
Antis:AddToggle("AntiExplosion", {
			Text = "Anti Explosion",
			Default = false,
			Tooltip = "Makes you not able to be exploded",
			Callback = function(antiExplosion)
				tbl8.AntiExplosion = antiExplosion
			end,
		})
Antis:AddToggle("AntiBurn", {
			Text = "Anti Burn",
			Default = false,
			Tooltip = "Makes you not able to be burnt",
			Callback = function(antiBurn)
				tbl8.AntiBurn = antiBurn
			end,
		})
Antis:AddToggle("AntiVoid", {
			Text = "Anti Void",
			Default = false,
			Tooltip = "Teleports you up if you go far down into the void",
			Callback = function(arg)
				tbl12.SetRuntimeToggle("AntiVoid", arg)
			end,
		})
Antis:AddToggle("AntiKick", {
			Text = "Anti Kick",
			Default = false,
			Tooltip = "Default shuriken anti-kick",
			Callback = function(arg)
				tbl12.SetRuntimeToggle("AntiKick", arg)
				tbl12.WakeRuntimeGate("PCLDTracking")
			end,
		})
Antis:AddToggle("AntiKick2", {
			Text = "[Break PCLD] Anti Kick",
			Default = false,
			Tooltip = "Unable to get kicked at all",
			Callback = function(arg)
				tbl12.SetRuntimeToggle("AntiKick2", arg)
			end,
		})
Antis:AddToggle("AntiSticky", {
			Text = "Anti Sticky",
			Default = false,
			Tooltip = "Protects your character from sticky toys",
			Callback = function(antiSticky)
				tbl8.AntiSticky = antiSticky

				task.spawn(function()
					while tbl8.AntiSticky and task.wait(0.1) do
						local v20 = tbl12.Char()

						if v20 then
							for _, v21 in pairs(v20:QueryDescendants("BasePart")) do
								for _, v22 in pairs(v21:GetConnectedParts()) do
									if not (v22.Name ~= "StickyPart" or v22:IsDescendantOf(v17) or v22:IsDescendantOf(workspace.PlotItems) and not localPlayer.InOwnedPlot.Value) then
										for _, child in pairs(v22:GetChildren()) do
											if child:IsA("TouchInterest") then
												child:Destroy()
											end
										end

										local parent2 = v22.Parent

										if parent2 then
											local v23 = tbl12.FindNicePart(parent2)

											if v23 then
												tbl12.Grab(v23)
											end
										end
									end
								end
							end
						end
					end
				end)
			end,
		})
Antis:AddToggle("AntiSnowball", {
			Text = "Anti Snowball",
			Default = false,
			Tooltip = "Prevents you from getting snowballed",
			Callback = function(arg)
				tbl12.SetRuntimeToggle("AntiSnowball", arg)

				if not arg then
					local v20 = tbl12.Char()
					if not v20 then
						return
					end
					tbl12.ToggleCollisions(v20, true)
				end
			end,
		})
Antis:AddToggle("AntiBanana", {
			Text = "Anti Banana",
			Default = false,
			Tooltip = "Bananas won't touch you",
			Callback = function(arg)
				tbl12.SetRuntimeToggle("AntiBanana", arg)
			end,
		})
Antis:AddToggle("AntiPaint", {
			Text = "Anti Paint",
			Default = false,
			Tooltip = "You won't get painted",
			Callback = function(antiPaint)
				tbl8.AntiPaint = antiPaint

				task.spawn(function()
					local tbl16 = {}

					local function fn21(descendant)
						if descendant:IsA("BasePart") and descendant.Name == "PaintPlayerPart" then
							descendant.CanTouch = not antiPaint

							if antiPaint then
								tbl16[descendant] = descendant:GetPropertyChangedSignal("CanTouch"):Connect(function()
									if not tbl8.AntiPaint then
										return
									end
									descendant.CanTouch = false
								end)
							end
						end
					end

					for _, v20 in pairs(workspace:QueryDescendants("BasePart#PaintPlayerPart")) do
						fn21(v20)
					end

					if antiPaint then
						local connection = workspace.DescendantAdded:Connect(fn21)

						repeat
							task.wait()
						until not tbl8.AntiPaint

						connection:Disconnect()

						for _, v20 in pairs(tbl16) do
							v20:Disconnect()
						end
					end
				end)
			end,
		})
Antis:AddToggle("AntiPoison", {
			Text = "Anti Poison",
			Default = false,
			Tooltip = "Poison parts won't kill you",
			Callback = function(arg)
				local hole = map:FindFirstChild("Hole")
				local poisonBigHole = hole and hole:FindFirstChild("PoisonBigHole")
				hole = hole and hole:FindFirstChild("PoisonSmallHole")

				for _, v20 in pairs({ poisonBigHole, hole }) do
					if v20 then
						local poisonHurtPart = v20:FindFirstChild("PoisonHurtPart")
						local paintPlayerPart = v20:FindFirstChild("PaintPlayerPart")

						if poisonHurtPart then
							poisonHurtPart.CanTouch = not arg
						end

						if paintPlayerPart then
							paintPlayerPart.CanTouch = not arg
						end
					end
				end
			end,
		})
Antis:AddToggle("AntiLag", {
			Text = "Anti Lag",
			Default = false,
			Tooltip = "Anti Line-Lag & Sticky-Lag",
			Callback = function(arg)
				local enabled = not arg
				if enabled and tbl7.LookFigures.Enabled then
					toggles.AntiLag:SetValue(true)
					return
				end
				localPlayer.PlayerScripts.CharacterAndBeamMove.Enabled = enabled
				localPlayer.PlayerScripts.StickyPartsTouchDetection.Enabled = enabled
				tbl12.SetAntiShurikenLag(arg)

				if arg then
					task.delay(1.5, function()
						if flag11 or not toggles.AntiLag.Value then
							return
						end

						for _, v20 in pairs(tbl7.PlayerList) do
							local v21 = tbl12.Char(v20)

							if v21 then
								for _, child in pairs(v21:GetChildren()) do
									if child.Name == "GrabParts" then
										child:Destroy()
									end
								end
							end
						end
					end)
				end
			end,
		}):AddKeyPicker("AntiLagK", { Text = "Anti Lag", Default = nil, Mode = "Toggle", NoUI = false, SyncToggleState = true })
Antis:AddToggle("AutoAntiLag", {
			Text = "Auto Anti Lag",
			Default = true,
			Tooltip = "Enables anti-lag for you if too low fps",
			Callback = function(autoAntiLag)
				tbl8.AutoAntiLag = autoAntiLag
			end,
		})
Antis:AddToggle("AntiInvis", {
			Text = "Anti Invis",
			Default = false,
			Tooltip = "Makes any invisible players visible",
			Callback = function()
				task.spawn(function()
					while toggles.AntiInvis and toggles.AntiInvis.Value do
						for _, v20 in tbl7.PlayerList, nil, nil do
							if v20 ~= localPlayer then
								local v21, v22, v23 = tbl12.Char(v20)

								if v22 then
									v22.Massless = false
								end

								if v23 and v23.Sit and v23.SeatPart then
									local seatPart = v23.SeatPart
									local seatWeld = seatPart:FindFirstChild("SeatWeld")

									if seatPart.Parent and seatWeld and not seatWeld.Enabled then
										seatWeld.Enabled = true
									end
								end
							end
						end

						task.wait(0.1)
					end
				end)
			end,
		})
Antis:AddToggle("AutoReset", {
			Text = "Auto Reset",
			Default = true,
			Tooltip = "Checks for kick frame and resets when needed",
			Callback = function(autoReset)
				tbl8.AutoReset = autoReset
			end,
		})
Antis:AddToggle("LoopTP", {
			Text = "Loop TP",
			Default = false,
			Tooltip = "Teleports you infinitely so you're unable to be grabbed",
			Callback = function(loopTP)
				tbl8.LoopTP = loopTP

				task.spawn(function()
					local v20
					v20, v20 = tbl12.Char()
					local cFrame2

					if v20 then
						cFrame2 = v20.CFrame
					else
						cFrame2 = CFrame.new(0, -5, 0)
					end

					while tbl8.LoopTP and fn20(0.04) do
						local v21 = tbl12.Char()

						if v21 then
							local random = math.random
							local cframe = CFrame.new(math.random(-1000, 1000), -7.35, random(-1000, 1000))
							tbl12.PivotTo(v21, cframe)
						end
					end

					local v21 = tbl12.Char()

					if v21 then
						tbl12.PivotTo(v21, cFrame2)
					end
				end)
			end,
		})
local Miscellaneous = tbl15.Invincibility:AddRightGroupbox("Miscellaneous", "bolt")
Miscellaneous:AddToggle("DisblVoid", {
			Text = "Disable Void",
			Default = true,
			Tooltip = "Makes you not get killed in void",
			DisabledTooltip = "This function is currently being managed by another function.",
			Callback = function(destroyVoid)
				tbl8.DestroyVoid = destroyVoid

				if destroyVoid then
					workspace.FallenPartsDestroyHeight = (0/0)
				else
					workspace.FallenPartsDestroyHeight = -100
				end
			end,
		})
Miscellaneous:AddToggle("WaterWalk", {
			Text = "Water Walk",
			Default = false,
			Tooltip = "Walk on water",
			Callback = function(arg)
				for _, child in pairs(alwaysHereTweenedObjects.Ocean.Object.ObjectModel:GetChildren()) do
					local tbl16 = tbl7.WaterPartStates[child]

					if arg and not tbl16 then
						tbl16 = { child.CanCollide, child.Transparency }
						tbl7.WaterPartStates[child] = tbl16
					end

					if arg then
						child.CanCollide = true

						if child.Transparency ~= 1 and tbl16[2] ~= 1 then
							child.Transparency = 0.5
						end
					elseif tbl16 then
						child.CanCollide = tbl16[1]
						local transparency

						if toggles.CustomWaterT and toggles.CustomWaterT.Value then
							transparency = 1
						else
							transparency = tbl16[2]
						end

						child.Transparency = transparency

						if not (toggles.CustomWaterT and toggles.CustomWaterT.Value) then
							tbl7.WaterPartStates[child] = nil
						end
					end
				end
			end,
		})
Miscellaneous:AddToggle("DeleteBarriers", {
			Text = "Noclip Barrier",
			Default = false,
			Callback = function(arg)
				local plots = workspace:FindFirstChild("Plots")
				if not plots then
					return
				end

				for _, child in ipairs(plots:GetChildren()) do
					local barrier = child:FindFirstChild("Barrier")

					if barrier then
						for _, child2 in ipairs(barrier:GetChildren()) do
							if child2:IsA("BasePart") and child2.Name == "PlotBarrier" then
								child2.CanCollide = not arg
							end
						end
					end
				end
			end,
		})
-- Anti-Fling [Objects Noclip]: the character's parts stay in the PlotPlayers collision group.
-- The real state is checked all the time, so a game script (or any other script) that puts the
-- parts back into another group is overruled: before every physics step, after it, the moment the
-- group property changes, for every new part, and for every new character. A watchdog rebuilds the
-- whole set if any of these connections is ever lost.
local antiFling = { Connections = {}, WatchedParts = {}, Session = 0 }

local function antiFlingEnforce(character)
	for _, part in character:QueryDescendants("BasePart") do
		if part.CollisionGroup ~= "PlotPlayers" then
			PhysicsService:SetPartCollisionGroup(part, "PlotPlayers")
		end
	end
end

local function antiFlingStop()
	antiFling.Session = antiFling.Session + 1
	for _, connection in pairs(antiFling.Connections) do
		connection:Disconnect()
	end
	antiFling.Connections = {}
	antiFling.WatchedParts = {}
end

local function antiFlingWatchPart(part, session)
	if antiFling.WatchedParts[part] or not part:IsA("BasePart") then
		return
	end
	antiFling.WatchedParts[part] = true
	-- Another script changing the group is undone at once.
	table.insert(
		antiFling.Connections,
		part:GetPropertyChangedSignal("CollisionGroup"):Connect(function()
			if antiFling.Session == session and part.CollisionGroup ~= "PlotPlayers" then
				PhysicsService:SetPartCollisionGroup(part, "PlotPlayers")
			end
		end)
	)
end

local function antiFlingStart()
	antiFlingStop()
	local session = antiFling.Session

	local function watchCharacter(character)
		for _, part in character:QueryDescendants("BasePart") do
			antiFlingWatchPart(part, session)
		end
		table.insert(
			antiFling.Connections,
			character.DescendantAdded:Connect(function(descendant)
				if antiFling.Session == session and descendant:IsA("BasePart") then
					PhysicsService:SetPartCollisionGroup(descendant, "PlotPlayers")
					antiFlingWatchPart(descendant, session)
				end
			end)
		)
	end

	-- Checks the real state, not a remembered one. PreSimulation runs right before the physics step,
	-- so the collision is already gone when it is resolved; Heartbeat checks again after it.
	local function check()
		if antiFling.Session ~= session or flag11 then
			return
		end
		local character = localPlayer.Character
		if character then
			antiFlingEnforce(character)
		end
	end
	table.insert(antiFling.Connections, RunService.PreSimulation:Connect(check))
	table.insert(antiFling.Connections, RunService.Heartbeat:Connect(check))
	table.insert(
		antiFling.Connections,
		localPlayer.CharacterAdded:Connect(function(character)
			if antiFling.Session == session then
				antiFlingEnforce(character)
				watchCharacter(character)
			end
		end)
	)
	if localPlayer.Character then
		antiFlingEnforce(localPlayer.Character)
		watchCharacter(localPlayer.Character)
	end

	-- Watchdog: if a connection was lost for any reason, everything is set up again.
	task.spawn(function()
		while antiFling.Session == session and not flag11 do
			task.wait(0.5)
			if antiFling.Session ~= session then
				return
			end
			for _, connection in pairs(antiFling.Connections) do
				if not connection.Connected then
					if toggles.OtherInvCollisions.Value then
						antiFlingStart()
					end
					return
				end
			end
			check()
		end
	end)
end

Miscellaneous:AddToggle("OtherInvCollisions", {
			Text = "Anti-Fling [Objects Noclip]",
			Default = false,
			Callback = function(arg)
				if arg then
					antiFlingStart()

					-- Report which groups PlotPlayers still collides with, so a leftover collision can be traced.
					pcall(function()
						local stillColliding = {}
						for _, group in ipairs(PhysicsService:GetRegisteredCollisionGroups()) do
							if PhysicsService:CollisionGroupsAreCollidable("PlotPlayers", group.name) then
								table.insert(stillColliding, group.name)
							end
						end
						lib:Notify({
							Title = "Anti-Fling",
							Description = "PlotPlayers still collides with: " .. table.concat(stillColliding, ", "),
							Time = 6,
						})
					end)
				else
					antiFlingStop()
					-- Switched off: the character gets its normal group back.
					local character = localPlayer.Character
					if character then
						local groupName = "Players"
						if localPlayer.InOwnedPlot.Value then
							groupName = "PlotPlayers"
						end
						for _, part in character:QueryDescendants("BasePart") do
							PhysicsService:SetPartCollisionGroup(part, groupName)
						end
					end
				end
			end,
		})
local LastGrabbedLabel = Miscellaneous:AddLabel("LastGrabbedLabel", { Text = "Last person who grabbed you: nobody", DoesWrap = true })
tbl12.UpdateLastGrabbedLabel = function()
			LastGrabbedLabel:SetVisible(tbl9.WhoGrabbed ~= nil)

			if tbl9.WhoGrabbed then
				LastGrabbedLabel:SetText("Last person who grabbed you: " .. tbl9.WhoGrabbed)
			end
		end
tbl12.UpdateLastGrabbedLabel()
local Config = tbl15.Invincibility:AddRightGroupbox("Config", "settings")
Config:AddSlider("AntiLagSens", {
			Text = "Auto Anti-Lag Sensitivity",
			Default = 3,
			Min = 1,
			Max = 20,
			Suffix = " FPS",
			Callback = function(antiLagSens)
				tbl9.AntiLagSens = antiLagSens
			end,
		})
Config:AddDivider("Auto Reset")
Config:AddToggle("AutoLeave", {
			Text = "Auto Leave",
			Default = true,
			Tooltip = "Leaves after four detected kick flags instead of continuing to reset",
			Callback = function(autoLeave)
				tbl8.AutoLeave = autoLeave
			end,
		})
Config:AddDivider("Anti-Grabs")
Config:AddDropdown("AGTDropdown", {
			Values = { "Normal", "No Ragdoll", "Anti-Kill", "Escapes Anything, but buggy" },
			Default = 1,
			Multi = false,
			Text = "Anti-Grab Type",
			Tooltip = "Type of default Anti-Grab",
			Callback = function(agType)
				tbl9.AGType = agType
			end,
		})
Config:AddDropdown("GTDropdown", {
			Values = { "Blobman", "Tractor [Invisible]", "Train [Invisible]", "Sleigh [Invisible]" },
			Default = 1,
			Multi = false,
			Text = "GUCCI Type",
			Tooltip = "What vehicle will you sit on during Gucci Anti Grab",
			Callback = function(arg)
				if arg == "Blobman" then
					tbl9.GucciType = "CreatureBlobman"
				elseif arg == "Tractor [Invisible]" then
					tbl9.GucciType = "TractorGreen"
				elseif arg == "Train [Invisible]" then
					tbl9.GucciType = "Train"
				elseif arg == "Sleigh [Invisible]" then
					tbl9.GucciType = "SantaSleigh"
				end
			end,
		})
Config:AddDivider("Anti Net-Owner")
Config:AddDropdown("AITDropdown", {
			Values = {
				"FoodHamburger",
				"InstrumentDrumBongos",
				"InstrumentBrassTrumpet",
				"InstrumentBrassBugle",
				"InstrumentVoiceMicrophone",
				"InstrumentWoodwindOcarina",
				"InstrumentGuitarUkulele",
				"InstrumentGuitarLyre",
				"InstrumentGuitarBanjo",
				"InstrumentGuitarAcoustic",
				"CupMugBrown",
				"CupMugWhite",
				"FoodBanana",
				"FoodBread",
				"FoodBroccoli",
				"FoodCakePink",
				"FoodCoconut",
				"FoodDippyEgg",
				"FoodDonut",
				"FoodFrenchFries",
				"FoodHotdog",
				"FoodMayonnaise",
				"FoodMeatStick",
				"FoodMushroomPoison",
				"FoodPizzaCheese",
				"FoodPizzaPepperoni",
				"FoodSodaCan",
				"PoopPile",
				"PoopPileSparkle",
			},
			Default = 1,
			Multi = false,
			Text = "Type",
			Tooltip = "What interactable item will you use when doing anti-Net Owner",
			Callback = function(antiInputType)
				tbl9.AntiInputType = antiInputType
			end,
		})
Config:AddSlider("AntiInpLagDel", {
			Text = "Grab & Drop Delay",
			Default = 0.05,
			Min = 0,
			Max = 0.3,
			Suffix = " sec",
			Rounding = 2,
			Callback = function(inputLgDelay)
				tbl9.InputLgDelay = inputLgDelay
			end,
		})
Config:AddLabel("Below 0.05 can cause high ping")
Config:AddSlider("ItemTransAK", {
			Text = "Item Transparency",
			Default = tbl9.AILTransparency,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Callback = function(ailTransparency)
				tbl9.AILTransparency = ailTransparency
			end,
		})
Config:AddDivider("Anti-Kick")
local antiKickSettings = tbl7.AntiKickSettings
local AntiKickHL = Config:AddToggle("AntiKickHL", {
			Text = "Highlight",
			Default = antiKickSettings.Highlight,
			Tooltip = "Highlights the shuriken",
			Callback = function(highlight)
				antiKickSettings.Highlight = highlight
			end,
		})
AntiKickHL:AddColorPicker("AKFill", {
			Default = antiKickSettings.HighlightFill,
			Title = "Fill Color",
			Callback = function(highlightFill)
				antiKickSettings.HighlightFill = highlightFill
			end,
		})
AntiKickHL:AddColorPicker("AKOutline", {
			Default = antiKickSettings.HighlightOutl,
			Title = "Outline Color",
			Callback = function(highlightOutl)
				antiKickSettings.HighlightOutl = highlightOutl
			end,
		})
Config:AddSlider("FillTransAK", {
			Text = "Fill Transparency",
			Default = antiKickSettings.HighlightFT,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Callback = function(highlightFT)
				antiKickSettings.HighlightFT = highlightFT
			end,
		})
Config:AddSlider("OutlTransAK", {
			Text = "Outline Transparency",
			Default = antiKickSettings.HighlightOT,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Callback = function(highlightOT)
				antiKickSettings.HighlightOT = highlightOT
			end,
		})
Config:AddSlider("ShurTransAK", {
			Text = "Shuriken Transparency",
			Default = antiKickSettings.Transparency,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Callback = function(transparency)
				antiKickSettings.Transparency = transparency
			end,
		})

end

end
end

-- Engine finished starting: tell the main script and report any statement that failed.
FapDefenseEnv.Ready = true
]=====]

    local env = { Window = Window, Controls = controls, Ready = false }
    getgenv().__FAPTA_DEFENSE_ENV = env
    task.spawn(function()
        local compiled, compileError = loadstring(ENGINE_SOURCE, "=FAPTA_DEFENSE")
        if not compiled then
            warn("[fapta] DEFENSE engine compile error:", compileError)
            return
        end
        local ok, runtimeError = pcall(compiled)
        if not ok then
            warn("[fapta] DEFENSE engine error:", runtimeError)
        end
    end)
end)()

-- Seven-times movement speed, gravity, and jump handling
local TP_WALK_MULTIPLIER = 7

local function enforceTPWalkJumpPower(state)
    if not (state and state.Humanoid and state.Humanoid.Parent) then
        return
    end
    local humanoid = state.Humanoid
    local targetJumpPower = state.JumpPower * TP_WALK_MULTIPLIER
    if humanoid.UseJumpPower ~= true then
        humanoid.UseJumpPower = true
    end
    if humanoid.JumpPower ~= targetJumpPower then
        humanoid.JumpPower = targetJumpPower
    end
end

local function restoreTPWalkCharacterState()
    local state = tpWalkCharacterState
    tpWalkCharacterState = nil
    if state then
        if state.JumpPowerConnection then
            state.JumpPowerConnection:Disconnect()
        end
        if state.UseJumpPowerConnection then
            state.UseJumpPowerConnection:Disconnect()
        end
    end
    if state and state.Humanoid and state.Humanoid.Parent then
        state.Humanoid.WalkSpeed = state.WalkSpeed
        state.Humanoid.JumpPower = state.JumpPower
        state.Humanoid.JumpHeight = state.JumpHeight
        state.Humanoid.UseJumpPower = state.UseJumpPower
    end
end

local function applyTPWalkToCurrentCharacter()
    local character = LP.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return nil
    end
    if tpWalkCharacterState and tpWalkCharacterState.Humanoid == humanoid then
        enforceTPWalkJumpPower(tpWalkCharacterState)
        return tpWalkCharacterState
    end
    restoreTPWalkCharacterState()
    local state = {
        Humanoid = humanoid,
        WalkSpeed = humanoid.WalkSpeed,
        JumpPower = humanoid.JumpPower,
        JumpHeight = humanoid.JumpHeight,
        UseJumpPower = humanoid.UseJumpPower,
    }
    tpWalkCharacterState = state
    enforceTPWalkJumpPower(state)
    state.JumpPowerConnection = humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        if tpWalkEnabled and tpWalkCharacterState == state then
            enforceTPWalkJumpPower(state)
        end
    end)
    state.UseJumpPowerConnection = humanoid
        :GetPropertyChangedSignal("UseJumpPower")
        :Connect(function()
            if tpWalkEnabled and tpWalkCharacterState == state then
                enforceTPWalkJumpPower(state)
            end
        end)
    return state
end

local function stopTPWalk()
    tpWalkEnabled = false
    if tpWalkHeartbeatConnection then
        tpWalkHeartbeatConnection:Disconnect()
        tpWalkHeartbeatConnection = nil
    end
    if tpWalkCharacterAddedConnection then
        tpWalkCharacterAddedConnection:Disconnect()
        tpWalkCharacterAddedConnection = nil
    end
    if tpWalkOriginalGravity ~= nil then
        workspace.Gravity = tpWalkOriginalGravity
        tpWalkOriginalGravity = nil
    end
    restoreTPWalkCharacterState()
end

local function startTPWalk()
    if tpWalkEnabled then
        return
    end
    tpWalkEnabled = true
    tpWalkOriginalGravity = workspace.Gravity
    workspace.Gravity = tpWalkOriginalGravity * TP_WALK_MULTIPLIER
    applyTPWalkToCurrentCharacter()
    tpWalkHeartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not tpWalkEnabled then
            return
        end
        local character = LP.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local state = applyTPWalkToCurrentCharacter()
        if not (root and humanoid and state and root.Parent and humanoid.Health > 0) then
            return
        end
        local moveDirection = humanoid.MoveDirection
        if moveDirection.Magnitude > 0 then
            local extraDistance = state.WalkSpeed * (TP_WALK_MULTIPLIER - 1) * deltaTime
            root.CFrame = root.CFrame + moveDirection * extraDistance
        end
    end)
    tpWalkCharacterAddedConnection = LP.CharacterAdded:Connect(function(character)
        task.spawn(function()
            character:WaitForChild("Humanoid", 10)
            if tpWalkEnabled and character == LP.Character then
                applyTPWalkToCurrentCharacter()
            end
        end)
    end)
end

function setTPWalkEnabled(value)
    if value then
        startTPWalk()
        Window:Notify("fapta", "speed, gravity, and jump power enabled", 4)
    else
        stopTPWalk()
        Window:Notify("fapta", "original speed, gravity, and jump restored", 4)
    end
end
-- AUTO tab shared state and priority-based teleport helpers
_G.TP_Priority = 0
_G.TeleportingToNetworkOwnership = false
_G.AutoFarmCoins = false
_G.AutoSaveHouseTime = false
_G.RemainingTimeInHouse = nil
_G.PlotName = "Witch House"

local AutoSetNetworkOwner = ReplicatedStorage:WaitForChild("GrabEvents")
    :WaitForChild("SetNetworkOwner")

local function AutoLookAt(origin, target)
    local unit = (target - origin).Unit
    local right = unit:Cross(Vector3.new(0, 1, 0))
    local up = right:Cross(unit)
    return CFrame.fromMatrix(origin, right, up)
end

local function AutoGetPlayerCharacter()
    if
        LP.Character
        and LP.Character:FindFirstChild("HumanoidRootPart")
        and LP.Character:FindFirstChildOfClass("Humanoid")
    then
        return LP.Character
    end
end

function AutoSNOWship(part)
    if part and typeof(part) == "Instance" then
        local distance = LP:DistanceFromCharacter(part.Position)
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and distance <= 30 then
            AutoSetNetworkOwner:FireServer(
                part,
                AutoLookAt(LP.Character.HumanoidRootPart.Position, part.Position)
            )
        end
    end
end

function ChangeActivityPriority(priority)
    if _G.TP_Priority <= priority then
        _G.TP_Priority = priority
        return true
    end
    if priority == 0 then
        _G.TP_Priority = priority
        return true
    end
end

function TeleportPlayer(targetCF, priority)
    if (priority == nil and 0 or priority) ~= _G.TP_Priority or typeof(targetCF) ~= "CFrame" then
        return false
    end
    local character = AutoGetPlayerCharacter()
    if not character then
        return false
    end
    local root = character.HumanoidRootPart
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    root.CFrame = root.CFrame.Rotation + targetCF.Position
    if humanoid.SeatPart == nil or tostring(humanoid.SeatPart.Parent) ~= "CreatureBlobman" then
        humanoid.Sit = false
    end
    return true
end

function GetAutoSlotEntries()
    local entries = {}
    local slotsFolder = Workspace:FindFirstChild("Slots")
    if not slotsFolder then
        return entries
    end
    for _, slot in pairs(slotsFolder:GetChildren()) do
        local slotHandle = slot:FindFirstChild("SlotHandle")
        local lightBall = slotHandle and slotHandle:FindFirstChild("LightBall")
        local handle = slotHandle and slotHandle:FindFirstChild("Handle")
        if lightBall and handle and handle:IsA("BasePart") then
            table.insert(entries, {
                Slot = slot,
                LightBall = lightBall,
                Handle = handle,
            })
        end
    end
    return entries
end

function AreAllSlotLightsNeon()
    local entries = GetAutoSlotEntries()
    if #entries == 0 then
        return false
    end
    for _, entry in ipairs(entries) do
        if entry.LightBall.Material ~= Enum.Material.Neon then
            return false
        end
    end
    return true
end

function SaveAutoPosition(activity)
    local root
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        root = LP.Character.HumanoidRootPart
    end
    if activity == "Spin" then
        if root then
            _G.SavedPositionInSpin = root.CFrame
        end
    elseif activity == "House" and root then
        _G.SavedPositionOutHouse = root.CFrame
    end
end

function RestoreAutoPosition(activity)
    local root
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        root = LP.Character.HumanoidRootPart
    end
    if activity == "Spin" then
        if root and typeof(_G.SavedPositionInSpin) == "CFrame" then
            root.CFrame = _G.SavedPositionInSpin
        end
    elseif activity == "House" and root and typeof(_G.SavedPositionOutHouse) == "CFrame" then
        root.CFrame = _G.SavedPositionOutHouse
    end
end

local timeLeftTextLabelInGame = Workspace.Slots.Slots.Screen.SlotGui.TimeLeftFrame.TimeText

timeLeftTextLabelInGame.Changed:Connect(function(property)
    if property == "Text" then
        TimeRemainingLabel:Set("Time Remaining: " .. timeLeftTextLabelInGame.Text)
    end
end)

task.spawn(function()
    for _, coinAmount in pairs(Workspace.Slots:GetDescendants()) do
        if coinAmount.Name == "CoinAmount" and tostring(coinAmount.Parent) == "CoinsFrame" then
            coinAmount.Changed:Connect(function(property)
                local playerName = coinAmount.Parent.Parent.SpinningFrame.PlayerName
                if property == "Text" and playerName.Text == LP.DisplayName and CoinsWonLabel then
                    CoinsWonLabel:Set(coinAmount.Text)
                end
            end)
        end
    end
end)

-- Discover and track the local player's active plot timer
local remainingTimeChangedConnection = nil
local remainingTimeAncestryConnection = nil

local function RegisterRemainingTimeInHouse(descendant)
    if
        typeof(descendant) ~= "Instance"
        or descendant.Name ~= "TimeRemainingNum"
        or not descendant:IsA("IntValue")
    then
        return false
    end
    local ownerValue = descendant.Parent
    if not ownerValue or ownerValue.Value ~= LP.Name then
        return false
    end
    if _G.RemainingTimeInHouse == descendant then
        return true
    end
    if remainingTimeChangedConnection then
        remainingTimeChangedConnection:Disconnect()
        remainingTimeChangedConnection = nil
    end
    if remainingTimeAncestryConnection then
        remainingTimeAncestryConnection:Disconnect()
        remainingTimeAncestryConnection = nil
    end
    _G.RemainingTimeInHouse = descendant
    if TimeInHouseLabel then
        TimeInHouseLabel:Set("Time: " .. descendant.Value)
    end
    remainingTimeChangedConnection = descendant.Changed:Connect(function(value)
        if TimeInHouseLabel then
            TimeInHouseLabel:Set("Time: " .. value)
        end
    end)
    remainingTimeAncestryConnection = descendant.AncestryChanged:Connect(function(_, parent)
        if parent == nil and _G.RemainingTimeInHouse == descendant then
            _G.RemainingTimeInHouse = nil
        end
    end)
    return true
end

function TrackRemainingTime()
    local plots = Workspace:FindFirstChild("Plots")
    if not plots then
        return false
    end
    for _, descendant in pairs(plots:GetDescendants()) do
        if RegisterRemainingTimeInHouse(descendant) then
            return true
        end
    end
    return false
end

task.spawn(TrackRemainingTime)
Workspace.DescendantAdded:Connect(function(descendant)
    if descendant.Name == "TimeRemainingNum" then
        RegisterRemainingTimeInHouse(descendant)
    elseif
        descendant.Name == "Value"
        and tostring(descendant.Parent) == "ThisPlotsOwners"
        and descendant.Value == LP.Name
    then
        task.spawn(function()
            local remainingTime = descendant:WaitForChild("TimeRemainingNum", 2)
            if remainingTime then
                RegisterRemainingTimeInHouse(remainingTime)
            end
        end)
    end
end)

AutoPlotRefreshValue = Instance.new("IntValue")
PlotWorkspace = Workspace.Plots:GetDescendants()

function GetPlotModel(_)
    local plots = Workspace.Plots
    local plotName = _G.PlotName
    if plotName == "Witch House" then
        plots = plots:FindFirstChild("Plot3")
    elseif plotName == "Lumber House" then
        plots = plots:FindFirstChild("Plot2")
    elseif plotName == "Common House" then
        plots = plots:FindFirstChild("Plot1")
    elseif plotName == "American House" then
        plots = plots:FindFirstChild("Plot4")
    elseif plotName == "Chinese House" then
        plots = plots:FindFirstChild("Plot5")
    end
    return plots
end

function IsThereOwnerOnPlot()
    local plotModel = GetPlotModel()
    if plotModel and plotModel.PlotSign.ThisPlotsOwners:FindFirstChild("Value") then
        return true
    end
end

function ClaimPlot()
    local plotModel = not IsThereOwnerOnPlot() and GetPlotModel(_G.PlotName)
    if plotModel then
        local plotSign = plotModel.PlotSign

        local function LocalPlayerOwnsPlot()
            return isPlotOwnedByLocalPlayer(plotModel)
        end

        for _, child in pairs(plotSign:GetChildren()) do
            if LocalPlayerOwnsPlot() then
                break
            end
            if child.Name == "Sign" and ChangeActivityPriority(3) then
                local plusGrabPart = child.Plus.PlusGrabPart
                for _ = 0, 15 do
                    TeleportPlayer(plusGrabPart.CFrame * CFrame.new(-5, 0, -5), 3)
                    AutoSNOWship(plusGrabPart)
                    task.wait()
                end
                ChangeActivityPriority(0)
            end
        end
    end
end

function UpdatePlotOwner()
    for _, playerRole in pairs(PlotWorkspace) do
        if playerRole.Name == "PlayerRole" then
            local playerDisplayName = playerRole.Parent.PlayerDisplayName
            local parent = playerRole.Parent
            local selectedPlot = nil
            local playerExists = false

            local function UpdateOwnerLabel()
                playerExists = false
                selectedPlot = GetPlotModel(_G.PlotName)
                if
                    selectedPlot
                    and playerRole:IsDescendantOf(selectedPlot)
                    and playerRole.Text == "Owner"
                    and parent.Visible
                then
                    task.wait()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player.DisplayName == playerDisplayName.Text then
                            playerExists = true
                        end
                    end
                    if PlotOwner and playerExists then
                        PlotOwner:Set("Plot Owner: " .. playerDisplayName.Text)
                    else
                        PlotOwner:Set("Plot Available!")
                    end
                end
            end

            playerRole.Changed:Connect(function(property)
                if property == "Text" then
                    UpdateOwnerLabel()
                end
            end)
            AutoPlotRefreshValue.Changed:Connect(function(_)
                UpdateOwnerLabel()
            end)
            UpdateOwnerLabel()
        end
    end
end

function UpdatePeopleInPlot()
    for _, ownersContainer in pairs(PlotWorkspace) do
        if ownersContainer.Name == "ThisPlotsOwners" then
            local function UpdatePeopleLabel()
                local selectedPlot = GetPlotModel(_G.PlotName)
                local children = ownersContainer:GetChildren()
                if selectedPlot and ownersContainer:IsDescendantOf(selectedPlot) then
                    local count = table.getn(children)
                    if PlayersInPlot then
                        PlayersInPlot:Set("Players in Plot: " .. count)
                    end
                    if count == 0 and PlotOwner then
                        PlotOwner:Set("Plot Available!")
                    end
                end
            end

            AutoPlotRefreshValue.Changed:Connect(function(_)
                UpdatePeopleLabel()
            end)
            ownersContainer.ChildAdded:Connect(UpdatePeopleLabel)
            ownersContainer.ChildRemoved:Connect(UpdatePeopleLabel)
            UpdatePeopleLabel()
        end
    end
end

task.spawn(function()
    UpdatePlotOwner()
    task.wait()
    UpdatePeopleInPlot()
end)
Window._FaptaBuildSummary.RefreshSession = Window._FaptaBuildSummary.RefreshSession + 1
task.spawn(function()
    local session = Window._FaptaBuildSummary.RefreshSession
    while
        session == Window._FaptaBuildSummary.RefreshSession
        and Window._FaptaBuildSummary.Paragraph
        and not Window._FaptaBuildSummary.Paragraph:IsDestroyed()
    do
        Window._FaptaBuildSummary:Refresh()
        task.wait(1)
    end
end)
-- Sword logic: poses, draw / sheathe animation, build and cleanup. The controls live in the UI part.
;(function()
    local Sword = Window._FaptaSword
    -- Sword poses. Every pose is derived from the current profiles and the live giant frames,
    -- so editing the sword position / angle never breaks mounting or the draw animation.
    local function angleRotation(angle)
        -- Angles are applied about the anchor axes in X, then Y, then Z order.
        return CFrame.Angles(0, 0, math.rad(angle.Z))
            * CFrame.Angles(0, math.rad(angle.Y), 0)
            * CFrame.Angles(math.rad(angle.X), 0, 0)
    end

    -- The hand always holds the end of the sword that is closer to the giant's head while the
    -- sword is on the back. It is judged in the giant torso frame, so it depends only on the
    -- Back position / angle and never flips because the body tilts. A 180 degree turn about the
    -- sword's own center swaps which end is gripped without changing where the blade sits.
    local GIANT_HEAD_OFFSET = Vector3.new(0, 10.5, 0) -- head center in the torso frame

    local function getGripFlipCF()
        local profile = Sword.Profiles.Back
        local backRelativeCF = CFrame.new(profile.Position) * angleRotation(profile.Angle)
        local halfLength = Sword.PartSize.X * Sword.PartCount / 2
        local plusEndPosition = backRelativeCF * Vector3.new(halfLength, 0, 0)
        local minusEndPosition = backRelativeCF * Vector3.new(-halfLength, 0, 0)
        local plusEndDistance = (plusEndPosition - GIANT_HEAD_OFFSET).Magnitude
        local minusEndDistance = (minusEndPosition - GIANT_HEAD_OFFSET).Magnitude
        if plusEndDistance <= minusEndDistance then
            return CFrame.new()
        end
        return CFrame.Angles(0, 0, math.rad(180))
    end

    local function getArmRelativeCF()
        local profile = Sword.Profiles.Arm
        return CFrame.new(profile.Position) * angleRotation(profile.Angle) * getGripFlipCF()
    end

    local function getBackSwordCF(giantTorsoCF)
        local profile = Sword.Profiles.Back
        return giantTorsoCF * CFrame.new(profile.Position) * angleRotation(profile.Angle)
    end

    local function getHandSwordCF(armCF)
        -- The limb frame has +X toward the shoulder, so the hand end is at -X.
        return armCF * CFrame.new(-LIMB_ASSEMBLY_SIZE.X / 2, 0, 0) * getArmRelativeCF()
    end

    -- Giant right-arm frame whose hand holds the back-mounted sword exactly the way the Arm Tip
    -- profile holds it (so the sword does not move when the hand takes over).
    local function getGrabArmCF(giantTorsoCF)
        return getBackSwordCF(giantTorsoCF)
            * getArmRelativeCF():Inverse()
            * CFrame.new(LIMB_ASSEMBLY_SIZE.X / 2, 0, 0)
    end

    local function ease(t)
        t = math.clamp(t, 0, 1)
        return t * t * (3 - 2 * t)
    end

    -- Every sword set belongs to one giant (set 1 = giant 1, set 2 = giant 2 in Double mode).
    -- Each giant runs its own draw / sheathe animation.
    function Sword.StartAnimation(toArm)
        local startTime = os.clock()
        for index in pairs(Sword.Sets) do
            Sword.Anims[index] = {
                ToArm = toArm,
                StartTime = startTime,
                -- Drawing: the sword stays on the back until grabbed. Sheathing: it starts in the hand.
                SwordInHand = not toArm,
            }
        end
    end

    -- Draw animation (Zelda-style). Draw timeline, in seconds from the start:
    --   reach  : the arm swings up and back over the shoulder along an arc to the hilt
    --   hold   : the hand closes on the hilt
    --   pull   : the sword slides out along its own length (like leaving a scabbard)
    --   swing  : the sword swings around over the shoulder to the ready pose in the hand
    -- Sheathing plays the same timeline backwards. Every key pose is rebuilt each frame from the
    -- live giant frames and the current profiles, so changing the sword position / angle or
    -- moving around never breaks the motion.
    local function arcPose(torsoCF, fromCF, toCF, alpha, arc)
        local startPosition = fromCF.Position
        local endPosition = toCF.Position
        local controlPosition = (startPosition + endPosition) / 2
            + torsoCF.UpVector * arc.Up
            + torsoCF.LookVector * arc.Forward
        local firstLeg = startPosition:Lerp(controlPosition, alpha)
        local secondLeg = controlPosition:Lerp(endPosition, alpha)
        local position = firstLeg:Lerp(secondLeg, alpha)
        -- Rotation-only frames (position removed) blend by spherical interpolation.
        local rotation = (fromCF - startPosition):Lerp(toCF - endPosition, alpha)
        return CFrame.new(position) * rotation
    end

    local function getDrawPoseCF(torsoCF, restCF, drawTime)
        local reachEnd = Sword.ReachTime
        local holdEnd = reachEnd + Sword.HoldTime
        local pullEnd = holdEnd + Sword.PullOutTime
        local grabCF = getGrabArmCF(torsoCF)
        if drawTime < reachEnd then
            return arcPose(torsoCF, restCF, grabCF, ease(drawTime / reachEnd), Sword.ReachArc)
        elseif drawTime < holdEnd then
            return grabCF
        end
        -- The sword leaves along its own axis, toward the end that is gripped.
        local gripPosition = (grabCF * CFrame.new(-LIMB_ASSEMBLY_SIZE.X / 2, 0, 0)).Position
        local slideVector = gripPosition - getBackSwordCF(torsoCF).Position
        if slideVector.Magnitude < 0.001 then
            slideVector = torsoCF.UpVector
        end
        local pulledCF = CFrame.new(slideVector.Unit * Sword.PullDistance) * grabCF
        if drawTime < pullEnd then
            return grabCF:Lerp(pulledCF, ease((drawTime - holdEnd) / Sword.PullOutTime))
        end
        return arcPose(
            torsoCF,
            pulledCF,
            restCF,
            ease((drawTime - pullEnd) / Sword.SwingTime),
            Sword.SwingArc
        )
    end

    -- Called before the limb targets are applied. Returns the right-arm frame to use for the
    -- giant arm (only the giant arm moves, never the real character). The sword is on the back
    -- until the hold ends and in the hand afterwards; both poses match at that moment.
    function Sword.Animate(index, giantTorsoCF, realArmCF)
        local anim = Sword.Anims[index]
        if not anim or not realArmCF then
            return realArmCF
        end
        local elapsed = os.clock() - anim.StartTime
        local holdEnd = Sword.ReachTime + Sword.HoldTime
        local totalTime = holdEnd + Sword.PullOutTime + Sword.SwingTime
        if elapsed >= totalTime then
            Sword.Anims[index] = nil
            return realArmCF
        end
        local drawTime = anim.ToArm and elapsed or (totalTime - elapsed)
        anim.SwordInHand = drawTime >= holdEnd
        return getDrawPoseCF(giantTorsoCF, realArmCF, drawTime)
    end

    local function parkSwordSet(index)
        local set = Sword.Sets[index]
        if not set then
            return
        end
        Sword.Anims[index] = nil
        for partIndex, data in ipairs(set) do
            parkGiantDataAtSlot(
                data,
                Sword.WaitSlotBase + (index - 1) * Sword.PartCount + partIndex - 1
            )
        end
    end

    -- Sword movement: called every frame by tracePlayer for each traced giant.
    -- rightArmCF is the animated arm frame while a draw / sheathe animation runs.
    function Sword.Update(index, giantTorsoCF, rightArmCF)
        if index == 1 and giantMode ~= "Double" and Sword.Sets[2] then
            -- Normal mode only has one giant, so the second sword waits underground.
            parkSwordSet(2)
        end
        local set = Sword.Sets[index]
        if not set then
            return
        end
        local inHand
        local anim = Sword.Anims[index]
        if anim then
            inHand = anim.SwordInHand
        else
            inHand = Sword.ArmMode
        end
        local swordCF
        if inHand then
            if not rightArmCF then
                return
            end
            swordCF = getHandSwordCF(rightArmCF)
        else
            swordCF = getBackSwordCF(giantTorsoCF)
        end
        setGroupTarget(set, swordCF)
    end

    function Sword.Park()
        for index in pairs(Sword.Sets) do
            parkSwordSet(index)
        end
        Sword.Anims = {}
    end

    function Sword.Cleanup()
        Sword.Anims = {}
        local hadParts = Sword.Sets[1] ~= nil
        for _, set in pairs(Sword.Sets) do
            restoreSpinGroup(set)
        end
        Sword.Sets = {}
        return hadParts
    end

    local function findSwordPart(model)
        for _, descendant in ipairs(model:GetDescendants()) do
            if
                descendant.Name == "SoundPart"
                and descendant:IsA("BasePart")
                and approximatelyEqualVector(descendant.Size, Sword.PartSize, SIZE_TOLERANCE)
            then
                return descendant
            end
        end
        for _, descendant in ipairs(model:GetDescendants()) do
            if
                descendant:IsA("BasePart")
                and approximatelyEqualVector(descendant.Size, Sword.PartSize, SIZE_TOLERANCE)
            then
                return descendant
            end
        end
        return nil
    end

    -- Normal mode builds one sword (5 boards); Double mode builds one sword per giant (10 boards).
    function Sword.Build()
        Sword.Cleanup()
        local folder, folderLabel = resolveSelectedFolder()
        if not folder then
            Window:Notify("SWORD ERROR", getSelectedFolderError(folderLabel), 6)
            return false
        end
        local candidates = {}
        for _, child in ipairs(folder:GetChildren()) do
            if child:IsA("Model") and child.Name == Sword.ToyName then
                local part = findSwordPart(child)
                if part then
                    table.insert(candidates, { Model = child, Part = part })
                end
            end
        end
        -- One sword per giant (10 boards) when there are enough, otherwise a single sword.
        local swordCount = #candidates >= 2 * Sword.PartCount and 2 or 1
        local neededParts = swordCount * Sword.PartCount
        if #candidates < neededParts then
            Window:Notify(
                "SWORD ERROR",
                string.format(
                    "Sword needs PalletLightBrown x%d (SoundPart 11.5 x 1.5 x 11.5), found %d",
                    neededParts,
                    #candidates
                ),
                7
            )
            return false
        end
        local centerSlot = (Sword.PartCount + 1) / 2
        for swordIndex = 1, swordCount do
            local set = {}
            for slot = 1, Sword.PartCount do
                local candidate = candidates[(swordIndex - 1) * Sword.PartCount + slot]
                local partStates = Util.freezeParts(candidate.Model)
                local bodyGyro, bodyPosition = attachBodyMovers(candidate.Part)
                bodyPosition.Position = candidate.Part.Position
                bodyGyro.CFrame = candidate.Part.CFrame
                table.insert(set, {
                    Model = candidate.Model,
                    Part = candidate.Part,
                    BG = bodyGyro,
                    BP = bodyPosition,
                    -- Boards sit side by side along the sword's local X axis with no gap.
                    LocalCF = CFrame.new((slot - centerSlot) * Sword.PartSize.X, 0, 0),
                    RotationOffset = CFrame.new(),
                    OriginalModelPivot = candidate.Model:GetPivot(),
                    PartStates = partStates,
                })
            end
            Sword.Sets[swordIndex] = set
        end
        Sword.Park()
        if swordCount == 2 then
            Window:Notify(
                "SWORD BUILT",
                "10 PalletLightBrown boards joined into two long blades; they follow both giants while Be Giant is ON",
                6
            )
        else
            Window:Notify(
                "SWORD BUILT",
                "5 PalletLightBrown boards joined into one long blade; they follow the giant while Be Giant is ON",
                6
            )
        end
        return true
    end

end)()
-- Firework wings logic: the FireworkSparkler toys form two wings on the back and flap.
-- While a giant is traced the wings sit on the giant's back (scaled up); otherwise on the player's.
-- Uses the same toys as Firework Orbit, so only one of the two can be on at a time.
;(function()
    local Wings = Window._FaptaWings

    -- Used by cleanup / folder change: give the toys back and switch the toggle off.
    Wings.Restore = function()
        local hadToys = Wings.Enabled or #Wings.Toys > 0
        Wings.Enabled = false
        -- The toys belong to the FireworkSparkler pool, which restoreFireworkSparklers gives back.
        Wings.Toys = {}
        if not Wings.Busy and Wings.Toggle and Wings.Toggle:Get() then
            Wings.Toggle:Set(false)
        end
        return hadToys
    end

    -- Wing layout in the back frame (torso space, +Z = behind the back): feather k of a wing sits
    -- k steps out from the shoulder along a direction that swings up and down. Later feathers
    -- lag a little behind, so the wing bends like a real flap. The sparkler's front (-Z) points
    -- along the wing.
    Wings.Update = function()
        local toys = Wings.Toys
        if #toys == 0 then
            return
        end
        local backCF
        local scale
        local giantTorsoCF = Window._FaptaWait.GiantTorsoCF
        if isBuilt and isTracing and giantTorsoCF then
            backCF = CFrame.new(0, TORSO_TRACE_Y_OFFSET, 0) * giantTorsoCF
            scale = Wings.GiantScale
        else
            local character = LP.Character
            local torso = character
                and (character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso"))
            if not torso then
                return
            end
            backCF = torso.CFrame
            scale = 1
        end
        local time = os.clock()
        for index, data in ipairs(toys) do
            if Util.isDataAlive(data) then
                local side = index % 2 == 1 and -1 or 1
                local feather = math.ceil(index / 2)
                local flap = math.sin(time * math.pi * 2 * Wings.FlapHz - (feather - 1) * Wings.FeatherLag)
                local angle = Wings.BaseAngle + Wings.FlapAmplitude * flap
                local direction = Vector3.new(side * math.cos(angle), math.sin(angle), 0.18).Unit
                local root = Vector3.new(side * 0.7 * scale, 0.4 * scale, 0.9 * scale)
                local localPosition = root + direction * (feather * Wings.Spacing * scale)
                local worldPosition = backCF:PointToWorldSpace(localPosition)
                local worldDirection = backCF:VectorToWorldSpace(direction)
                data.BP.Position = worldPosition
                data.BG.CFrame = CFrame.lookAt(worldPosition, worldPosition + worldDirection, backCF.ZVector)
            end
        end
    end

    -- Switch on: the wings drive the FireworkSparkler toys prepared by build Toys (Firework Orbit
    -- uses the same toys, so it is switched off first).
    Wings.Enable = function()
        Wings.Busy = true
        if FireworkSpinToggle and FireworkSpinToggle:Get() then
            FireworkSpinToggle:Set(false)
        end
        Wings.Busy = false
        local toys = FireworkSparklers
        local message
        if #toys == 0 then
            -- build Toys was not used yet: attach the toys now.
            local success, preparedToys, preparedMessage = prepareSpinToys(FIREWORK_TOY_NAME)
            if not success then
                Window:Notify("FIREWORK WINGS", preparedMessage or preparedToys, 6)
                task.defer(function()
                    if Wings.Toggle and Wings.Toggle:Get() then
                        Wings.Toggle:Set(false)
                    end
                end)
                return
            end
            FireworkSparklers = preparedToys
            toys = preparedToys
            message = preparedMessage
        else
            message = string.format("using %d prepared FireworkSparkler objects", #toys)
        end
        Wings.Toys = toys
        Wings.Enabled = true
        Wings.Update()
        Window:Notify("FIREWORK WINGS", message .. "; wings on", 4)
    end

    -- Switch off: park the toys under the map (like Firework Orbit does).
    Wings.Disable = function()
        local hadToys = Wings.Enabled
        Wings.Enabled = false
        if hadToys then
            Util.parkGroupUnderground(Wings.Toys, WAIT_POS_Y)
            Window:Notify("FIREWORK WINGS", "wings off; parked underground", 4)
        end
    end
end)()

-- Per-frame giant tracing and orbit updates
RunService.RenderStepped:Connect(function(deltaTime)
    if isBuilt and isTracing then
        tracePlayer()
    elseif isBuilt and (Window._FaptaWait.Orbit or Window._FaptaWait.ReleaseStart) then
        Window._FaptaWait.WaitFrame()
    end
    if Window._FaptaWings.Enabled then
        Window._FaptaWings.Update()
    end
    if FireworkOrbitAnchor and fireworkSpinEnabled then
        updateFireworkSpin(deltaTime)
    end
    if SpotlightOrbitAnchor and spotlightSpinEnabled then
        updateSpotlightSpin(deltaTime)
    end
end)

-- ============================================================================
-- STARTUP (applies the initial control values once the logic exists)
-- ============================================================================

AutoPlotDropdown:Set("Witch House")
FolderDropdown:Set(selectedFolderOption)
GiantModeDropdown:Set(giantMode)
SpotlightTypeDropdown:Set(SPOTLIGHT_OPTIONS)
Window._FaptaLanguageDropdown:Set("English (Current)")
task.delay(1, function()
    Window._FaptaLanguageStartup = false
end)
Window:Notify("Console", "0 s error exist", 5)

-- UI width: the window is made 30 px wider with Window:SetSize (HertaIX).
-- Change Window._FaptaUiExtraWidth to adjust the amount (pixels).
Window._FaptaUiExtraWidth = 30
task.spawn(function()
    local extra = Window._FaptaUiExtraWidth
    -- Current window size: ask the library if it can tell, otherwise measure the window frame.
    local function readSize()
        if typeof(Window.GetSize) == "function" then
            local ok, value = pcall(function()
                return Window:GetSize()
            end)
            if ok and typeof(value) == "Vector2" then
                return value
            elseif ok and typeof(value) == "UDim2" then
                return Vector2.new(value.X.Offset, value.Y.Offset)
            end
        end
        local best, bestArea
        for _, object in ipairs(Window._ScreenGui:GetDescendants()) do
            if object:IsA("Frame") and object.Size.X.Scale == 0 and object.AbsoluteSize.X >= 300 then
                local area = object.AbsoluteSize.X * object.AbsoluteSize.Y
                if not bestArea or area > bestArea then
                    best, bestArea = object, area
                end
            end
        end
        return best and best.AbsoluteSize or nil
    end
    for _ = 1, 40 do
        local size = readSize()
        if size then
            local ok, err = pcall(function()
                Window:SetSize(Vector2.new(size.X + extra, size.Y))
            end)
            if not ok then
                warn("[Fapta] Window:SetSize failed:", err)
            end
            return
        end
        task.wait(0.25)
    end
end)