local plr = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
local location = CFrame.new
local Start = CFrame.new(-470.3416748046875, 3.2000062465667725, -227.631591796875) * CFrame.Angles(3.141592502593994, -1.4962693452835083, 3.141592502593994)

getgenv().Balls = false;
getgenv().Craft = false;
getgenv().Egg = false;
getgenv().FreeReward = false;

local config = {
    ["EggHatchDelay"] = 0.1;
    ["Egg"] = {"Moon Egg", "Multi"} -- "Classic Egg", "Sand Egg", "Ice Egg", "Magma Egg", "Pearl Egg", "Moon  Egg" (Even if you down own triple keep the Triple there)
}
 
local keybinds = {
    ["Ballz"] = Enum.KeyCode.E; 
    ["Tp"] = Enum.KeyCode.T;
    ["AutoCraft"] = Enum.KeyCode.G;
    ["EggHatch"] = Enum.KeyCode.H;
    ["FreeRewards"] = Enum.KeyCode.J;
}
d
uis.InputBegan:Connect(function(key,gpe)
    local chr = plr.Character or plr.CharacterAdded:Wait()
    local hrp = chr:FindFirstChild("HumanoidRootPart")
    if not gpe and hrp ~= nil then
        key = key.KeyCode
        if key == keybinds.Ballz then
           if getgenv().Balls == false then
                getgenv().Balls = true
                repeat
                    rs.Events.RequestShoot:InvokeServer(Start)
                    if getgenv().Craft == true then
                        rs.Events.UIAction:FireServer("CombineAllBalls")
                        rs.Events.UIAction:FireServer("EquipBestBalls")
                    end
                    game:GetService("ReplicatedStorage").Events.UIAction:FireServer("Sell")
                until getgenv().Balls == false
            elseif getgenv().Balls == true then
                getgenv().Balls = false
                game:GetService("ReplicatedStorage").Events.RequestCancelShoot:FireServer()
            end
        elseif key == keybinds.EggHatch then
            if getgenv().Egg == false then
                getgenv().Egg = true
                repeat
                    rs.Events.RequestEggHatch:FireServer(unpack(config.Egg))
                    wait(config.EggHatchDelay)
                until getgenv().Egg == false
            elseif getgenv().Egg == true then
                getgenv().Egg = false
            end
        elseif key == keybinds.AutoCraft then
            if getgenv().Craft == false then
                getgenv().Craft = true
            elseif getgenv().Craft == true then
                getgenv().Craft = false
            end
        elseif key == keybinds.FreeRewards then
            if getgenv().FreeReward == false then
                getgenv().FreeReward = true
                repeat
                    for i=1,12 do
                        game:GetService("ReplicatedStorage").Events.UIAction:FireServer("ClaimTimeReward",i)
                        wait(1)
                    end
                until getgenv().FreeReward == false
            elseif getgenv().FreeReward == true then
                getgenv().FreeReward = false
        elseif key == keybinds.Tp then
            pl.CFrame = location(-470.3416748046875, 3.2000062465667725, -227.631591796875)
            end
        end
    end
end)