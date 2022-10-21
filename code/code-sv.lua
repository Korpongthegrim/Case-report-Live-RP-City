ESX = nil

TriggerEvent(HELLCfg['FRAME-WORK'].getSharedObject, function(obj) ESX = obj end)

local HELLSHOP = GetCurrentResourceName()

RegisterServerEvent(HELLSHOP..':RequestTalkSv')
AddEventHandler(HELLSHOP..':RequestTalkSv', function(target)
    TriggerClientEvent('THEHELL_REQUEST-TALK:ShowMenu', target)
end)

RegisterServerEvent(HELLSHOP..':RequestAccept')
AddEventHandler(HELLSHOP..':RequestAccept', function(target)
    TriggerClientEvent('THEHELL_REQUEST-TALK:AcceptTalk', target)
end)

RegisterServerEvent(HELLSHOP..':RequestDeny')
AddEventHandler(HELLSHOP..':RequestDeny', function(target)
    TriggerClientEvent('THEHELL_REQUEST-TALK:DenyTalk', target)
end)
