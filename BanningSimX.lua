local plr = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
local location = CFrame.new
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Banning Sim v1.0", "Sentinel")
local chosen = ""
local cooldown = 0.25
local sword1 = 1
local sword2 = 44
local num = 1
local egg = "Jester"
local type = true

getgenv().AutoFarm = false;
getgenv().SwordChanger = false;
getgenv().AutoPrestiges = false;
getgenv().Hatching = false;

--Farming
local Farming = Window:NewTab("Farming")
local FarmingSection = Farming:NewSection("Farming")

FarmingSection:NewLabel("Don't forget to chose an Enemy")

FarmingSection:NewToggle("Autofarm", "Turn Autofarm on/off (make sure to select an enemy first", function(Autofarmstate)
    if Autofarmstate then
        getgenv().AutoFarm = true
        repeat
            rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.damageNPC:FireServer(workspace.npcs:FindFirstChild(chosen))
            wait(cooldown)
        until getgenv().AutoFarm == false    
    else
        getgenv().AutoFarm = false
    end 
end)

FarmingSection:NewTextBox("Enemy", "enemy you want to attack", function(txt)
	chosen = txt
end)

FarmingSection:NewLabel("Under 0.25 could get you kicked")

FarmingSection:NewTextBox("Cooldown", "Cooldown between each hit", function(txt)
	cooldown = txt
end)

-- Other Farming
local Farming2 = Window:NewTab("Other Farming")
local Farming2Section = Farming2:NewSection("Other Farming")

Farming2Section:NewToggle("Sword Upgrader", "Turn Autofarm on/off (make sure to select an enemy first", function(Autofarmstate)
    if Autofarmstate then
        getgenv().SwordChanger = true
        repeat
            for i = sword1, sword2, 1 do
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer()
                wait(5)
            end
        until getgenv().SwordChanger == false    
    else
        getgenv().SwordChanger = false
    end 
end)

Farming2Section:NewLabel("Use the number of the sword")

Farming2Section:NewTextBox("First Sword", "", function(txt)
	Sword1 = txt
end)

Farming2Section:NewTextBox("Last Sword", "", function(txt)
	Sword2 = txt
end)

-- Auto Prestiges
local Prestiges = Window:NewTab("Auto Prestiges")
local PrestigesSection = Prestiges:NewSection("Auto Prestiges")

PrestigesSection:NewLabel("Needs Auto Farm on")

PrestigesSection:NewToggle("Auto Prestiges", "Turn Autofarm on/off (make sure to select an enemy first", function(Autofarmstate)
    if Autofarmstate then
        getgenv().AutoPrestiges = true
        repeat
            rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("worldPrestige/claimPrestige"):FireServer("Ban Land")
            rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.unlockRank:FireServer()
            wait(5)
            if not ws.decoration["Ban Land"]["Jester Castle"].door:FindFirstChild("passage") then
                chosen = "Prince"
            elseif not ws.decoration["Ban Land"]["Toxic Lands"].door:FindFirstChild("passage") then
                chosen = "Toxic Wastelander"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Jester Castle"})
            elseif not ws.decoration["Ban Land"]["Enchanted Forest"].door:FindFirstChild("passage") then
                chosen = "Ud'zal"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Toxic Lands"})
            elseif not ws.decoration["Ban Land"]["Lava Lands"].door:FindFirstChild("passage") then
                chosen = "Headless Doombringer"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Enchanted Forest"})
            elseif not ws.decoration["Ban Land"]["The Mines"].door:FindFirstChild("passage") then
                chosen = "Elemental King"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Lava Lands"})
            elseif not ws.decoration["Ban Land"]["Candy Land"].door:FindFirstChild("passage") then
                chosen = "Pastel Guardian"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","The Mines"})
            elseif not ws.decoration["Ban Land"]["Beach"].door:FindFirstChild("passage") then
                chosen = "Pufferfish King"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Candy Land"})
            elseif not ws.decoration["Ban Land"]["Ice Land"].door:FindFirstChild("passage") then
                chosen = "Ice Golem"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Beach"})
            elseif not ws.decoration["Ban Land"]["Honeycomb"].door:FindFirstChild("passage") then
                chosen = "Onett"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Ice Land"})
            elseif not ws.decoration["Ban Land"]["Sunflower Field"].door:FindFirstChild("passage") then
                chosen = "Magic Floral Man"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Honeycomb"})
            elseif not ws.decoration["Ban Land"]["Desert"].door:FindFirstChild("passage") then
                chosen = "Desert Scout"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Sunflower Field"})
            else
                chosen = "Mushroom King"
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.purchaseZone:FireServer("",{"Ban Land","Desert"})
            end
            print(chosen)
            if plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://11866056302" then
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(16)
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("talismans/equipTalisman"):FireServer(2)
            elseif plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://11866055963" then
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(19)
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("talismans/equipTalisman"):FireServer(3)
            elseif plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://11866055545" then
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(23)
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("talismans/equipTalisman"):FireServer(4)
            elseif plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://11866055833" then
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(27)
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("talismans/equipTalisman"):FireServer(5)
            elseif plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://11866055677" then
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(31)
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("talismans/equipTalisman"):FireServer(6)
            elseif plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://11866056106" then
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(35)
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("talismans/equipTalisman"):FireServer(8)
            elseif plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://13979653364" then
                    rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(39)
            elseif plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://13979653469" then
                    rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(43)
            elseif plr.PlayerGui.FriendlyTags.playerTag.hold.name.rank.image == "rbxassetid://13979658120" then
                    rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(47)
            else
                rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("weapons/changeWeapon"):FireServer(8)
            end
        until getgenv().AutoPrestiges == false    
    else
        getgenv().AutoPrestiges = false
    end 
end)

-- Hatching
local Hatching = Window:NewTab("Hatching")
local HatchingSection = Hatching:NewSection("Hatching")

HatchingSection:NewToggle("Auto Hatch", "Turn Autofarm on/off (make sure to select an enemy first", function(Autofarmstate)
    if Autofarmstate then
        getgenv().Hatching = true
        repeat
            rs.rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("eggs/hatchEgg"):FireServer("",{num,egg,type})
            wait(0.1)
        until getgenv().Hatching == false    
    else
        getgenv().Hatching = false
    end 
end)

HatchingSection:NewDropdown("Hatch Type", "Select the  number of eggs you can hatch", {"Single", "Triple"}, function(Option)
    if Option == "Single" then
        num = 1
    else
        num = 3
    end
end)

HatchingSection:NewDropdown("Hatch Type", "Select the  number of eggs you can hatch", {"Starter","Desert","Honeycomb","Candy","Molten","Jester"}, function(Option)
    egg = Option
    print(egg)
end)

HatchingSection:NewDropdown("Hatch Type", "Select the  number of eggs you can hatch", {"Normal","Void"}, function(Option)
    if Option == "Normal" then
        type = false
    else
        type = true
    end
end)

--Misc
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc")

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

--Settings
local Settings = Window:NewTab("Settings")
local SettingsSection = Settings:NewSection("Settings")

SettingsSection:NewKeybind("Toggle Ui", "Toggles the script GUI", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)
