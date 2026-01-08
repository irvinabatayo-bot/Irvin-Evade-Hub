pcall(function()

-- CLEANUP
if game.CoreGui:FindFirstChild("IrvinEvadeHub") then
    game.CoreGui.IrvinEvadeHub:Destroy()
end

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Player = Players.LocalPlayer

-- GUI ROOT
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "IrvinEvadeHub"
Gui.ResetOnSpawn = false

-- MAIN FRAME
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromScale(0.34,0.46)
Main.Position = UDim2.fromScale(0.33,0.27)
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.Active = true
Main.Draggable = true
local mainCorner = Instance.new("UICorner", Main)
mainCorner.CornerRadius = UDim.new(0,24)

-- Rainbow outline for main frame
local Outline = Instance.new("UIStroke", Main)
Outline.Thickness = 4
Outline.Transparency = 0
Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function()
    local h = 0
    while Outline.Parent do
        h = (h + 0.004) % 1
        Outline.Color = Color3.fromHSV(h,1,1)
        task.wait()
    end
end)

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.fromScale(0.9,0.12)
Title.Position = UDim2.fromScale(0.05,0.04)
Title.BackgroundTransparency = 1
Title.Text = "IRVIN HUB | EVADE"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true

-- Rainbow title
task.spawn(function()
    local h=0
    while Title.Parent do
        h=(h+0.008)%1
        Title.TextColor3 = Color3.fromHSV(h,1,1)
        task.wait()
    end
end)

-- BUTTON CREATOR
local function createButton(text,y)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.fromScale(0.9,0.11)
    b.Position = UDim2.fromScale(0.05,y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,18)
    return b
end

-- TOP RIGHT BUTTONS
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.fromScale(0.08,0.08)
MinBtn.Position = UDim2.fromScale(0.86,0.02)
MinBtn.Text = "—"
MinBtn.Font = Enum.Font.GothamBlack
MinBtn.TextScaled = true
MinBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", MinBtn)

local ExitBtn = Instance.new("TextButton", Main)
ExitBtn.Size = UDim2.fromScale(0.08,0.08)
ExitBtn.Position = UDim2.fromScale(0.93,0.02)
ExitBtn.Text = "X"
ExitBtn.Font = Enum.Font.GothamBlack
ExitBtn.TextScaled = true
ExitBtn.BackgroundColor3 = Color3.fromRGB(120,40,40)
Instance.new("UICorner", ExitBtn)

-- MAIN BUTTONS
local ShowAJBtn = createButton("Show Auto Jump Button",0.22)
local BoostFPSBtn = createButton("Boost FPS",0.35)
local AutoWinBtn = createButton("Auto Win : OFF",0.48)

-- Rainbow effect for buttons
local function rainbowButton(btn)
    task.spawn(function()
        local h = 0
        while btn.Parent do
            h = (h + 0.008) % 1
            btn.BackgroundColor3 = Color3.fromHSV(h,1,0.8)
            task.wait()
        end
    end)
end

for _,btn in ipairs({ShowAJBtn, BoostFPSBtn, AutoWinBtn}) do
    rainbowButton(btn)
end

-- IH LOGO
local Logo = Instance.new("TextButton", Gui)
Logo.Size = UDim2.fromScale(0.1,0.08)
Logo.Position = UDim2.fromScale(0.02,0.4)
Logo.Text = "IH"
Logo.Font = Enum.Font.GothamBlack
Logo.TextScaled = true
Logo.Visible = false
Logo.Active = true
Logo.Draggable = true
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1,0)
task.spawn(function()
    local h=0
    while Logo.Parent do
        h=(h+0.02)%1
        Logo.TextColor3 = Color3.fromHSV(h,1,1)
        task.wait()
    end
end)

-- AUTO JUMP BUTTON
local AJBtn = Instance.new("TextButton", Gui)
AJBtn.Size = UDim2.fromScale(0.18,0.08)
AJBtn.Position = UDim2.fromScale(0.4,0.6)
AJBtn.Text = "AUTO JUMP : OFF"
AJBtn.Font = Enum.Font.GothamBold
AJBtn.TextScaled = true
AJBtn.BackgroundColor3 = Color3.fromRGB(30,30,35)
AJBtn.Visible = false
AJBtn.Active = true
AJBtn.Draggable = true
Instance.new("UICorner", AJBtn)

-- Rainbow Auto Jump
task.spawn(function()
    local h = 0
    while AJBtn.Parent do
        h = (h + 0.01)%1
        AJBtn.TextColor3 = Color3.fromHSV(h,1,1)
        task.wait()
    end
end)

-- AUTO JUMP LOGIC
local AutoJump = false
local JumpCD = false
RunService.Heartbeat:Connect(function()
    if AutoJump then
        local c = Player.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h and h.FloorMaterial ~= Enum.Material.Air and not JumpCD then
            JumpCD = true
            h:ChangeState(Enum.HumanoidStateType.Jumping)
            task.delay(0.18,function() JumpCD=false end)
        end
    end
end)

ShowAJBtn.MouseButton1Click:Connect(function()
    AJBtn.Visible = not AJBtn.Visible
end)

AJBtn.MouseButton1Click:Connect(function()
    AutoJump = not AutoJump
    AJBtn.Text = "AUTO JUMP : "..(AutoJump and "ON" or "OFF")
end)

-- SURVIVING TIMER
local Overlay = Instance.new("TextLabel", Gui)
Overlay.Size = UDim2.fromScale(0.18,0.055)
Overlay.Position = UDim2.fromScale(0.41,0.04)
Overlay.BackgroundColor3 = Color3.fromRGB(15,15,15)
Overlay.BackgroundTransparency = 0.15
Overlay.TextScaled = true
Overlay.Font = Enum.Font.GothamBlack
Overlay.Visible = false
Instance.new("UICorner", Overlay)

task.spawn(function()
    local h=0
    while Overlay.Parent do
        h=(h+0.01)%1
        Overlay.TextColor3 = Color3.fromHSV(h,1,1)
        task.wait()
    end
end)

local TimerVisible = true
local StartTime
local TimerConn

-- AUTO WIN
local AutoWin = false
local SafePart
local AutoWinConn

local function startAutoWin()
    SafePart = Instance.new("Part",workspace)
    SafePart.Anchored=true
    SafePart.Size=Vector3.new(40,2,40)
    SafePart.Transparency=1
    SafePart.Position=Vector3.new(0,10000,0)

    AutoWinConn=RunService.Heartbeat:Connect(function()
        local c=Player.Character
        local hrp=c and c:FindFirstChild("HumanoidRootPart")
        local h=c and c:FindFirstChildOfClass("Humanoid")
        if hrp and h then
            h:ChangeState(Enum.HumanoidStateType.Physics)
            hrp.CFrame=SafePart.CFrame+Vector3.new(0,3,0)
            hrp.AssemblyLinearVelocity=Vector3.zero
        end
    end)

    StartTime=os.clock()
    Overlay.Visible=true

    TimerConn=RunService.Heartbeat:Connect(function()
        if TimerVisible then
            Overlay.Visible=true
            Overlay.Text="SURVIVING: "..math.floor(os.clock()-StartTime).."s"
        else
            Overlay.Visible=false
        end
    end)
end

local function stopAutoWin()
    if AutoWinConn then AutoWinConn:Disconnect() end
    if TimerConn then TimerConn:Disconnect() end
    if SafePart then SafePart:Destroy() end
    Overlay.Visible=false
end

AutoWinBtn.MouseButton1Click:Connect(function()
    AutoWin = not AutoWin
    AutoWinBtn.Text = "Auto Win : "..(AutoWin and "ON" or "OFF")
    if AutoWin then startAutoWin() else stopAutoWin() end
end)

-- BOOST FPS WITH PROGRESS BAR
BoostFPSBtn.MouseButton1Click:Connect(function()
    local Progress = Instance.new("Frame", Gui)
    Progress.Size = UDim2.fromScale(0,0.04)
    Progress.Position = UDim2.fromScale(0.35,0.92)
    Progress.BackgroundColor3 = Color3.fromRGB(50,255,50)
    Instance.new("UICorner", Progress)
    local BG = Instance.new("Frame", Gui)
    BG.Size = UDim2.fromScale(0.3,0.04)
    BG.Position = UDim2.fromScale(0.35,0.92)
    BG.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", BG)

    for i = 1,100 do
        Progress.Size = UDim2.fromScale(0.3*(i/100),0.04)
        task.wait(0.01)
    end
    -- Reduce lag
    Lighting.GlobalShadows=false
    Lighting.FogEnd=1e6
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled=false
        end
    end
    task.wait(0.5)
    Progress:Destroy()
    BG:Destroy()
end)

-- Minimize/Logo
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible=false
    Logo.Visible=true
end)

Logo.MouseButton1Click:Connect(function()
    Main.Visible=true
    Logo.Visible=false
end)

-- EXIT CONFIRMATION
ExitBtn.MouseButton1Click:Connect(function()
    local box = Instance.new("Frame", Gui)
    box.Size = UDim2.fromScale(0.32,0.18)
    box.Position = UDim2.fromScale(0.34,0.41)
    box.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", box)

    local txt = Instance.new("TextLabel", box)
    txt.Size = UDim2.fromScale(1,0.55)
    txt.BackgroundTransparency = 1
    txt.Text = "Exit Irvin Hub?"
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.TextColor3 = Color3.fromRGB(255,255,255)

    local yes = Instance.new("TextButton", box)
    yes.Size = UDim2.fromScale(0.4,0.3)
    yes.Position = UDim2.fromScale(0.05,0.62)
    yes.Text = "YES"
    yes.Font = Enum.Font.GothamBold
    yes.TextScaled = true
    yes.BackgroundColor3 = Color3.fromRGB(40,120,40)
    Instance.new("UICorner", yes)

    local no = Instance.new("TextButton", box)
    no.Size = UDim2.fromScale(0.4,0.3)
    no.Position = UDim2.fromScale(0.55,0.62)
    no.Text = "NO"
    no.Font = Enum.Font.GothamBold
    no.TextScaled = true
    no.BackgroundColor3 = Color3.fromRGB(120,40,40)
    Instance.new("UICorner", no)

    yes.MouseButton1Click:Connect(function()
        Gui:Destroy()
    end)
    no.MouseButton1Click:Connect(function()
        box:Destroy()
    end)
end)

end)
