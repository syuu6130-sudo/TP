-- 安全な実行環境の確保
local function safeExecute()
    -- エグゼキューターの検出回避
    if syn and syn.protect_gui then
        syn.protect_gui(game:GetService("CoreGui"))
    end
    
    if gethui then
        pcall(function()
            gethui()
        end)
    end
    
    -- アイドル検出の無効化（目立たない方法で）
    local VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

pcall(safeExecute)

-- Rayfieldライブラリの読み込み
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "座標保存 & テレポート",
    LoadingTitle = "テレポートシステム",
    LoadingSubtitle = "by Rayfield",
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

-- 情報タブ
local InfoTab = Window:CreateTab("使い方", 4483362458)

InfoTab:CreateLabel("1. テレポートしたい場所に移動")
InfoTab:CreateLabel("2. 「現在地を位置Xに保存」をクリック")
InfoTab:CreateLabel("3. 「位置Xにテレポート」で移動")
InfoTab:CreateLabel("")
InfoTab:CreateLabel("3つの異なる場所を保存できます！")
