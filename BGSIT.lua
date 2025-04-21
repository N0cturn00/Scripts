local AuraIS = loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Darkrai-Y/main/Libraries/AuraIS/Main"))()
local plr = game:GetService("Players").LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
local rifts = ws.Rendered.Rifts
local url = "https://discord.com/api/webhooks/1363754891721441300/Uz36RluyQ3QajakHKIhfFTGpj55bIev6xPRnFAP7udbey6lLx5ito0sqMvCsYQBh8mAL"

local function sendWebhookMessage(rift, height, time)
    local data = {
        ["content"] = "<@&1361887069831434411>",
        ["embeds"] = {{
            ["title"] = rift .. " Rift Found!",
            ["description"] = "Height: "..height.."\nTime: "..time.."\n\n[Join]( https://www.roblox.com/users/"..plr.UserId.."/profile)",
            ["color"] = 11346209
          }},
        ["username"] = "BGSIT Rift Notifier",
        ["avatar_url"] = "https://cdn.discordapp.com/icons/1217303904665079809/9df07ded9f75aa5707a15c667b3e8bc4.webp?size=1024&format=webp",
        ["allowed_mentions"] = {
            ["parse"] = {"users", "roles", "everyone"}
        }
    }
    local jsonData = game:GetService("HttpService"):JSONEncode(data)

    if request then
        request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonData
        })
    else
        warn("Your executor does not support HTTP requests.")
    end
end

local function RiftChecker()
    for _, child in ipairs(rifts:GetChildren()) do
        if child:WaitForChild("Display").SurfaceGui:FindFirstChild("Icon") and child:FindFirstChild("Decoration") then
            local mult = child.Display.SurfaceGui.Icon.Luck.Text
            local Name = child.Name .." ".. mult
            local Height = child.Display.Position.Y
            local Time = child.Display.SurfaceGui.Timer.Text
            print(Name)
            if child.Name:find("Aura") then
                sendWebhookMessage(Name, math.round(Height), Time)
                print("--------------------")
            elseif mult == "x25" then
                if child.Name:find("event") or child.Name:find("night") or child.Name:find("void") or child.Name:find("rain") then
                    sendWebhookMessage(Name, math.round(Height), Time)
                end
            end
            child.Decoration.Name = child.Decoration.Name .. " Notified"
        end
    end
end

local Library = AuraIS:CreateLibrary({
    Name = "BGSIT", -- Name
    Icon = "rbxassetid://12974454446" -- Icon
})

local RiftTab = Library:CreateTab("RiftNotifier", "rbxassetid://12974454446")

local RiftSection = RiftTab:CreateSection("Section 1", "Normal")

local SwitchToggle = RiftSection:CreateToggle("Normal", {
    Name = "Notify the rifts in your server",
    Callback = function(Value)
        print("Toggle value: " .. tostring(Value))
        if tostring(Value) == "true" then
            repeat
                print("checking...")
                RiftChecker()
                wait(5)
            until tostring(Value) == "false"
        end
    end,
})
