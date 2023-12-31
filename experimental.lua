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

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(120.79306030273438, -126.99183654785156, -213.44664001464844)

task.wait(5)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(630.6519165039062, 143.7024383544922, -1891.4598388671875)

task.wait(1)

local s = false
local Players = game:GetService("Players")
local function updateYCoordinate()
    local currentCFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local currentPosition = currentCFrame.Position
    currentPosition = Vector3.new(currentPosition.X, currentPosition.Y + 36, currentPosition.Z)
    Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentPosition)
end

local connect

connect = game:GetService("RunService").Heartbeat:Connect(function()
    if game:GetService("Workspace")["__THINGS"]["__INSTANCE_CONTAINER"].Active.StairwayToHeaven.Stairs:FindFirstChild("Goal") ~= nil then
        local http = game:GetService("HttpService")
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "Goal Found!",
		Text = 'wtf how',
		Duration = 10,
	})
	s = true

	local message1 = {
            ['content'] = "@everyone yo congrats on the first huge golden angel dog in a long time",
    	}

    	local jsonMessage = http:JSONEncode(message1)
    	local success, webMessage = pcall(function()
	    http:PostAsync(weburl, jsonMessage)
        end)
    	if success == false then
            local response = request({
                Url = weburl,
           	Method = "POST",
            	Headers = {
                	["Content-Type"] = "application/json"
            	},
           	Body = jsonMessage
        })
    	end
	connect:Disconnect()
    end
end)

while s == false do
    updateYCoordinate()
    wait(0.1)
end
