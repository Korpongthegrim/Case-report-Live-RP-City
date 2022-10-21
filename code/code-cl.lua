
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX = nil

local textr = false
local request = false
local talk = false
local accept = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(HELLCfg['FRAME-WORK'].getSharedObject, function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
	PlayerData = ESX.GetPlayerData()
end)

local HELLSHOP = GetCurrentResourceName()
if "HELL.REQUEST-TALK" == HELLSHOP then
	Citizen.CreateThread(function()
		Citizen.Wait(500)
		THEHELLLoadSourceCode()
        
	end)
else
	
end

THEHELLLoadSourceCode = function()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if textr then
			DrawText2D(HELLCfg['TEXT-POSITION'].X, HELLCfg['TEXT-POSITION'].Y, HELLCfg['TEXT-POSITION'].SCALE, HELLCfg['TEXT-POSITION'].WIDTH, HELLCfg['TEXT-POSITION'].HEGIHT,HELLCfg['REQUEST-TEXT'], HELLCfg['TEXT-POSITION'].R, HELLCfg['TEXT-POSITION'].G, HELLCfg['TEXT-POSITION'].B, HELLCfg['TEXT-POSITION'].A,HELLCfg['TEXT-POSITION'].BLACKGROUND)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if request and not talk then
			DisableControlAction(0, Keys[HELLCfg['KeyTalk']], true)
		    if IsControlPressed(0, Keys[HELLCfg['KeyRequest']]) then
				RequestMenuToPed()
			end
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(0)
	if talk then
		EnableControlAction(0, Keys[HELLCfg['KeyTalk']], true)
	end
end)

RegisterNetEvent('THEHELL_REQUEST-TALK:ShowMenu')
AddEventHandler('THEHELL_REQUEST-TALK:ShowMenu', function()
	ShowMenu()
end)

RegisterNetEvent('THEHELL_REQUEST-TALK:AcceptTalk')
AddEventHandler('THEHELL_REQUEST-TALK:AcceptTalk', function()
	talk = true
	request = false
	textr = false
	Notify02()
end)

RegisterNetEvent('THEHELL_REQUEST-TALK:DenyTalk')
AddEventHandler('THEHELL_REQUEST-TALK:DenyTalk', function()
	talk = false
	request = true
	textr = true
	Notify03()
end)

function ShowMenu()
	local elements = {
		{
			label = HELLCfg['MENU_SETTING'].AcceptMenu,
			value = HELLCfg['MENU_SETTING'].Command.Allow
		},
		{
			label =  HELLCfg['MENU_SETTING'].DenyMenu,
			value = HELLCfg['MENU_SETTING'].Command.Deny
		}
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'action_menu', {
		title = HELLCfg['MENU_SETTING'].NameMenu,
		align = HELLCfg['MENU_SETTING'].AlignMenu,
		elements = elements
	}, function(data, menu)
		ExecuteCommand(data.current.value)
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

RegisterCommand(HELLCfg['MENU_SETTING'].Command.Allow, function()
	--print('Accept')
	AcceptTalk()
end, request)
  
RegisterCommand(HELLCfg['MENU_SETTING'].Command.Deny, function()
	--print('Deny')
	DenyTalk()
end, request)

function RequestMenuToPed()
	Citizen.Wait(7)
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	DisableControlAction(0, Keys[HELLCfg['KeyTalk']], true)
		if distance ~= -1 and distance <= HELLCfg['DistanceRequest'] then
			local closestGetPlayerServerId = GetPlayerServerId(closestPlayer)
			TriggerServerEvent(HELLSHOP..':RequestTalkSv', closestGetPlayerServerId)
		else
			NotifyNoNearPlayer()
	end
end

function NotifyNoNearPlayer()
	Citizen.Wait(100)
	Notify01()
end

function AcceptTalk()
	Citizen.Wait(0)
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	local closestGetPlayerServerId2 = GetPlayerServerId(closestPlayer)
	TriggerServerEvent(HELLSHOP..':RequestAccept', closestGetPlayerServerId2)
end

function DenyTalk()
	Citizen.Wait(0)
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	local closestGetPlayerServerId2 = GetPlayerServerId(closestPlayer)
	TriggerServerEvent(HELLSHOP..':RequestDeny', closestGetPlayerServerId2)
end

AddEventHandler('esx:onPlayerDeath', function()
	textr = true
	request = true
	talk = false
end)

AddEventHandler('playerSpawned', function()
	textr = false
	request = false
	talk = true
end)

DrawText2D = function(x, y, scale, width, height, text, r, g, b, a, blackground)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 450


	fontId = RegisterFontId(HELLCfg['FONT'])
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(100, 100, 100, 100,255)
    SetTextEdge(100, 100, 100, 100, 255)
    SetTextDropShadow(5)
	SetTextOutline(5)
	SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - width/2.3, y - height/2 + 0.005)
	DrawRect(x - width/2.3,y - height/2.0 + 0.005 + 0.0150, 0.015 + factor, 0.03, 26, 23, 23, blackground)

end

end