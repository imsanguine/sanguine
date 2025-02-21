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

--> Variables <--
local env = getgenv()

--> Utils <--
local Utils = {}

function Utils:IsAlive(Character: Model)
    return (Character and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0) or false
end

function Utils:GetEnemy(EnemyFolder: Folder, Enemy_Name: string)
    if EnemyFolder and Enemy_Name then
        local Enemy = EnemyFolder:FindFirstChild(Enemy_Name)
        if self:IsAlive(Enemy) then
            return Enemy
        end
        for _, Enemy in ipairs(EnemyFolder:GetChildren()) do
            if (not Enemy_Name or Enemy_Name == Enemy.Name) and self:IsAlive(Enemy) then
                return Enemy
            end
        end
        return false
    end
    return false
end

function Utils:GetFarmCFrame(Side, Distance)
    if Side == "Over" then
        return CFrame.new(0, Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    elseif Side == "Under" then
        return CFrame.new(0, -Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    elseif Side == "Behind" then
        return CFrame.new(0, 0, Distance)
    end
end

function Utils:TeleportTo(CFrame: CFrame, Move: boolean)
    local Character: Model = Player.Character
    return self:IsAlive(Character) and (Move and Character:MoveTo(CFrame.p) or Character:SetPrimaryPartCFrame(CFrame))
end

function Utils:Click()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new())
end

function Utils:Press(Key: Enum.KeyCode)
    VirtualInputManager:SendKeyEvent(true, Key, false, game)
    VirtualInputManager:SendKeyEvent(false, Key, false, game)
end

function Utils:FireProximityPrompt(ProximityPrompt: ProximityPrompt)
    ProximityPrompt:InputHoldBegin()
    delay(ProximityPrompt.HoldDuration, function()
        ProximityPrompt:InputHoldEnd()
    end)
end

function Utils:EquipWeapon(Tool_Name: string)
    local Character = Player.Character
    if self:IsAlive(Character) and Tool_Name then
        local Character_Tool = Character:FindFirstChildOfClass("Tool")
        if not Character_Tool or Character_Tool.Name ~= Tool_Name then
            for _, Tool in ipairs(Player.Backpack:GetChildren()) do
                if Tool:IsA("Tool") and Tool.Name == Tool_Name then
                    return Character.Humanoid:EquipTool(Tool)
                end
            end
        end
    end
end

function Utils:ActivateTool()
    local Character = Player.Character
    if self:IsAlive(Character) then
        local Character_Tool = Character:FindFirstChildOfClass("Tool")
        if Character_Tool then
            return Character_Tool:Activate()
        end
    end
end

return Utils
