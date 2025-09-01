--Main
local GuiLib = {}
GuiLib.__index = GuiLib
local CoreGui = if cloneref then cloneref(game:GetService("CoreGui")) else game.Players.LocalPlayer:Kick("Unsupported exploit\n\nYour executor is missing cloneref")
local UserInputService = game:GetService("UserInputService")

if getgenv().mainScreenGui ~= nil then
    for i,v in getgenv().mainScreenGui:GetDescendants() do
        v:Destroy()
    end
end
function getArgument(input, secondary)
    if input == nil then
        return secondary
    else
        return input
    end
end

function errorHandler(error)
    CoreGui:SetCore("SendNotification", {
        Title = "Error";
        Text = tostring(error);
        Duration = 5;
    })
end

--Args: none
function GuiLib.NewGui()
    local GuiTable = setmetatable({}, GuiLib)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui
    getgenv().mainScreenGui = ScreenGui
    GuiTable.Gui = ScreenGui
    return GuiTable
end
--Args: size, padding
function GuiLib:NewFrame(args:table)
    args = args or {}
    local size = getArgument(args.size, UDim2.new(0.15, 0, 0.45, 0))
    if self == nil then warn("No ScreenGui Provided!") return end
    local Frame = Instance.new("Frame")
    Frame.Parent = self.Gui
    Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, 0.5, 0)
    Frame.Size = size
    local padding = getArgument(args.padding, UDim.new(0.05, 0))
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Frame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = padding
    padding = getArgument(args.padding, UDim.new(0.1, 0))
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = padding
    UICorner.Parent = Frame
    padding = getArgument(args.padding, UDim.new(0.025, 0))
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = Frame
    UIPadding.PaddingBottom = padding
    UIPadding.PaddingLeft = padding
    UIPadding.PaddingRight = padding
    UIPadding.PaddingTop = padding
    local UIDragDetector = Instance.new("UIDragDetector")
    UIDragDetector.Parent = Frame

    local FrameObject = {}
    FrameObject.Frame = Frame
    local FrameClass = {}
    FrameClass.__index = FrameClass
    --Args: size, padding, callback
    function FrameClass:NewButton(args:table)
        args = args or {}
        local size = getArgument(args.size, UDim2.new(1, 0, 0.2, 0))
        local padding = getArgument(args.padding, UDim.new(0.1, 0))
        local TextButton = Instance.new("TextButton")
        TextButton.Parent = self.Frame
        TextButton.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextButton.BorderSizePixel = 0
        TextButton.Size = size
        TextButton.Font = Enum.Font.SourceSans
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.TextSize = 14.000
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = padding
        UICorner.Parent = TextButton
        TextButton.Activated:Connect(function()
            if args.callback then
                xpcall(args.callback, errorHandler)
            end
        end)
        return TextButton
    end
    --Args: size, padding, min, max, fillColor, callback
    function FrameClass:NewSlider(args: table)
    args = args or {}
    local size = getArgument(args.size, UDim2.new(1, 0, 0.2, 0))
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = size
    SliderFrame.BackgroundColor3 = Color3.fromRGB(16,16,16)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = self.Frame
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = getArgument(args.padding, UDim.new(0.1,0))
    UICorner.Parent = SliderFrame

    -- Fill bar
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0,0,1,0)
    Fill.BackgroundColor3 = args.fillColor or Color3.fromRGB(255,100,100)
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderFrame

    local dragging = false
    local min = getArgument(args.min, 0)
    local max = getArgument(args.max, 10)

    local function updateSlider(inputPosX)
        local mousePos = inputPosX - SliderFrame.AbsolutePosition.X
        mousePos = math.clamp(mousePos,0,SliderFrame.AbsoluteSize.X)
        Fill.Size = UDim2.new(mousePos/SliderFrame.AbsoluteSize.X,0,1,0)

        local value = min + (mousePos / SliderFrame.AbsoluteSize.X) * (max - min)
        if args.callback then
            pcall(args.callback, value)
        end
    end

    SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input.Position.X)
        end
    end)

    SliderFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    SliderFrame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
                        or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input.Position.X)
        end
    end)

    -- Also handle global movement for mobile (touch moving off the slider)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            updateSlider(input.Position.X)
        end
    end)

    return SliderFrame
    end

function FrameClass:NewToggle(args: table)
    args = args or {}
    local size = getArgument(args.size, UDim2.new(1, 0, 0.2, 0))
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = size
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(16,16,16)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = self.Frame
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = getArgument(args.padding, UDim.new(0.1,0))
    UICorner.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.5,0,1,0)
    ToggleButton.Position = UDim2.new(0,0,0,0)
    ToggleButton.BackgroundColor3 = args.offColor or Color3.fromRGB(200,0,0)
    ToggleButton.Text = args.text or "OFF"
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.TextSize = 14
    ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = ToggleFrame

    local toggled = false
    ToggleButton.Activated:Connect(function()
        toggled = not toggled
        if toggled then
            ToggleButton.BackgroundColor3 = args.onColor or Color3.fromRGB(0,200,0)
            ToggleButton.Text = "ON"
        else
            ToggleButton.BackgroundColor3 = args.offColor or Color3.fromRGB(200,0,0)
            ToggleButton.Text = "OFF"
        end
        if args.callback then
            xpcall(args.callback, errorHandler, toggled)
        end
    end)

    return ToggleFrame
    end
    --Args: size, padding, callback
    function FrameClass:NewBox(args:table)
        args = args or {}
        local size = getArgument(args.size, UDim2.new(1, 0, 0.2, 0))
        local TextBox = Instance.new("TextBox")
        TextBox.Parent = self.Frame
        TextBox.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextBox.BorderSizePixel = 0
        TextBox.Size = size
        TextBox.Font = Enum.Font.SourceSans
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.TextSize = 14.000
        local padding = getArgument(args.padding, UDim.new(0.1, 0))
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = padding
        UICorner.Parent = TextBox
        TextBox.FocusLost:Connect(function()
            xpcall(args.callback(TextBox.Text))
        end)
        return TextBox
    end
    --Args: size, padding
    function FrameClass:NewExitButton(args:table)
        args = args or {}
        local size = getArgument(args.size, UDim2.new(1, 0, 0.2, 0))
        local TextButton = Instance.new("TextButton")
        TextButton.Parent = self
        TextButton.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextButton.BorderSizePixel = 0
        TextButton.Size = size
        TextButton.Font = Enum.Font.SourceSans
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.TextSize = 14.000
        local padding = getArgument(args.padding, UDim.new(0.1, 0))
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = padding
        UICorner.Parent = TextButton
        TextButton.Activated:Connect(function()
            pcall(function()
                for i,v in getgenv().mainScreenGui:GetDescendants() do
                    v:Destroy()
                end
            end)
        end)
        return TextButton
    end
    
    local FrameTable = setmetatable(FrameObject, FrameClass)
    
    return FrameTable
end

return GuiLib
