local plr = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
local Rendered = game.Workspace.Render
local location = CFrame.new
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Sling Script v1.0", "Sentinel")
local Boost = plr.PlayerGui.MainGui.StartFrame.Boosts
local CoinBoost = Boost.Coins.Timer or Boost.ServerBoost2xCoins.Timer
local LuckBoost = Boost.Lucky.Timer or Boost.ServerBoostLucky.Timer
local SLuckBoost = Boost.Lucky.Timer and Boost.ServerBoostLucky.Timer
local Areas
local Resend
local ResendSettings = plr.PlayerGui.MainGui.OtherFrames.Settings.ScrollingFrameHolder.ScrollingFrame.RenderOtherBalls.ToggleButton.Img
local Type
local Egg
local WebhookUrl
local BallValue


getgenv().Autosell = false;
getgenv().BoostSell = false;
getgenv().Balls = false;
getgenv().BallResend = false;
getgenv().Shiny = false;
getgenv().Egg = false;
getgenv().Boostluck = false;
getgenv().FreeReward = false;
getgenv().Equip = false;
getgenv().Antiafk = false;
getgenv().Webhook = false;
getgenv().Achievements = false;
getgenv().Daily = false;

--Farming
local Farming = Window:NewTab("Farming")
local FarmingSection = Farming:NewSection("Farming")

FarmingSection:NewLabel("Don't forget to chose an area")

FarmingSection:NewToggle("Autofarm", "Turn Autofarm on/off (make sure to select and area first", function(Autofarmstate)
    if Autofarmstate then
        getgenv().Balls = true
        repeat
            rs.Events.RequestShoot:InvokeServer(CFrame.new(Areas, 3, -228) * CFrame.Angles(3.1415927410125732, 1.5255541896820068, -3.1415927410125732))
            if getgenv().Shiny == true then
                rs.Events.UIAction:FireServer("CombineAllBalls")
            end
            if getgenv().Equip == true then
                rs.Events.UIAction:FireServer("EquipBestBalls")
            end
            if getgenv().Autosell == true then
                rs.Events.UIAction:FireServer("Sell")
            end
        until getgenv().Balls == false    
    else
        getgenv().Balls = false
        rs.Events.RequestCancelShoot:FireServer()
    end 
end)

FarmingSection:NewToggle("Autosell", "Choose if you want to automatically sell. Good for people without inf bag", function(Autosellstate)
    if Autosellstate then
        getgenv().Autosell = true
    else
        getgenv().Autosell = false
    end
end)

FarmingSection:NewToggle("Sell when boost", "Choose if you want to sell only if you have coin boost on. Good for people with inf bag", function(state)
    if state then
        getgenv().BoostSell = true
        repeat
            if CoinBoost.text ~= "00:00" and CoinBoost.text ~= "00:01" then
                rs.Events.UIAction:FireServer("Sell")
            end
            wait(10)
        until getgenv().BoostSell == false
    else
        getgenv().BoostSell = false
    end
end)

FarmingSection:NewToggle("Ball Resend", "If you want that it resends when there a under a certain number of ball in the area", function(Resendstate)
    if Resendstate then
        getgenv().BallResend = true
        repeat
            if ResendSettings.Visible == true then
                rs.Events.UIAction:FireServer("ChangeSetting","RenderOtherBalls")
            end
            for i in Rendered:GetChildren() do
                BallNum = i
            end
            print(BallNum)
            if BallNum >= BallValue then
                repeat
                    wait(0.5)
                    for i in Rendered:GetChildren() do
                        BallNum = i
                    end
                    print("Waiting, Current amount:", BallNum)
                until BallNum < BallValue
                print ("Relaunching")
                rs.Events.RequestCancelShoot:FireServer()
            end
            wait(0.5)
        until getgenv().BallResend == false
    else
        getgenv().BallResend = false
    end
end)

FarmingSection:NewSlider("Number a balls until resend", "Minimum of balls before resend", 50, 1, function(Value) -- 36 (MaxValue) | 1 (MinValue)
    BallValue = Value
    print(BallValue)
end)

FarmingSection:NewDropdown("Area", "Select the area you want to farm in", {1, 2, 3, 4, 5, 6, 7, 8, 9,}, function(AreaOption)
    print(AreaOption)
   	Areas = 618 - AreaOption * 168
    pl.CFrame = CFrame.new(Areas - 75, 3, -300)
    print(Areas)
end)

--Hatching
local Hatching = Window:NewTab("Hatching")
local HatchingSection = Hatching:NewSection("Hatching")

HatchingSection:NewLabel("Don't forget to chose an egg and an hatch type")

HatchingSection:NewToggle("Hatch", "Start hatching", function(Hatchstate)
    if Hatchstate then
        getgenv().Egg = true
        repeat
            rs.Events.RequestEggHatch:FireServer(Egg,Type)
            wait(0.1)
        until getgenv().Egg == false
    else
        getgenv().Egg = false
    end
end)

HatchingSection:NewToggle("Auto Shiny", "Automatically merges ur pets to make them shiny", function(Shinystate) 
    if Shinystate then
        getgenv().Shiny = true
        repeat
            if getgenv().Balls == false then
                rs.Events.UIAction:FireServer("CombineAllBalls")
            end
            wait(1)
        until getgenv().Shiny == false
    else
        getgenv().Shiny = false
    end
end)

HatchingSection:NewToggle("Auto Equip Best", "Automatically equip ur best pets", function(Equipstate)
    if Equipstate then
        getgenv().Equip = true
        repeat
            if getgenv().Balls == false then
                rs.Events.UIAction:FireServer("EquipBestBalls")
            end
            wait(1)
        until getgenv().Equip == false
    else
        getgenv().Equip = false
    end
end)

HatchingSection:NewDropdown("Hatch Type", "Select the  number of eggs you can hatch", {"Single", "Multi"}, function(HatchOption)
    print(HatchOption)
    Type = HatchOption
    print(Type)
end)

HatchingSection:NewDropdown("Eggs", "Select the egg you want to hatch", {"Classic Egg", "Sand Egg", "Ice Egg", "Magma Egg", "Pearl Egg", "Moon Egg", "Candy Egg", "Mushroom Egg", "Hourglass Egg", "5M Egg",}, function(EggOption)
    print(EggOption)
    Egg = EggOption
    print(Egg)
end)

--HourGlass Egg
local HourGlass = Window:NewTab("HourGlass Egg")
local HourGlassSection = HourGlass:NewSection("HourGlass Egg")

HourGlassSection:NewLabel("Only works if you're hatching the HourGlass Egg")

HourGlassSection:NewToggle("Boosts luck when on Luck multiplier", "Choose if you want to automatically sell. Good for people without inf bag", function(state)
    if state then
        getgenv().Boostluck = true
        repeat
            if SLuckBoost.text ~= "00:00" and SLuckBoost.text ~= "00:01" then
                rs.Events.UIAction:FireServer("SetBoostedEggTier", Type3)
            elseif LuckBoost.text ~= "00:00" and LuckBoost.text ~= "00:01" then
                rs.Events.UIAction:FireServer("SetBoostedEggTier", Type2)
            else
                rs.Events.UIAction:FireServer("SetBoostedEggTier", Type1)
            end
            wait(10)
        until getgenv().Boostluck == false
    else
        getgenv().Boostluck = false
    end
end)

HourGlassSection:NewDropdown("Original Option", "When no boost are active", {1, 2, 3, 4, 5, 6, 7}, function(Option)
    Type1 = Option - 1
    print(Type1)
end)

HourGlassSection:NewDropdown("1 Boost Active", "When 1 luck boost is active", {1, 2, 3, 4, 5, 6, 7}, function(Option)
    Type2 = Option - 1
    print(Type2)
end)

HourGlassSection:NewDropdown("2 Boost Active", "When 2 luck boost are active", {1, 2, 3, 4, 5, 6, 7}, function(Option)
    Type3 = Option - 1
    print(Type3)
end)

--Misc
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc")

MiscSection:NewToggle("Auto time rewards", "Automatically collect time rewards", function(Rewardsstate)
    if Rewardsstate then
        getgenv().FreeReward = true
        repeat
            for i=1,12 do
                rs.Events.UIAction:FireServer("ClaimTimeReward",i)
                wait(2)
            end
        until getgenv().FreeReward == false
    else
        getgenv().FreeReward = false
    end
end)

MiscSection:NewToggle("Auto Achievement", "Auto claims achievements", function(state)
    if state then
        getgenv().Achievements = true
        repeat
            rs.Events.UIAction:FireServer("ClaimAchievement", "Eggs")
            rs.Events.UIAction:FireServer("ClaimAchievement", "Balls")
            wait(1)
        until getgenv().Achievements == false
    else
        getgenv().Achievements = false
    end
end)

MiscSection:NewToggle("Auto Daily", "Auto claims dailies", function(state)
    if state then
        getgenv().Daily = true
        repeat
            rs.Events.UIAction:FireServer("ClaimDailyReward")
            wait(10)
        until getgenv().Daily == false
    else
        getgenv().Daily = false
    end
end)

MiscSection:NewButton("Anti-Afk", "Make you unable to get kicked from being", function()
    local vu = game:GetService("VirtualUser")
    plr.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

--User
local User = Window:NewTab("User")
local UserSection = User:NewSection("User")

UserSection:NewSlider("WalkSpeed", "Modify how fact your go!", 300, 30, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

UserSection:NewSlider("JumpPower", "Modify how high you jump!", 250, 50, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

--Webhooks
local Webhooks = Window:NewTab("Webhooks")
local WebhooksSection = Webhooks:NewSection("Webhooks")

WebhooksSection:NewTextBox("Webhook Url", "Url of the webhook you want yo send the notifier to", function(txt)
	WebhookUrl = txt
end)

WebhooksSection:NewToggle("Hatch Notify", "Toggle the hatching notifier", function(state)
    if state then
        getgenv().Webhook = true
    else
        pgetgenv().Webhook = false
    end
end)

--Settings
local Settings = Window:NewTab("Settings")
local SettingsSection = Settings:NewSection("Settings")

SettingsSection:NewKeybind("Toggle Ui", "Toggles the script GUI", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)
