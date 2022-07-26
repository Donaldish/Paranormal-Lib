--- Example List
loadstring(game:HttpGet("https://raw.githubusercontent.com/Donaldish/Paranormal-Lib/main/Supported-Games.lua"))()

--- Configurable settings for the inside of the GUI library.
local guiConfig = {
	versionNumber = "1.0.0", -- The current version of the gui

	--- Changelog text: \n for new line, \" for double quotes, \[ for left squard bracket, and \] for right square bracket
	changelogText = "-Created a UI Library\n\n-Made game scripts\n\n-Crying myself to sleep at night", 

	keybind = Enum.KeyCode.RightControl, -- The open and close gui keybind. Default: Enum.KeyCode.RightControl
};

--- Variables inside of the GUI library itself. Do not change anything here.
local guiInternalConfig = {
	GuiPos = UDim2.new(0.309, 0, 0.283, 0), -- The last saved position of the gui before it was minimzed.

	GuiMaximized = true, -- Determines wether the gui is minimized or not.
	CanMinimize = true, -- Disables minimizing and maximizing the gui while the GuiMaximized value gets changed.

	GuiClosed = false, -- Determines wether the gui is closed or not.
	CanOpenClose = true, -- Disables opening and closing the gui while the GuiClosed value gets changed.
}


--- Main Gui handler.
local Library = {}


-- Functions

--- Allows a frame to be dragged.
---@param frame boolean The target frame.
function Library:dragify(frame)
	dragToggle = nil
	local dragSpeed = 0
	local dragInput = nil
	local dragStart = nil
	local dragPos = nil
	local function updateInput(input)
		local Delta = input.Position - dragStart
		---@diagnostic disable-next-line: undefined-global
		local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(frame, TweenInfo.new(0.25), {Position = Position}):Play()
	end
	frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and game:GetService("UserInputService"):GetFocusedTextBox() == nil then
			dragToggle = true
			dragStart = input.Position
			---@diagnostic disable-next-line: undefined-global
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			updateInput(input)
		end
	end)
end

--- Checks if the game's place ID was found in a table.
---@param gameList table A list of PlaceIDs.
---@return boolean
function Library:isGameSupported(gameList)
	for k, v in ipairs(gameList) do
		if v == game.PlaceId or (type(v) == "table") then
			return true
		end
	end
	return false
end

--- Sends a notification using Roblox's StarterGui:Setcore.
---@param title string Name of the notification
---@param desc string Description of the notification
---@param time number How long the notification lasts
function Library:Notify(title, desc, imgid, time)
	if imgid == nil then imgid = 274183391 end
	game.StarterGui:SetCore("SendNotification", {
		Title = title;
		Text = desc;
		Icon = ("rbxassetid://".. tostring(imgid));
		Duration = time;
	})
end

function Library:discordInvite(invcode)
    if syn then 
		self:Notify("Discord Invite", "Successfully prompted to join.", nil, 5)
        syn.request({Url = "http://127.0.0.1:6463/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["origin"] = "https://discord.com",},Body = game:GetService("HttpService"):JSONEncode({["args"] = {["code"] = invcode,},["cmd"] = "INVITE_BROWSER",["nonce"] = "a"})}) 
    else 
		self:Notify("Discord Invite", "Successfully copied to clipboard.", nil, 5)
        setclipboard("https://discord.gg/".. invcode)
    end
end

--- Sends a notification using Roblox's StarterGui:Setcore.
---@param title string Name of the notification
---@param desc string Description of the notification
---@param imgid number The 
---@param time number How long the notification lasts
---@param option1 string Option one of the notification
---@param option2 string Option two of the notification
---@param callback function The function of the notification when an option is selected. 
--- Option1 is true, Option2 is false.
function Library:NotifyOptions(title, desc, imgid, time, option1, option2, callback)
	if imgid == nil then imgid = 274183391 end
	local bindf = Instance.new("BindableFunction")
	bindf.OnInvoke = function(answer) if answer == option1 then callback(true) elseif answer == option2 then callback(false) end end
	game.StarterGui:SetCore("SendNotification", {
		Title = title;
		Text = desc;
		Icon = ("rbxassetid://".. tostring(imgid));
		Duration = time;
		Button1 = option1;
		Button2 = option2;
		Callback = bindf
	})
end

--- Creates the actual UI.
function Library:CreateMain()
	if game.CoreGui:FindFirstChild("ParanormalUI") then
		game.CoreGui:FindFirstChild("ParanormalUI"):Destroy()
  	end
	self:Notify("Paranormal Hub", string.format("Loaded in successfully!\nUse RightCtrl to toggle."), nil, 5)
	-- hhghg
	local GUI = Instance.new("ScreenGui")
	local Dragify = Instance.new("Frame")
	local BaseUI = Instance.new("Folder")
	local Top = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Back = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local Side = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local Seperator = Instance.new("Frame")
	local Bottom = Instance.new("Frame")
	local logo = Instance.new("ImageLabel")
	local Text2 = Instance.new("TextLabel")
	local Text = Instance.new("TextLabel")
	local UICorner_4 = Instance.new("UICorner")
	local Main = Instance.new("Frame")
	local Pages = Instance.new("Folder")
	local Welcome = Instance.new("ScrollingFrame")
	local Logo = Instance.new("Frame")
	local logo_2 = Instance.new("ImageLabel")
	local TextLabel = Instance.new("TextLabel")
	local TextLabel_2 = Instance.new("TextLabel")
	local Changelog = Instance.new("Frame")
	local Label = Instance.new("Frame")
	local Label_2 = Instance.new("TextLabel")
	local Changes = Instance.new("TextLabel")
	local UIListLayout = Instance.new("UIListLayout")
	local Support = Instance.new("ScrollingFrame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local Warning = Instance.new("TextLabel")
	local SupportedGames = Instance.new("ScrollingFrame")
	local Label_3 = Instance.new("TextLabel")
	local Line = Instance.new("TextLabel")
	local UIListLayout_4 = Instance.new("UIListLayout")
	local TextButton_3 = Instance.new("TextButton")
	local Sidebar = Instance.new("ScrollingFrame")
	local UIListLayout_5 = Instance.new("UIListLayout")
	local UIPadding_2 = Instance.new("UIPadding")
	local Welcome_2 = Instance.new("TextButton")
	local Image = Instance.new("ImageLabel")
	local Text_2 = Instance.new("TextLabel")
	local UICorner_5 = Instance.new("UICorner")
	local Support_2 = Instance.new("TextButton")
	local Image_2 = Instance.new("ImageLabel")
	local Text_3 = Instance.new("TextLabel")
	local UICorner_6 = Instance.new("UICorner")
	local Divider = Instance.new("Frame")
	local Close = Instance.new("TextButton")
	local UICorner_8 = Instance.new("UICorner")
	local MinMax = Instance.new("TextButton")
	local UICorner_9 = Instance.new("UICorner")

	--Properties:
	GUI.Name = "ParanormalUI"
	GUI.Parent = game.CoreGui
	GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Dragify.Name = "Dragify"
	Dragify.Parent = GUI
	Dragify.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Dragify.BackgroundTransparency = 1.000
	Dragify.Position = UDim2.new(0.309318721, 0, 0.283065528, 0)
	Dragify.Size = UDim2.new(0, 600, 0, 35)
	BaseUI.Name = "BaseUI"
	BaseUI.Parent = Dragify
	Top.Name = "Top"
	Top.Parent = BaseUI
	Top.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Top.Size = UDim2.new(0, 600, 0, 35)
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Top
	Back.Name = "Back"
	Back.Parent = BaseUI
	Back.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	Back.Position = UDim2.new(-0, 0, 0.625999987, 0)
	Back.Size = UDim2.new(0, 600, 0, 288)
	UICorner_2.CornerRadius = UDim.new(0, 10)
	UICorner_2.Parent = Back
	Side.Name = "Side"
	Side.Parent = Back
	Side.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
	Side.BorderSizePixel = 0
	Side.Size = UDim2.new(0, 100, 1, 0)
	UICorner_3.CornerRadius = UDim.new(0, 10)
	UICorner_3.Parent = Side
	Seperator.Name = "Seperator"
	Seperator.Parent = Side
	Seperator.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Seperator.BorderSizePixel = 0
	Seperator.Position = UDim2.new(0, 95, 0, 0)
	Seperator.Size = UDim2.new(0, 5, 1, 0)
	Bottom.Name = "Bottom"
	Bottom.Parent = BaseUI
	Bottom.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Bottom.BorderSizePixel = 0
	Bottom.Position = UDim2.new(-0, 0, 0.625999987, 0)
	Bottom.Size = UDim2.new(0, 600, 0, 13)
	logo.Name = "logo"
	logo.Parent = BaseUI
	logo.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
	logo.BorderSizePixel = 0
	logo.Position = UDim2.new(0.192943633, 0, 0.0981955677, 0)
	logo.Size = UDim2.new(0, 47, 0, 27)
	logo.Image = "rbxassetid://0"
	logo.ImageColor3 = Color3.fromRGB(255, 153, 0)
	logo.ScaleType = Enum.ScaleType.Slice
	logo.SliceCenter = Rect.new(100, 100, 100, 100)
	logo.SliceScale = 0.120
	Text2.Name = "Text2"
	Text2.Parent = logo
	Text2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text2.BackgroundTransparency = 1.000
	Text2.BorderSizePixel = 0
	Text2.Position = UDim2.new(0.00239205873, 0, -0.00674874429, 0)
	Text2.Size = UDim2.new(0, 49, 0, 29)
	Text2.Font = Enum.Font.ArialBold
	Text2.Text = "Hub"
	Text2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Text2.TextSize = 20.000
	Text2.TextStrokeTransparency = 0.900
	Text2.TextWrapped = true
	Text.Name = "Text"
	Text.Parent = logo
	Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text.BackgroundTransparency = 1.000
	Text.BorderSizePixel = 0
	Text.Position = UDim2.new(-2.5062685, 0, 0.019404659, 0)
	Text.Size = UDim2.new(0, 126, 0, 29)
	Text.Font = Enum.Font.ArialBold
	Text.Text = "Paranormal"
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextSize = 20.000
	Text.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextStrokeTransparency = 0.900
	Text.TextWrapped = true
	UICorner_4.Parent = logo
	Main.Name = "Main"
	Main.Parent = Dragify
	Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Main.BackgroundTransparency = 1.000
	Main.BorderSizePixel = 0
	Main.Size = UDim2.new(1, 0, 1, 0)
	Pages.Name = "Pages"
	Pages.Parent = Main
	Welcome.Name = "Welcome"
	Welcome.Parent = Pages
	Welcome.Active = true
	Welcome.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Welcome.BackgroundTransparency = 1.000
	Welcome.BorderSizePixel = 0
	Welcome.Position = UDim2.new(0.166999996, 0, 0.996999979, 0)
	Welcome.Size = UDim2.new(0, 500, 0, 275)
	Welcome.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	Welcome.ScrollBarThickness = 0
	Welcome.ScrollingEnabled = false
	Logo.Name = "!Logo"
	Logo.Parent = Welcome
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(0.224999994, 0, 0.0547169819, 0)
	Logo.Size = UDim2.new(0, 279, 0, 51)
	logo_2.Name = "logo"
	logo_2.Parent = Logo
	logo_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	logo_2.BackgroundTransparency = 1.000
	logo_2.Position = UDim2.new(0.707886815, 0, -0.0156854372, 0)
	logo_2.Size = UDim2.new(0, 79, 0, 46)
	logo_2.Image = "rbxassetid://3570695787"
	logo_2.ImageColor3 = Color3.fromRGB(255, 153, 0)
	logo_2.ScaleType = Enum.ScaleType.Slice
	logo_2.SliceCenter = Rect.new(100, 100, 100, 100)
	logo_2.SliceScale = 0.120
	TextLabel.Parent = logo_2
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(-0.0129756927, 0, -0.00666666031, 0)
	TextLabel.Size = UDim2.new(0, 82, 0, 50)
	TextLabel.Font = Enum.Font.ArialBold
	TextLabel.Text = "Hub"
	TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.TextSize = 37.000
	TextLabel.TextStrokeTransparency = 0.900
	TextLabel.TextWrapped = true
	TextLabel_2.Parent = logo_2
	TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.BackgroundTransparency = 1.000
	TextLabel_2.BorderSizePixel = 0
	TextLabel_2.Position = UDim2.new(-2.61189818, 0, 0.020000292, 0)
	TextLabel_2.Size = UDim2.new(0, 206, 0, 50)
	TextLabel_2.Font = Enum.Font.ArialBold
	TextLabel_2.Text = "Paranormal"
	TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.TextSize = 37.000
	TextLabel_2.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.TextStrokeTransparency = 0.900
	TextLabel_2.TextWrapped = true
	Changelog.Name = "Changelog"
	Changelog.Parent = Welcome
	Changelog.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	Changelog.BorderColor3 = Color3.fromRGB(54, 54, 54)
	Changelog.Position = UDim2.new(0.289999992, 0, 0.243902445, 0)
	Changelog.Size = UDim2.new(0, 276, 0, 170)
	Label.Name = "Label"
	Label.Parent = Changelog
	Label.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Label.BorderColor3 = Color3.fromRGB(54, 54, 54)
	Label.Size = UDim2.new(0, 276, 0, 15)
	Label_2.Name = "Label"
	Label_2.Parent = Label
	Label_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label_2.BackgroundTransparency = 1.000
	Label_2.BorderSizePixel = 0
	Label_2.Size = UDim2.new(1, 0, 1, 0)
	Label_2.Font = Enum.Font.Arial
	Label_2.Text = ("v".. guiConfig.versionNumber)
	Label_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label_2.TextSize = 12.000
	Label_2.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Changes.Name = "Changes"
	Changes.Parent = Changelog
	Changes.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Changes.BackgroundTransparency = 1.000
	Changes.BorderSizePixel = 0
	Changes.Position = UDim2.new(0, 0, 0.135411695, 0)
	Changes.Size = UDim2.new(1, 0, -0.0294117648, 152)
	Changes.Font = Enum.Font.Arial
	Changes.Text = string.format(guiConfig.changelogText)
	Changes.TextColor3 = Color3.fromRGB(255, 255, 255)
	Changes.TextSize = 12.000
	Changes.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Changes.TextWrapped = true
	Changes.TextYAlignment = Enum.TextYAlignment.Top
	UIListLayout.Parent = Welcome
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.Name
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 15)
	Support.Name = "Support"
	Support.Parent = Pages
	Support.Active = true
	Support.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Support.BackgroundTransparency = 1.000
	Support.BorderSizePixel = 0
	Support.Position = UDim2.new(0.166999996, 0, 0.996999979, 0)
	Support.Size = UDim2.new(0, 500, 0, 275)
	Support.Visible = false
	Support.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	Support.ScrollBarThickness = 0
	Support.ScrollingEnabled = false
	UIListLayout_3.Parent = Support
	UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout_3.Padding = UDim.new(0, 15)
	Warning.Name = "Warning"
	Warning.Parent = Support
	Warning.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Warning.BackgroundTransparency = 1.000
	Warning.BorderSizePixel = 0
	Warning.Position = UDim2.new(0, 0, 0.0431034453, 0)
	Warning.Size = UDim2.new(0, 450, 0, 27)
	Warning.Font = Enum.Font.GothamBold
	Warning.Text = "Loading.."
	Warning.TextColor3 = Color3.fromRGB(255, 255, 255)
	Warning.TextSize = 16.000
	Warning.TextScaled = true
	Warning.TextStrokeTransparency = 0.000
	Warning.TextWrapped = true
	SupportedGames.Name = "SupportedGames"
	SupportedGames.Parent = Support
	SupportedGames.Active = true
	SupportedGames.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	SupportedGames.BorderColor3 = Color3.fromRGB(54, 54, 54)
	SupportedGames.Position = UDim2.new(0.166666672, 0, 0.258620679, 0)
	SupportedGames.Size = UDim2.new(0, 300, 0, 150)
	Label_3.Name = "Label"
	Label_3.Parent = SupportedGames
	Label_3.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Label_3.BackgroundTransparency = 1.000
	Label_3.BorderColor3 = Color3.fromRGB(54, 54, 54)
	Label_3.Size = UDim2.new(0, 300, 0, 25)
	Label_3.Font = Enum.Font.SourceSans
	Label_3.Text = "Games List"
	Label_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label_3.TextSize = 14.000
	Label_3.TextStrokeTransparency = 0.800
	Line.Name = "Line"
	Line.Parent = Label_3
	Line.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
	Line.BorderColor3 = Color3.fromRGB(54, 54, 54)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 1, 0)
	Line.Size = UDim2.new(1, 0, 0, 1)
	Line.Font = Enum.Font.SourceSans
	Line.Text = ""
	Line.TextColor3 = Color3.fromRGB(0, 0, 0)
	Line.TextSize = 14.000
	UIListLayout_4.Parent = SupportedGames
	UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_4.Padding = UDim.new(0, 3)
	TextButton_3.Parent = Support
	TextButton_3.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
	TextButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextButton_3.Position = UDim2.new(0.34799999, 0, 0.862264156, 0)
	TextButton_3.Size = UDim2.new(0, 150, 0, 20)
	TextButton_3.Font = Enum.Font.Gotham
	TextButton_3.Text = "Discord Server"
	TextButton_3.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton_3.TextSize = 14.000
	Sidebar.Name = "Sidebar"
	Sidebar.Parent = Main
	Sidebar.Active = true
	Sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Sidebar.BackgroundTransparency = 1.000
	Sidebar.BorderSizePixel = 0
	Sidebar.Position = UDim2.new(0, 0, 0.996999979, 0)
	Sidebar.Size = UDim2.new(0, 95, 0, 275)
	--Sidebar.CanvasSize = UDim2.new(0, 0, 1, 0)
	Sidebar.ScrollBarThickness = 2
	UIListLayout_5.Parent = Sidebar
	UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_5.Padding = UDim.new(0, 5)
	UIPadding_2.Parent = Sidebar
	UIPadding_2.PaddingTop = UDim.new(0, 5)
	Welcome_2.Name = "Welcome"
	Welcome_2.Parent = Sidebar
	Welcome_2.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	Welcome_2.BorderSizePixel = 0
	Welcome_2.Position = UDim2.new(0.0526315793, 0, 0, 0)
	Welcome_2.Size = UDim2.new(0, 85, 0, 30)
	Welcome_2.Font = Enum.Font.SourceSans
	Welcome_2.Text = ""
	Welcome_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Welcome_2.TextSize = 14.000
	Image.Name = "Image"
	Image.Parent = Welcome_2
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.BackgroundTransparency = 1.000
	Image.BorderSizePixel = 0
	Image.Position = UDim2.new(0, 5, 0, 5)
	Image.Size = UDim2.new(0, 20, 0, 20)
	Image.Image = "rbxassetid://6034798461"
	Text_2.Name = "Text"
	Text_2.Parent = Welcome_2
	Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text_2.BackgroundTransparency = 1.000
	Text_2.Position = UDim2.new(0.36499992, 0, 0, 5)
	Text_2.Size = UDim2.new(0, 55, 0, 20)
	Text_2.Font = Enum.Font.SourceSans
	Text_2.Text = "Welcome"
	Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text_2.TextSize = 14.000
	Text_2.TextWrapped = true
	Text_2.TextXAlignment = Enum.TextXAlignment.Left
	UICorner_5.Parent = Welcome_2
	Support_2.Name = "Support"
	Support_2.Parent = Sidebar
	Support_2.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	Support_2.BorderSizePixel = 0
	Support_2.Position = UDim2.new(0.0526315793, 0, 0, 0)
	Support_2.Size = UDim2.new(0, 85, 0, 30)
	Support_2.Font = Enum.Font.SourceSans
	Support_2.Text = ""
	Support_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Support_2.TextSize = 14.000
	Image_2.Name = "Image"
	Image_2.Parent = Support_2
	Image_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image_2.BackgroundTransparency = 1.000
	Image_2.BorderSizePixel = 0
	Image_2.Position = UDim2.new(0, 5, 0, 5)
	Image_2.Size = UDim2.new(0, 20, 0, 20)
	Image_2.Image = "rbxassetid://8099668652"
	Text_3.Name = "Text"
	Text_3.Parent = Support_2
	Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text_3.BackgroundTransparency = 1.000
	Text_3.Position = UDim2.new(0.36499992, 0, 0, 5)
	Text_3.Size = UDim2.new(0, 55, 0, 20)
	Text_3.Font = Enum.Font.SourceSans
	Text_3.Text = "Support"
	Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text_3.TextSize = 14.000
	Text_3.TextWrapped = true
	Text_3.TextXAlignment = Enum.TextXAlignment.Left
	UICorner_6.Parent = Support_2
	Divider.Name = "Divider"
	Divider.Parent = Sidebar
	Divider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Divider.Position = UDim2.new(-0.0263157897, 0, 0.134615391, 0)
	Divider.Size = UDim2.new(1, 0, 0, 1)
	Close.Name = "Close"
	Close.Parent = Dragify
	Close.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
	Close.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(0.943333328, 0, 0.0857138485, 0)
	Close.Size = UDim2.new(0, 27, 0, 27)
	Close.Font = Enum.Font.GothamBold
	Close.Text = "X"
	Close.TextColor3 = Color3.fromRGB(0, 0, 0)
	Close.TextSize = 22.000
	Close.TextWrapped = true
	UICorner_8.Parent = Close
	MinMax.Name = "MinMax"
	MinMax.Parent = Dragify
	MinMax.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
	MinMax.BorderColor3 = Color3.fromRGB(27, 42, 53)
	MinMax.BorderSizePixel = 0
	MinMax.Position = UDim2.new(0.888333321, 0, 0.0857138485, 0)
	MinMax.Size = UDim2.new(0, 27, 0, 27)
	MinMax.Font = Enum.Font.GothamBold
	MinMax.Text = "-"
	MinMax.TextColor3 = Color3.fromRGB(0, 0, 0)
	MinMax.TextSize = 32.000
	MinMax.TextWrapped = true
	UICorner_9.Parent = MinMax


	--Scripting

	--- Shows if the game is supported inside of the support page
	if self:isGameSupported(getgenv().SupportedGames) then
		Warning.Text = string.format("Support & Games List\nThis current game is supported!")
	else
		Warning.Text = string.format("Support & Games List\nThis game is not supported.")
	end

	--- Creates the games list in the support page.
	for _,v in pairs(getgenv().SupportedGames) do
		local Game = Instance.new("TextLabel")
		local TextButton = Instance.new("TextButton")
		local TextButton_2 = Instance.new("TextButton")
		Game.Name = "Game"
		Game.Parent = SupportedGames
		Game.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
		Game.BackgroundTransparency = 1.000
		Game.BorderColor3 = Color3.fromRGB(54, 54, 54)
		Game.BorderSizePixel = 0
		Game.Position = UDim2.new(0, 0, 0.199666753, 0)
		Game.Size = UDim2.new(0, 300, 0, 18)
		Game.Font = Enum.Font.SourceSans
		Game.Text = "   ".. game:GetService("MarketplaceService"):GetProductInfo(v).Name
		Game.TextColor3 = Color3.fromRGB(255, 255, 255)
		Game.TextSize = 14.000
		Game.TextStrokeTransparency = 0.800
		Game.TextXAlignment = Enum.TextXAlignment.Left
		Game.TextYAlignment = Enum.TextYAlignment.Top
		TextButton.Parent = Game
		TextButton.Name = "Join".. v
		TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.Position = UDim2.new(0.843333304, 0, 0.166666672, 0)
		TextButton.Size = UDim2.new(0, 30, 0, 11)
		TextButton.Font = Enum.Font.SourceSans
		TextButton.Text = "Join"
		TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.TextSize = 12.000
		TextButton_2.Parent = Game
		TextButton_2.Name = "Copy".. v
		TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton_2.Position = UDim2.new(0.653333306, 0, 0.166666672, 0)
		TextButton_2.Size = UDim2.new(0, 51, 0, 11)
		TextButton_2.Font = Enum.Font.SourceSans
		TextButton_2.Text = "Copy Link"
		TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextButton_2.TextSize = 12.000
		TextButton.MouseButton1Down:connect(function()
			game:GetService("TeleportService"):Teleport(tonumber(v), game:GetService("Players").LocalPlayer)
		end)
		TextButton_2.MouseButton1Down:connect(function()
			setclipboard("https://www.roblox.com/games/".. v)
		end)
	end

	--- Dragifiys the actual gui.
	self:dragify(Dragify)

	--- Minimizes/unminimizes the Gui when you press the keybind.
	game:GetService("UserInputService").InputBegan:Connect(function(key, gp)
		if key.KeyCode == guiConfig.keybind then
			if game:GetService("UserInputService"):GetFocusedTextBox() == nil then
				if guiInternalConfig.GuiClosed == false and guiInternalConfig.CanOpenClose and dragToggle ~= true then
					guiInternalConfig.GuiClosed = true
					guiInternalConfig.CanOpenClose = false
					guiInternalConfig.GuiPos = Dragify.Position
					Dragify:TweenPosition(UDim2.new(-1,0,-1,0),Enum.EasingDirection.In,Enum.EasingStyle.Sine,0.3,false)
					Dragify.Visible = false
					task.wait(0.3)
					guiInternalConfig.CanOpenClose = true
				elseif guiInternalConfig.GuiClosed == true and guiInternalConfig.CanOpenClose then
					guiInternalConfig.GuiClosed = false
					guiInternalConfig.CanOpenClose = false
					Dragify:TweenPosition(guiInternalConfig.GuiPos,Enum.EasingDirection.In,Enum.EasingStyle.Sine,0.3,false)
					task.wait(0.3)
					Dragify.Visible = true
					guiInternalConfig.CanOpenClose = true
				end
			end
		end
	end)

	--- Gui Minimize/Maximize Button's functioning code.
	MinMax.MouseButton1Down:connect(function()
		if guiInternalConfig.GuiMaximized == false and guiInternalConfig.CanMinimize then
			guiInternalConfig.GuiMaximized = true
			guiInternalConfig.CanMinimize = false
			MinMax.Text = "-"
			Bottom.Visible = true
			Back.Visible = true
			Back:TweenSize(UDim2.new(0, 600, 0, 288),Enum.EasingDirection.Out,Enum.EasingStyle.Sine,0.3,false)
			task.wait(0.4)
			Main.Visible = true
			guiInternalConfig.CanMinimize = true
		elseif guiInternalConfig.GuiMaximized == true and guiInternalConfig.CanMinimize then
			guiInternalConfig.GuiMaximized = false
			guiInternalConfig.CanMinimize = false
			MinMax.Text = "+"
			Main.Visible = false
			Back:TweenSize(UDim2.new(0, 600, 0, 13),Enum.EasingDirection.In,Enum.EasingStyle.Sine,0.3,false)
			task.wait(0.4)
			Back.Visible = false
			Bottom.Visible = false
			guiInternalConfig.CanMinimize = true
		end
	end)

	--- Gui Close Button's functioning.
	Close.MouseButton1Down:connect(function()
		GUI:Destroy()
	end)

	--- The handler for the pages inside of the UI.
	local PageLibrary = {}

	--- Selects a page based on the name
	---@param pageName string The name of the page.
	function PageLibrary:SelectPage(pageName)
		for i,Child in pairs(Pages:GetChildren()) do
			if Child:IsA("GuiObject") then
				Child.Visible=false
			end
		end
		Pages:FindFirstChild(pageName).Visible = true
	end

	--- Functioning of the Welcome button.
	Welcome_2.MouseButton1Click:Connect(function()
		PageLibrary:SelectPage("Welcome")
	end)

	--- Functioning of the Support button.
	Support_2.MouseButton1Click:Connect(function()
		PageLibrary:SelectPage("Support")
	end)

	TextButton_3.MouseButton1Click:Connect(function()
		self:discordInvite("mgMFZUYgQ9")
	end)

	--- Creates a new page inside of the UI.
	---@param Name string The name of the page.
	---@param ImageID number The icon of the page (Decal image ID)
	function PageLibrary:NewPage(Name, ImageID)
		local newPage = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local UIPadding = Instance.new("UIPadding")
		local Support_3 = Instance.new("TextButton")
		local Image_3 = Instance.new("ImageLabel")
		local Text_4 = Instance.new("TextLabel")
		local UICorner_7 = Instance.new("UICorner")
		newPage.Name = Name
		newPage.Parent = Pages
		newPage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		newPage.BackgroundTransparency = 1.000
		newPage.BorderSizePixel = 0
		newPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		newPage.Position = UDim2.new(0.166999996, 0, 0.996999979, 0)
		newPage.Size = UDim2.new(0, 500, 0, 275)
		newPage.Visible = false
		newPage.ScrollBarThickness = 5
		UIListLayout_2.Parent = newPage
		UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 10)
		UIPadding.Parent = newPage
		UIPadding.PaddingTop = UDim.new(0, 10)
		UIPadding.PaddingRight = UDim.new(0, 2)
		Support_3.Name = Name
		Support_3.Parent = Sidebar
		Support_3.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
		Support_3.BorderSizePixel = 0
		Support_3.Position = UDim2.new(0.0526315793, 0, 0, 0)
		Support_3.Size = UDim2.new(0, 85, 0, 30)
		Support_3.Font = Enum.Font.SourceSans
		Support_3.Text = ""
		Support_3.TextColor3 = Color3.fromRGB(0, 0, 0)
		Support_3.TextSize = 14.000
		Image_3.Name = "Image"
		Image_3.Image = ("rbxassetid://".. tostring(ImageID))
		Image_3.Parent = Support_3
		Image_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Image_3.BackgroundTransparency = 1.000
		Image_3.BorderSizePixel = 0
		Image_3.Position = UDim2.new(0, 5, 0, 5)
		Image_3.Size = UDim2.new(0, 20, 0, 20)
		Text_4.Name = Name
		Text_4.Parent = Support_3
		Text_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text_4.BackgroundTransparency = 1.000
		Text_4.Position = UDim2.new(0.36499992, 0, 0, 5)
		Text_4.Size = UDim2.new(0, 55, 0, 20)
		Text_4.Font = Enum.Font.SourceSans
		Text_4.Text = Name
		Text_4.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text_4.TextSize = 14.000
		Text_4.TextWrapped = true
		Text_4.TextXAlignment = Enum.TextXAlignment.Left
		UICorner_7.Parent = Support_3
		Support_3.MouseButton1Click:Connect(function()
			self:SelectPage(Name)
		end)

		local ElementLibrary = {}

	--- Creates a new button inside of a page.
	---@param name string The name of the button.
	---@param callback function What happens when you press the button.
		function ElementLibrary:CreateButton(name, callback)
			name = name or "Text Button"
			callback = callback or function() end
			local ElementButton = Instance.new("TextButton")
			local UICorner5555 = Instance.new("UICorner")
			ElementButton.Name = name
			ElementButton.Parent = newPage
			ElementButton.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
			ElementButton.Position = UDim2.new(0.0199999996, 0, 0, 0)
			ElementButton.Size = UDim2.new(0, 475, 0, 35)
			ElementButton.Font = Enum.Font.Gotham
			ElementButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			ElementButton.TextSize = 14.000
			ElementButton.TextWrapped = true
			ElementButton.Text = name
			UICorner5555.Parent = ElementButton
			ElementButton.MouseButton1Click:Connect(function()
				callback()
			end)
		end
		
		--- Creates a new textbox inside of a page.
		---@param name string The name of the textbox.
		---@param callback function What happens when you submit.
		function ElementLibrary:CreateTextbox(name, callback)
			name = name or "Text Box"
			callback = callback or function() end
			local ElementTextBox = Instance.new("Frame")
			local Submit = Instance.new("TextButton")
			local UICorner22 = Instance.new("UICorner")
			local Icon = Instance.new("ImageLabel")
			local TextBox = Instance.new("TextBox")
			local UICorner_2333 = Instance.new("UICorner")
			local UICorner_3333 = Instance.new("UICorner")
			ElementTextBox.Name = name
			ElementTextBox.Parent = newPage
			ElementTextBox.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
			ElementTextBox.BorderSizePixel = 0
			ElementTextBox.Size = UDim2.new(0, 475, 0, 35)
			Submit.Name = "Submit"
			Submit.Parent = ElementTextBox
			Submit.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
			Submit.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Submit.BorderSizePixel = 0
			Submit.Position = UDim2.new(0, 440, 0, 0)
			Submit.Size = UDim2.new(0, 35, 0, 35)
			Submit.Font = Enum.Font.SourceSans
			Submit.Text = ""
			Submit.TextColor3 = Color3.fromRGB(0, 0, 0)
			Submit.TextSize = 14.000
			Submit.TextTransparency = 1.000
			UICorner22.Parent = Submit
			Icon.Name = "Icon"
			Icon.Parent = ElementTextBox
			Icon.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 445, 0, 5)
			Icon.Size = UDim2.new(0, 25, 0, 25)
			Icon.Image = "rbxassetid://1510598093"
			TextBox.Parent = ElementTextBox
			TextBox.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
			TextBox.BorderSizePixel = 0
			TextBox.Size = UDim2.new(0, 435, 0, 35)
			TextBox.Font = Enum.Font.Gotham
			TextBox.PlaceholderText = name
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 14.000
			UICorner_2333.Parent = TextBox
			UICorner_3333.Parent = ElementTextBox
			Submit.MouseButton1Click:Connect(function()
				callback(TextBox.Text)
			end)
		end

		--- Creates a new toggle inside of a page.
		---@param name string The name of the toggle.
		---@param callback function What happens when you change the value.
		function ElementLibrary:CreateToggle(name, callback)
			name = name or "Toggle"
			callback = callback or function() end
			local active = false
			local ElementToggle = Instance.new("Frame")
			local UICorner_25677 = Instance.new("UICorner")
			local ToggleLabel = Instance.new("TextLabel")
			local Toggle = Instance.new("TextButton")
			local UICorner_255 = Instance.new("UICorner")
			ElementToggle.Name = "ElementToggle"
			ElementToggle.Parent = newPage
			ElementToggle.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
			ElementToggle.BorderSizePixel = 0
			ElementToggle.Size = UDim2.new(0, 475, 0, 35)
			UICorner_25677.Parent = ElementToggle
			ToggleLabel.Name = "ToggleLabel"
			ToggleLabel.Parent = ElementToggle
			ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleLabel.BackgroundTransparency = 1.000
			ToggleLabel.Position = UDim2.new(0, 40, 0, 0)
			ToggleLabel.Size = UDim2.new(0, 435, 0, 35)
			ToggleLabel.Font = Enum.Font.Gotham
			ToggleLabel.Text = name
			ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleLabel.TextSize = 14.000
			ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			Toggle.Name = "Toggle"
			Toggle.Parent = ElementToggle
			Toggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0, 5, 0, 5)
			Toggle.Size = UDim2.new(0, 25, 0, 25)
			Toggle.Font = Enum.Font.SourceSans
			Toggle.Text = ""
			Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.TextSize = 14.000
			UICorner_255.CornerRadius = UDim.new(1, 0)
			UICorner_255.Parent = Toggle
			Toggle.MouseButton1Click:Connect(function()
				if active then
					active = false
					Toggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
					callback(false)
				elseif not active then
					active = true
					Toggle.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
					callback(true)
				end
			end)
		end

		--- Creates a new slider inside of a page.
		---@param name string The name of the toggle.
		---@param callback function What happens when you change the value.
		function ElementLibrary:CreateSlider(name, minvalue, maxvalue, callback)
			name = name or "Slider"
			callback = callback or function() end
			minvalue = minvalue or 0
			maxvalue = maxvalue or 100
			local mouse = game.Players.LocalPlayer:GetMouse()
			local uis = game:GetService("UserInputService")
			local Value = minvalue
			local ElementSlider = Instance.new("Frame")
			local UICorner445565 = Instance.new("UICorner")
			local SliderLabel = Instance.new("TextLabel")
			local SliderBtn = Instance.new("TextButton")
			local SlideInner = Instance.new("Frame")
			ElementSlider.Name = "ElementSlider"
			ElementSlider.Parent = newPage
			ElementSlider.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
			ElementSlider.BorderSizePixel = 0
			ElementSlider.Size = UDim2.new(0, 475, 0, 35)
			UICorner445565.Parent = ElementSlider
			SliderLabel.Name = "SliderLabel"
			SliderLabel.Parent = ElementSlider
			SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderLabel.BackgroundTransparency = 1.000
			SliderLabel.Position = UDim2.new(0.0210526325, 0, 0.0571428575, 0)
			SliderLabel.Size = UDim2.new(0, 80, 0, 15)
			SliderLabel.Font = Enum.Font.Gotham
			SliderLabel.Text = (name.. ": 0")
			SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderLabel.TextSize = 14.000
			SliderLabel.TextStrokeTransparency = 1.000
			SliderLabel.TextWrapped = true
			SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			SliderBtn.Name = "SliderBtn"
			SliderBtn.Parent = ElementSlider
			SliderBtn.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
			SliderBtn.BorderSizePixel = 0
			SliderBtn.Position = UDim2.new(0, 0, 0, 20)
			SliderBtn.Size = UDim2.new(0, 475, 0, 15)
			SliderBtn.Font = Enum.Font.SourceSans
			SliderBtn.Text = " "
			SliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
			SliderBtn.TextSize = 14.000
			SlideInner.Name = "SlideInner"
			SlideInner.Parent = SliderBtn
			SlideInner.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
			SlideInner.BorderSizePixel = 0
			SlideInner.Size = UDim2.new(0, 0, 0, 15)
			SliderBtn.MouseButton1Down:Connect(function()
				Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 475) * SlideInner.AbsoluteSize.X) + tonumber(minvalue)) or 0
				pcall(function()
					callback(Value)
				end)
				SlideInner.Size = UDim2.new(0, math.clamp(mouse.X - SlideInner.AbsolutePosition.X, 0, 475), 0, 16)
				---@diagnostic disable-next-line: undefined-global
				moveconnection = mouse.Move:Connect(function()
					SliderLabel.Text = (name.. ": ".. Value)
					Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 475) * SlideInner.AbsoluteSize.X) + tonumber(minvalue))
					pcall(function()
						callback(Value)
					end)
					SlideInner.Size = UDim2.new(0, math.clamp(mouse.X - SlideInner.AbsolutePosition.X, 0, 475), 0, 16)
				end)
				---@diagnostic disable-next-line: undefined-global
				releaseconnection = uis.InputEnded:Connect(function(Mouse)
					if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
						Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 475) * SlideInner.AbsoluteSize.X) + tonumber(minvalue))
						pcall(function()
							callback(Value)
						end)
						SlideInner.Size = UDim2.new(0, math.clamp(mouse.X - SlideInner.AbsolutePosition.X, 0, 475), 0, 16)
						moveconnection:Disconnect()
						releaseconnection:Disconnect()
					end
				end)
			end)
		end
		return ElementLibrary;
	end
	return PageLibrary;
end
return Library;
