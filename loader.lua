print("[Loader] Loading script, please wait..")

--> Services <--
local VirtualInputManager = game:GetService("VirtualInputManager")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

--> References <--
local Player = Players.LocalPlayer
local PlaceId = game.PlaceId

--> Games <--
local Games = {
    [86639052909924] = "versepiece/main.lua", -- Verse Piece Main Game
    [119477642078428] = "versepiece/dungeon.lua", -- Verse Piece Dungeons
}

--> Variables <--
local env = getgenv()

--> Functions <--
function Load()
    local Path = Games[PlaceId]
    if Path then
        local Script = "https://raw.githubusercontent.com/NgThjnhPhat/sanguine/main/games/"..Path
        local success, response = pcall(function()
            return game:HttpGet(Script)
        end)
        
        if success then
            loadstring(game:HttpGet(Script))()
            print("[Loader] Sucessfully loadstring!")
        else
            print("[Loader] Failed to loadstring..")
        end
    else
        print("[Loader] Invalid Path..")
    end
end

Player.Idled:Connect(function()
    if env.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

task.spawn(function()
    --> Enable Anti AFK
    env.AntiAFK = true
    print("[Loader] Auto enabled Anti AFK, you can disable Anti AFK by execute 'getgenv().AntiAFK = false'.")
    
    --> Load Hub
    Load()
end)

print("[Loader] Script successfully loaded!")
