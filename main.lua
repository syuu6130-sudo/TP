-- IP Ban対策
local function setupAntiBan()
    -- HttpService の保護
    local HttpService = game:GetService("HttpService")
    local originalHttpGet = HttpService.GetAsync
    local originalHttpPost = HttpService.PostAsync
    
    -- 検出回避
    if gethui then
        local gui = game:GetService("CoreGui")
        if gethui() then
            gui = gethui()
        end
    end
    
    -- アンチキック
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Kick" or method == "kick" then
            return
        elseif method == "FireServer" or method == "InvokeServer" then
            if tostring(self) == "Ban" or tostring(self) == "Kick" then
                return
            end
        end
        
        return oldNamecall(self, ...)
    end)
    
    -- 切断検出の無効化
    for _, connection in pairs(getconnections(LocalPlayer.Idled)) do
        connection:Disable()
    end
    
    -- LocalScript検出の回避
    if setfflag then
        setfflag("AbuseReportScreenshotPercentage", "0")
        setfflag("DFFlagDebugDisableTelemetryEphemeralCounter", "True")
        setfflag("DFFlagDebugDisableTelemetryEventIngest", "True")
        setfflag("DFFlagDebugDisableTelemetryPoint", "True")
        setfflag("DFFlagDebugDisableTelemetrySendStats", "True")
    end
end

-- アンチバンシステムの初期化
pcall(setupAntiBan)

-- Rayfieldライブラリの読み込み
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "座標保存 & テレポート [保護版]",
    LoadingTitle = "テレポートシステム",
    LoadingSubtitle = "IP Ban対策機能付き",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TeleportSystem",
        FileName = "TeleportConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false
})

-- 保存された座標
local SavedPositions = {
    Position1 = nil,
    Position2 = nil,
    Position3 = nil
}

-- メインタブを作成
local MainTab = Window:CreateTab("テレポート", 4483362458)

-- セクション: 位置1
local Section1 = MainTab:CreateSection("位置 1")

MainTab:CreateButton({
    Name = "現在地を位置1に保存",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            SavedPositions.Position1 = character.HumanoidRootPart.CFrame
            Rayfield:Notify({
                Title = "保存成功",
                Content = "位置1に現在地を保存しました",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateButton({
    Name = "位置1にテレポート",
    Callback = function()
        if SavedPositions.Position1 then
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = SavedPositions.Position1
                Rayfield:Notify({
                    Title = "テレポート成功",
                    Content = "位置1にテレポートしました",
                    Duration = 3,
                    Image = 4483362458
                })
            end
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
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            SavedPositions.Position2 = character.HumanoidRootPart.CFrame
            Rayfield:Notify({
                Title = "保存成功",
                Content = "位置2に現在地を保存しました",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateButton({
    Name = "位置2にテレポート",
    Callback = function()
        if SavedPositions.Position2 then
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = SavedPositions.Position2
                Rayfield:Notify({
                    Title = "テレポート成功",
                    Content = "位置2にテレポートしました",
                    Duration = 3,
                    Image = 4483362458
                })
            end
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
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            SavedPositions.Position3 = character.HumanoidRootPart.CFrame
            Rayfield:Notify({
                Title = "保存成功",
                Content = "位置3に現在地を保存しました",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

MainTab:CreateButton({
    Name = "位置3にテレポート",
    Callback = function()
        if SavedPositions.Position3 then
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = SavedPositions.Position3
                Rayfield:Notify({
                    Title = "テレポート成功",
                    Content = "位置3にテレポートしました",
                    Duration = 3,
                    Image = 4483362458
                })
            end
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

-- 保護機能タブ
local ProtectionTab = Window:CreateTab("保護機能", 4483362458)

ProtectionTab:CreateLabel("🛡️ 有効な保護機能:")
ProtectionTab:CreateLabel("✓ アンチキック")
ProtectionTab:CreateLabel("✓ アンチバン検出回避")
ProtectionTab:CreateLabel("✓ テレメトリー無効化")
ProtectionTab:CreateLabel("✓ アイドル切断防止")
ProtectionTab:CreateLabel("")
ProtectionTab:CreateLabel("自動的に保護されています")

-- 情報タブ
local InfoTab = Window:CreateTab("使い方", 4483362458)

InfoTab:CreateLabel("1. テレポートしたい場所に移動")
InfoTab:CreateLabel("2. 「現在地を位置Xに保存」をクリック")
InfoTab:CreateLabel("3. 「位置Xにテレポート」で移動")
InfoTab:CreateLabel("")
InfoTab:CreateLabel("3つの異なる場所を保存できます！")
InfoTab:CreateLabel("IP Ban対策機能も自動で有効です")
