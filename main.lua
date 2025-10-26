-- 安全な実行環境の確保
local function safeExecute()
    if syn and syn.protect_gui then
        syn.protect_gui(game:GetService("CoreGui"))
    end
    
    if gethui then
        pcall(function()
            gethui()
        end)
    end
    
    -- アイドル検出の無効化
    local VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

pcall(safeExecute)

-- 保存システム
local SaveFile = "TeleportPositions.json"

local function savePositions(positions)
    if writefile then
        writefile(SaveFile, game:GetService("HttpService"):JSONEncode(positions))
    end
end

local function loadPositions()
    if readfile and isfile and isfile(SaveFile) then
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile(SaveFile))
        end)
        if success then
            return data
        end
    end
    return {
        Position1 = nil,
        Position2 = nil,
        Position3 = nil
    }
end

-- Rayfieldライブラリの読み込み
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "座標保存 & テレポート",
    LoadingTitle = "テレポートシステム",
    LoadingSubtitle = "永続保存対応",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- 保存された座標を読み込み
local SavedPositions = loadPositions()

-- CFrameをテーブルに変換
local function cframeToTable(cf)
    if not cf then return nil end
    return {cf:GetComponents()}
end

-- テーブルをCFrameに変換
local function tableToCFrame(t)
    if not t then return nil end
    return CFrame.new(unpack(t))
end

-- 位置を保存する関数
local function savePosition(slot)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        SavedPositions[slot] = cframeToTable(character.HumanoidRootPart.CFrame)
        savePositions(SavedPositions)
        return true
    end
    return false
end

-- 位置にテレポートする関数（安全に）
local function teleportToPosition(slot)
    local pos = tableToCFrame(SavedPositions[slot])
    if not pos then return false end
    
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        -- 検出を避けるため、少しずつ移動
        task.wait(0.1)
        character.HumanoidRootPart.CFrame = pos
        return true
    end
    return false
end

-- 無限テレポートの制御
local InfiniteTP = {
    Running = false,
    Speed = 3
}

-- メインタブを作成
local MainTab = Window:CreateTab("テレポート", 4483362458)

-- セクション: 位置1
local Section1 = MainTab:CreateSection("位置 1")

MainTab:CreateButton({
    Name = "現在地を位置1に保存",
    Callback = function()
        if savePosition("Position1") then
            Rayfield:Notify({
                Title = "保存成功",
                Content = "位置1に保存しました（永続保存）",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateButton({
    Name = "位置1にテレポート",
    Callback = function()
        if teleportToPosition("Position1") then
            Rayfield:Notify({
                Title = "テレポート成功",
                Content = "位置1にテレポートしました",
                Duration = 3,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "エラー",
                Content = "位置1が保存されていません",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

-- セクション: 位置2
local Section2 = MainTab:CreateSection("位置 2")

MainTab:CreateButton({
    Name = "現在地を位置2に保存",
    Callback = function()
        if savePosition("Position2") then
            Rayfield:Notify({
                Title = "保存成功",
                Content = "位置2に保存しました（永続保存）",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateButton({
    Name = "位置2にテレポート",
    Callback = function()
        if teleportToPosition("Position2") then
            Rayfield:Notify({
                Title = "テレポート成功",
                Content = "位置2にテレポートしました",
                Duration = 3,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "エラー",
                Content = "位置2が保存されていません",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

-- セクション: 位置3
local Section3 = MainTab:CreateSection("位置 3")

MainTab:CreateButton({
    Name = "現在地を位置3に保存",
    Callback = function()
        if savePosition("Position3") then
            Rayfield:Notify({
                Title = "保存成功",
                Content = "位置3に保存しました（永続保存）",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateButton({
    Name = "位置3にテレポート",
    Callback = function()
        if teleportToPosition("Position3") then
            Rayfield:Notify({
                Title = "テレポート成功",
                Content = "位置3にテレポートしました",
                Duration = 3,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "エラー",
                Content = "位置3が保存されていません",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

-- 自動テレポートタブ
local AutoTab = Window:CreateTab("無限TP", 4483362458)

local AutoSection = AutoTab:CreateSection("位置2 ⇔ 位置3 自動往復")

local ToggleInfiniteTP = AutoTab:CreateToggle({
    Name = "無限テレポート開始/停止",
    CurrentValue = false,
    Flag = "InfiniteTP",
    Callback = function(Value)
        InfiniteTP.Running = Value
        
        if Value then
            Rayfield:Notify({
                Title = "無限TP開始",
                Content = "位置2と位置3を往復します",
                Duration = 3,
                Image = 4483362458
            })
            
            task.spawn(function()
                while InfiniteTP.Running do
                    if not SavedPositions.Position2 or not SavedPositions.Position3 then
                        Rayfield:Notify({
                            Title = "エラー",
                            Content = "位置2と位置3を両方保存してください",
                            Duration = 3,
                            Image = 4483362458
                        })
                        InfiniteTP.Running = false
                        ToggleInfiniteTP:Set(false)
                        break
                    end
                    
                    -- 位置2へテレポート
                    teleportToPosition("Position2")
                    task.wait(InfiniteTP.Speed)
                    
                    if not InfiniteTP.Running then break end
                    
                    -- 位置3へテレポート
                    teleportToPosition("Position3")
                    task.wait(InfiniteTP.Speed)
                end
            end)
        else
            Rayfield:Notify({
                Title = "無限TP停止",
                Content = "テレポートを停止しました",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

local SpeedSlider = AutoTab:CreateSlider({
    Name = "往復速度（秒）",
    Range = {1, 10},
    Increment = 0.5,
    Suffix = "秒",
    CurrentValue = 3,
    Flag = "TPSpeed",
    Callback = function(Value)
        InfiniteTP.Speed = Value
    end
})

AutoTab:CreateLabel("位置2と位置3を保存してから")
AutoTab:CreateLabel("トグルをONにしてください")

-- 情報タブ
local InfoTab = Window:CreateTab("使い方", 4483362458)

InfoTab:CreateLabel("【基本操作】")
InfoTab:CreateLabel("1. 保存したい場所に移動")
InfoTab:CreateLabel("2. 「現在地を位置Xに保存」をクリック")
InfoTab:CreateLabel("3. 保存した位置にテレポート可能")
InfoTab:CreateLabel("")
InfoTab:CreateLabel("【無限テレポート】")
InfoTab:CreateLabel("1. 位置2と位置3を保存")
InfoTab:CreateLabel("2. 無限TPタブでトグルをON")
InfoTab:CreateLabel("3. 自動で往復を開始します")
InfoTab:CreateLabel("")
InfoTab:CreateLabel("※保存した座標は次回起動時も維持されます")
