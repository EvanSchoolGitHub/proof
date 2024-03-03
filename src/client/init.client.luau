local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local debounce = false

local function cameraMovement()
	local cameraPart = Instance.new("Part")
	cameraPart.Size = Vector3.one
	cameraPart.Anchored = true
	cameraPart.CanCollide = true
	cameraPart.Transparency = 0.5
	cameraPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(math.cos(math.pi * 1.5),0,0) * CFrame.new(0,10,-25) + character.HumanoidRootPart.CFrame.LookVector
	cameraPart.Parent = workspace
	
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = CFrame.lookAt(cameraPart.Position,character.HumanoidRootPart.Position + Vector3.new(0,10,0))
	camera.FieldOfView = 100
	Debris:AddItem(cameraPart,.1)
	task.wait(3)
	camera.FieldOfView = 70
	camera.CameraType = Enum.CameraType.Custom
	print(character.Humanoid)
	camera.CameraSubject = character.Humanoid
end

local function DomainExpansion(actionName,inputState)
	if actionName == "DomainExpansion" and inputState == Enum.UserInputState.Begin and not debounce then
		debounce = true
		ReplicatedStorage.DomainExpansion:FireServer()
		task.wait(0.1)
		task.spawn(cameraMovement)
		task.wait(10)
		debounce = false
	end
end

ContextActionService:BindAction("DomainExpansion",DomainExpansion,true,Enum.UserInputType.MouseButton1)