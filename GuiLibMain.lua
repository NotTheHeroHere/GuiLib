--start gui logic
local GuiLib = {}
if not (getgenv().mainScreenGui == nil) then
    for i,v in getgenv().mainScreenGui:GetDescendants() do
        v:Destroy()
    end
end


function GuiLib.NewGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game.CoreGui
    getgenv().mainScreenGui = ScreenGui
    return ScreenGui
end
function GuiLib.NewFrame(screenGui:ScreenGui, size:UDim2, padding:UDim)
    size = size or UDim2.new(0.15, 0, 0.45, 0)
    if screenGui == nil then warn("No ScreenGui Provided!") return end
    local Frame = Instance.new("Frame")
    Frame.Parent = screenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 85, 255)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, 0.5, 0)
    Frame.Size = size
    padding = padding or UDim.new(0.05, 0)
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Frame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = padding
    padding = padding or UDim.new(0.1, 0)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = padding
    UICorner.Parent = Frame
    padding = padding or UDim.new(0.025, 0)
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = Frame
    UIPadding.PaddingBottom = padding
    UIPadding.PaddingLeft = padding
    UIPadding.PaddingRight = padding
    UIPadding.PaddingTop = padding
    local UIDragDetector = Instance.new("UIDragDetector")
    UIDragDetector.Parent = Frame
    return Frame
end

function GuiLib.NewUIListLayout(frame:Frame, padding:UDim)
    padding = padding or UDim.new(0.05, 0)
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = frame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = padding
    return UIListLayout
end

function GuiLib.NewButton(frame:Frame, size:UDim2, padding:UDim)
    size = size or UDim2.new(1, 0, 0.2, 0)
    local TextButton = Instance.new("TextButton")
    TextButton.Parent = frame
    TextButton.BackgroundColor3 = Color3.fromRGB(255, 85, 127)
    TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.BorderSizePixel = 0
    TextButton.Size = size
    TextButton.Font = Enum.Font.SourceSans
    TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.TextSize = 14.000
    padding = padding or UDim.new(0.1, 0)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = padding
    UICorner.Parent = TextButton
    return TextButton
end
function GuiLib.NewUICorner(parent, padding:UDim)
    padding = padding or UDim.new(0.1, 0)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = padding
    UICorner.Parent = parent
    return UICorner
end

function GuiLib.NewUIPadding(parent, padding:UDim)
    padding = padding or UDim.new(0.025, 0)
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = parent
    UIPadding.PaddingBottom = padding
    UIPadding.PaddingLeft = padding
    UIPadding.PaddingRight = padding
    UIPadding.PaddingTop = padding
    return UIPadding
end
function GuiLib.NewBox(frame:Frame, size:UDim2, padding:UDim)
    size = size or UDim2.new(1, 0, 0.2, 0)
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = frame
    TextBox.BackgroundColor3 = Color3.fromRGB(255, 85, 127)
    TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.BorderSizePixel = 0
    TextBox.Size = UDim2.new(1, 0, 0.200000003, 0)
    TextBox.Font = Enum.Font.SourceSans
    TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.TextSize = 14.000
    padding = padding or UDim.new(0.1, 0)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = padding
    UICorner.Parent = TextBox
    return TextBox
end

function GuiLib.NewExitButton(frame:Frame, mainScreenGui:ScreenGui, size:UDim2, padding:UDim)
    size = size or UDim2.new(1, 0, 0.2, 0)
    local TextButton = Instance.new("TextButton")
    TextButton.Parent = frame
    TextButton.BackgroundColor3 = Color3.fromRGB(255, 85, 127)
    TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.BorderSizePixel = 0
    TextButton.Size = size
    TextButton.Font = Enum.Font.SourceSans
    TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.TextSize = 14.000
    padding = padding or UDim.new(0.1, 0)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = padding
    UICorner.Parent = TextButton
    TextButton.MouseButton1Click:Connect(function()
        for i,v in mainScreenGui:GetDescendants() do
            v:Destroy()
        end
    end)
    return TextButton
end
return GuiLib
