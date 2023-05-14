local plr = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
local Rendered = game.Workspace.Areas
local location = CFrame.new
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Sling Script v1.0", "Sentinel")
local Areas
local Resend
local Type
local Egg
local WebhookUrl



getgenv().Balls = false;
getgenv().BallResend = false;
getgenv().Craft = false;
getgenv().Egg = false;
getgenv().FreeReward = false;
getgenv().Equip = false;
getgenv().Antiafk = false;
getgenv().Webhook = false;
getgenv().Achievements = false;

--Farming
local Farming = Window:NewTab("Farming")
local FarmingSection = Farming:NewSection("Farming")

FarmingSection:NewLabel("Don't forget to chose an area")

FarmingSection:NewToggle("Autofarm", "Turn Autofarm on/off (make sure to select and area first", function(Autofarmstate)
    if Autofarmstate then
        getgenv().Balls = true
        repeat
            rs.Events.RequestShoot:InvokeServer(CFrame.new(Areas, 3, -228) * CFrame.Angles(3.1415927410125732, 1.5255541896820068, -3.1415927410125732))
            if getgenv().Craft == true then
                rs.Events.UIAction:FireServer("CombineAllBalls")
            end
            if getgenv().Equip == true then
                rs.Events.UIAction:FireServer("EquipBestBalls")
            end
            if getgenv().Autosell == true then
            game:GetService("ReplicatedStorage").Events.UIAction:FireServer("Sell")
            end
        until getgenv().Balls == false    
    else
        getgenv().Balls = false
        game:GetService("ReplicatedStorage").Events.RequestCancelShoot:FireServer()
    end 
end)

FarmingSection:NewToggle("Autosell", "Choose if you want to automatically sell. Good for people without inf bag", function(Autosellstate)
    if Autosellstate then
        getgenv().Autosell = true
    else
        getgenv().Autosell = false
    end
end)

FarmingSection:NewToggle("Ball Resend (Not working proprely)", "If you want that it resends when there a under a certain number of ball in the area", function(Resendstate)
    if Resendstate then
        getgenv().BallResend = true
        repeat
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
                    print("Waiting")
                until BallNum < BallValue
                print ("Relaunching")
                game:GetService("ReplicatedStorage").Events.RequestCancelShoot:FireServer()
            end
            wait(1)
        until getgenv().BallResend == false
    else
        getgenv().BallResend = false
    end
end)

FarmingSection:NewSlider("Number a balls until resend", "Minimum of balls before resend", 50, 1, function(BallValue) -- 36 (MaxValue) | 1 (MinValue)
    print(BallValue)
end)

FarmingSection:NewDropdown("Area", "Select the area you want to farm in", {1, 2, 3, 4, 5, 6, 7, 8,}, function(AreaOption)
    print(AreaOption)
   	Areas = 618 - AreaOption * 168
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
        getgenv().Craft = true
        if getgenv().Balls == false then
            repeat
                rs.Events.UIAction:FireServer("CombineAllBalls")
                wait(1)
            until getgenv().Balls == true
        end
    else
        getgenv().craft = false
    end
end)

HatchingSection:NewToggle("Auto Equip Best", "Automatically equip ur best pets", function(Equipstate)
    if Equipstate then
        getgenv().Equip = true
        if getgenv().Balls == false then
            repeat
                rs.Events.UIAction:FireServer("EquipBestBalls")
                wait(1)
            until getgenv().Balls == true
        end
    else
        getgenv().Equip = false
    end
end)

HatchingSection:NewDropdown("Hatch Type", "Select the  number of eggs you can hatch", {"Single", "Multi"}, function(HatchOption)
    print(HatchOption)
    Type = HatchOption
    print(Type)
end)

HatchingSection:NewDropdown("Eggs", "Select the egg you want to hatch", {"Classic Egg", "Sand Egg", "Ice Egg", "Magma Egg", "Pearl Egg", "Moon  Egg", "Candy Egg","Mushroom Egg",}, function(EggOption)
    print(EggOption)
    Egg = EggOption
    print(Egg)
end)

--Misc
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc")

MiscSection:NewToggle("Auto time rewards", "Automatically collect time rewards", function(Rewardsstate)
    if Rewardsstate then
        getgenv().FreeReward = true
        repeat
            for i=1,12 do
                game:GetService("ReplicatedStorage").Events.UIAction:FireServer("ClaimTimeReward",i)
                wait(1)
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
            rs.Events.UIAction:FireServer("ClaimAchievement", "Eggs")
        until getgenv().Achievements == false
    else
        getgenv().Achievements = false
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
