HELLCfg = HELLCfg or {}

local sec = 1000
local min = 60000

HELLCfg['FRAME-WORK'] = {
    getSharedObject = "esx:getSharedObject",        -- หากใช้ monster ให้เปลี่ยนจาก esx:getSharedObject เป็น monster:getSharedObject
}

HELLCfg['KeyTalk']			= 'N'
HELLCfg['KeyRequest'] 		= 'R'
HELLCfg['DistanceRequest'] = 2.0

HELLCfg['FONT']            = 'font4thai'
HELLCfg['REQUEST-TEXT']    = '~w~กด ~r~R ~w~เพื่อขอพูด'

HELLCfg['TEXT-POSITION']   = {
    X           = 0.85,
    Y           = 1.10,
    SCALE       = 0.5,
    WIDTH       = 0.692,
    HEGIHT      = 1.2,
    R           = 255,
    G           = 255,
    B           = 255,
    A           = 255,
    BLACKGROUND = 120,
}

HELLCfg['MENU_SETTING'] = {
	NameMenu = 'REQUEST TALK',
	AlignMenu = 'top-left',
	AcceptMenu = 'อนุญาติ',
	DenyMenu = 'ปฏิเสธ',

	Command = {
		Allow = 'allow',
		Deny  = 'deny',
	},
}


-- FUNCTION ZONE
Notify01 = function()
	TriggerEvent("pNotify:SendNotification", {
		text = 'ไม่มีผู้เล่นอยู่บริเวณนี้',
		type = "error",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
end

Notify02 = function()
	TriggerEvent("pNotify:SendNotification", {
		text = 'อนุญาติให้คุณพูดเเล้ว',
		type = "success",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
end

Notify03 = function()
	TriggerEvent("pNotify:SendNotification", {
		text = 'ไม่อนุญาติให้คุณพูด',
		type = "error",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
end