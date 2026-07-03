--[[
    UI.lua - Interface personalizada
    Autor: NICKSLKy

    Compatível com Main.lua (AutoJJs-EB)
--]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Module = {}
Module.UIElements = {
	Box = {},
}

local UI_TITLE = "NICKSLKy - Auto JJs"

local Version = "2.3"
local Language = {}
local Rainbow = false
local ScreenGui

-- ══════════════════════════════════════
--              Helpers				
-- ══════════════════════════════════════

local function Create(Class, Props, Parent)
	local Inst = Instance.new(Class)
	for Prop, Value in pairs(Props or {}) do
		Inst[Prop] = Value
	end
	if Parent then
		Inst.Parent = Parent
	end
	return Inst
end

local function MakeDraggable(Frame, DragHandle)
	local Dragging, DragStart, StartPos

	DragHandle.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = Input.Position
			StartPos = Frame.Position

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	DragHandle.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			if Dragging then
				local Delta = Input.Position - DragStart
				Frame.Position = UDim2.new(
					StartPos.X.Scale, StartPos.X.Offset + Delta.X,
					StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y
				)
			end
		end
	end)
end

-- ══════════════════════════════════════
--              Build UI				
-- ══════════════════════════════════════

local function Build(Parent)
	ScreenGui = Create("ScreenGui", {
		Name = "AutoJJs_UI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	}, Parent)

	local Main = Create("Frame", {
		Name = "Main",
		Size = UDim2.new(0, 280, 0, 340),
		Position = UDim2.new(0.5, -140, 0.5, -170),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BorderSizePixel = 0,
	}, ScreenGui)
	Create("UICorner", { CornerRadius = UDim.new(0, 10) }, Main)

	local TopBar = Create("Frame", {
		Name = "TopBar",
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = Color3.fromRGB(15, 15, 15),
		BorderSizePixel = 0,
	}, Main)
	Create("UICorner", { CornerRadius = UDim.new(0, 10) }, TopBar)

	local TitleLabel = Create("TextLabel", {
		Name = "Title",
		Size = UDim2.new(1, -70, 1, 0),
		Position = UDim2.new(0, 12, 0, 0),
		BackgroundTransparency = 1,
		Text = UI_TITLE,
		TextColor3 = Color3.fromRGB(90, 200, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
	}, TopBar)

	local VersionLabel = Create("TextLabel", {
		Name = "Version",
		Size = UDim2.new(0, 50, 1, 0),
		Position = UDim2.new(1, -58, 0, 0),
		BackgroundTransparency = 1,
		Text = "[v" .. Version .. "]",
		TextColor3 = Color3.fromRGB(255, 90, 90),
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Right,
	}, TopBar)

	MakeDraggable(Main, TopBar)

	-- Campos de texto
	local function TextField(LabelText, YPos)
		local Container = Create("Frame", {
			Size = UDim2.new(1, -24, 0, 44),
			Position = UDim2.new(0, 12, 0, YPos),
			BackgroundTransparency = 1,
		}, Main)

		Create("TextLabel", {
			Size = UDim2.new(1, 0, 0, 18),
			BackgroundTransparency = 1,
			Text = LabelText,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, Container)

		local Box = Create("TextBox", {
			Size = UDim2.new(1, 0, 0, 26),
			Position = UDim2.new(0, 0, 0, 18),
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
			Font = Enum.Font.Gotham,
			TextSize = 14,
			ClearTextOnFocus = false,
			Text = "",
		}, Container)
		Create("UICorner", { CornerRadius = UDim.new(0, 6) }, Box)
		Create("UIPadding", {
			PaddingLeft = UDim.new(0, 8),
		}, Box)

		return Box
	end

	Module.UIElements.Box["Start"] = TextField("Começar do:", 50)
	Module.UIElements.Box["End"] = TextField("Até o:", 104)
	Module.UIElements.Box["Prefix"] = TextField("Final do Prefix:", 158)
	Module.UIElements.Box["Start"]:SetAttribute("IntBox", true)
	Module.UIElements.Box["End"]:SetAttribute("IntBox", true)

	-- Toggle "Pular"
	local ToggleLabel = Create("TextLabel", {
		Size = UDim2.new(0.6, 0, 0, 20),
		Position = UDim2.new(0, 12, 0, 212),
		BackgroundTransparency = 1,
		Text = "Pular:",
		TextColor3 = Color3.fromRGB(200, 200, 200),
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, Main)

	local Slide = Create("Frame", {
		Name = "Slide",
		Size = UDim2.new(0, 50, 0, 24),
		Position = UDim2.new(1, -62, 0, 210),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BorderSizePixel = 0,
	}, Main)
	Create("UICorner", { CornerRadius = UDim.new(1, 0) }, Slide)

	local Circle = Create("TextButton", {
		Name = "Circle",
		Size = UDim2.new(0, 20, 0, 20),
		Position = UDim2.new(0.22, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Text = "",
		AutoButtonColor = false,
	}, Slide)
	Create("UICorner", { CornerRadius = UDim.new(1, 0) }, Circle)

	Module.UIElements.Slide = Slide
	Module.UIElements.Circle = Circle

	-- Botão Play
	local Play = Create("TextButton", {
		Name = "Play",
		Size = UDim2.new(1, -24, 0, 46),
		Position = UDim2.new(0, 12, 0, 264),
		BackgroundColor3 = Color3.fromRGB(37, 150, 255),
		Text = "▶",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		AutoButtonColor = true,
	}, Main)
	Create("UICorner", { CornerRadius = UDim.new(0, 10) }, Play)
	Module.UIElements.Play = Play

	-- Keybind toggle da UI
	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if GameProcessed then return end
		if Input.KeyCode == Enum.KeyCode[Module.Keybind or "Home"] then
			Main.Visible = not Main.Visible
		end
	end)

	-- Rainbow opcional
	if Rainbow then
		task.spawn(function()
			local Hue = 0
			while ScreenGui and ScreenGui.Parent do
				Hue = (Hue + 0.005) % 1
				TitleLabel.TextColor3 = Color3.fromHSV(Hue, 0.8, 1)
				task.wait(0.03)
			end
		end)
	end

	return Main
end

-- ══════════════════════════════════════
--              API pública				
-- ══════════════════════════════════════

function Module:SetVersion(v)
	Version = v
end

function Module:SetLanguage(Lang)
	Language = Lang or {}
end

function Module:SetRainbow(State)
	Rainbow = State
end

function Module:SetParent(Parent)
	Build(Parent)
end

function Module.getUI()
	return ScreenGui
end

return Module
