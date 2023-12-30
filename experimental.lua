wait(15) 
getgenv().config = {
        placeId = 8737899170,
        eventName = "Gingerbread", -- prob to change it to Comet or Coin Jar
        servers = {
            count = 100, -- 10, 25, 50, 100
            sort = "Desc", -- Desc, Asc
            pageDeep = math.random(2, 6), -- selected players page
        },
        delays = {
            beforeExecute = 0.3,
            beforeBreak = 1.5,
            afterBreak = 2.4,
            hit = 0.03,
            lootbag = 0.03,
            beforeTp = 2,
            whileError = 10,
        },
    }

if not getgenv().config then 
    getgenv().config = { 
        placeId = 8737899170, 
        eventName = "Gingerbread",
        count = 100, 
        sort = "Asc", 
        pageDeep = math.random(2, 10), 
        delays = { beforeExecute = 0.3, beforeBreak = 1.5, afterBreak = 2.4, hit = 0.03, lootbag = 0.03, beforeTp = 2, whileError = 10, }, 
    } 
end 
repeat wait() until game.PlaceId ~= nil 
if not game:IsLoaded() then
        game.Loaded:Wait() 
end 
local ReplicatedStorage = game:GetService("ReplicatedStorage") 
local HttpService = game:GetService("HttpService") 
local Players = game:GetService("Players") 
local TeleportService = game:GetService("TeleportService") 
wait(config.delays.beforeExecute) 
if game.PlaceId ~= config.placeId then print("Gingerbread hunter unloaded, unknown place.")
        return
end 
local Library = require(ReplicatedStorage:WaitForChild("Library", 2000)) 
if not Library.Loaded then
        repeat wait() until Library.Loaded ~= false
end 
local RandomEventCmds = Library.RandomEventCmds 
local LocalPlayer = Players.LocalPlayer 
local Character = LocalPlayer.Character 
local Humanoid = Character:WaitForChild("Humanoid", 1000) 
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 1000) 
print(HttpService:JSONEncode(config)) 
function tpToPos(cframe) 
    HumanoidRootPart.CFrame = CFrame.new(cframe) 
end 
function jumpToServer() 
    local sfUrl = "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=%s&excludeFullGames=true" 
    local req = request({ Url = string.format(sfUrl, config.placeId, config.servers.sort, config.servers.count) }) 
    local body = HttpService:JSONDecode(req.Body) 
    if config.servers.pageDeep > 1 then 
        for i = 1, config.servers.pageDeep, 1 do 
            req = request({ Url = string.format( sfUrl .. "&cursor=" .. body.nextPageCursor, config.placeId, config.servers.sort, config.servers.count ), }) 
            body = HttpService:JSONDecode(req.Body) 
            wait(0.1) 
        end 
    end 
    local servers = {} 
    if body and body.data then 
        for i, v in next, body.data do 
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, 1, v.id) 
            end 
        end 
    end 
    local randomCount = #servers 
    if not randomCount then
       randomCount = 2
    end 
    TeleportService:TeleportToPlaceInstance(config.placeId, servers[math.random(1, randomCount)], Players.LocalPlayer) 
end 
Library.Alert.Message("Finding Gingerbread...") 
local activeEvents = RandomEventCmds.GetActive() or RandomEventCmds.GetActive()
local isGingerbreadExist = false
wait(config.delays.beforeExecute)
for eventId, event in activeEvents do
        if event.name == config.eventName then
                isGingerbreadExist = true
                tpToPos(event.origin + Vector3.new(0, 18, 0))
        end
end 
Library.Things:FindFirstChild("Lootbags").ChildAdded:Connect(function(lootbag)
                wait()
                if lootbag then
                        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Lootbags_Claim"):FireServer(unpack({ [1] = { [1] = lootbag.Name, }, }))
                end 
end)  
function CollectAllLootbags() pcall(function() 
        for _, lootbag in pairs(Library.Things:FindFirstChild("Lootbags"):GetChildren()) do
                if lootbag and not lootbag:GetAttribute("Collected") then
                        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Lootbags_Claim"):FireServer(unpack({ [1] = { [1] = lootbag.Name, }, }))
                                wait(config.delays.lootbag)
                end
        end
end) 
end 
function findGingerbread() 
        for index, breakable in Library.Things.Breakables:GetChildren() do
                if breakable.ClassName == "Model" and breakable:GetAttribute("BreakableID") == config.eventName then
                        return breakable
                end
        end
end 
if isGingerbreadExist then
        Library.Alert.Message("Gingerbread exist!")
        wait(config.delays.beforeBreak)
        local findedGingerbread = nil
        for i = 1, 5, 1 do
                findedGingerbread = findGingerbread()
                if findedGingerbread then
                        tpToPos(findedGingerbread.PrimaryPart.Position + Vector3.new(0, 18, 0))
                        break
                else
                        wait(0.5)
                end
        end
        if findedGingerbread then
                Library.Alert.Message("Start breaking!")
                while Library.Things.Breakables:FindFirstChild(findedGingerbread.Name) do
                        local args = { [1] = findedGingerbread.Name, } game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Breakables_PlayerDealDamage"):FireServer(unpack(args))
                        wait(config.delays.hit)
                end
                Library.Alert.Message("Broke!")
                findedGingerbread = false
        end
        CollectAllLootbags()
        wait(config.delays.afterBreak)
        CollectAllLootbags()
        wait(config.delays.afterBreak)
else
        Library.Alert.Message("Gingerbread not found :c")
end
TeleportService.TeleportInitFailed:Connect(function(player, resultEnum, msg)
                print(string.format("server: teleport %s failed, resultEnum:%s, msg:%s", player.Name, tostring(resultEnum), msg))
                config.servers.pageDeep = config.servers.pageDeep + 1
                Library.Alert.Message("Tp Retry... :" .. msg)
                wait(config.delays.whileError)
                jumpToServer()
        end) 
wait(config.delays.beforeTp)
Library.Alert.Message("Tp to another server...")
jumpToServer()
