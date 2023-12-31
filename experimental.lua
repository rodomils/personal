-- I would appreciate if the credits doesn't get removed, ty!
-- Credits: "fissurectomy" in Discord without the quotes!
-- Modified by root (s.g.i)

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   task.wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

if Stairway == true then
	return
end

pcall(function() getgenv().Stairway = true end)

game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "More Info",
		Text = 'Type "/console" in chat to know what this is for',
		Duration = 10,
	})
	
print("Basically there's a unique achievement which you can get in Pet Simulator 99 called 'Is It Real?' which gives you a huge pet which at the moment only has 2 player that has it. Everytime you ascend into the skies, there is a 1 in 1 Million chance that you will get the pet. It is unique and can be traded for a bunch of titanics. This script automates the whole climbing thing as fast as possible, good luck!")

local coordinates
local notifs = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/main/FE2Notifs.lua'))()

notifs.alert('Execute "_G.s = false" to stop!\nThis is the fastest it can go due to stairs being generated.', nil, 1000000, 'rainbow')
task.wait(0.01)

local lastNotificationTime = 0
local notificationDelay = 0.5

local function updateCoordinates()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    coordinates = humanoidRootPart.Position.Y -- Only the Y axis

    local currentTime = tick()
    if currentTime - lastNotificationTime >= notificationDelay then
        notifs.alert('Studs above the sky: ' .. tostring(math.floor(coordinates)) .. '', nil, 0.5) -- Display Y axis without decimals
        lastNotificationTime = currentTime
    end
end

game:GetService("RunService").Heartbeat:Connect(updateCoordinates)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(120.79306030273438, -126.99183654785156, -213.44664001464844)

task.wait(5)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(630.6519165039062, 143.7024383544922, -1891.4598388671875)

task.wait(1)

local s = false
local function updateYCoordinate()
    local currentCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local currentPosition = currentCFrame.Position
    currentPosition = Vector3.new(currentPosition.X, currentPosition.Y + 36, currentPosition.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentPosition)
end


game:GetService("RunService").Heartbeat:Connect(function()
    if game:GetService("Workspace")["__THINGS"]["__INSTANCE_CONTAINER"].Active.StairwayToHeaven.Stairs:FindFirstChild("Goal") ~= nil then
        game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "Goal Found!",
		Text = 'wtf how',
		Duration = 10,
	})
	s = true
    end
    break
end)

while wait(0.1) do
    if s == false then
    	updateYCoordinate()
    end
end
