RDX = nill

TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)

local InService    = {}
local MaxInService = {}

function GetInServiceCount(name)
	local count = 0

	for k,v in pairs(InService[name]) do
		if v == true then
			count = count + 1
		end
	end

	return count
end

RegisterServerEvent('rdx_service:activateService')
AddEventHandler('rdx_service:activateService', function(name, max)
	InService[name] = {}
	MaxInService[name] = max
end)

RegisterServerEvent('rdx_service:disableService')
AddEventHandler('rdx_service:disableService', function(name)
	InService[name][source] = nil
end)

RegisterServerEvent('rdx_service:notifyAllInService')
AddEventHandler('rdx_service:notifyAllInService', function(notification, name)
	for k,v in pairs(InService[name]) do
		if v == true then
			TriggerClientEvent('rdx_service:notifyAllInService', k, notification, source)
		end
	end
end)

RDX.RegisterServerCallback('rdx_service:enableService', function(source, cb, name)
	local inServiceCount = GetInServiceCount(name)

	if inServiceCount >= MaxInService[name] then
		cb(false, MaxInService[name], inServiceCount)
	else
		InService[name][source] = true
		cb(true, MaxInService[name], inServiceCount)
	end
end)

RDX.RegisterServerCallback('rdx_service:isInService', function(source, cb, name)
	local isInService = false

	if InService[name] ~= nil then
		if InService[name][source] then
			isInService = true
		end
	else
		print(('[rdx_service] [^3WARNING^7] A service "%s" is not activated'):format(name))
	end

	cb(isInService)
end)

RDX.RegisterServerCallback('rdx_service:isPlayerInService', function(source, cb, name, target)
	local isPlayerInService = false
	local targetXPlayer = RDX.GetPlayerFromId(target)

	if InService[name][targetXPlayer.source] then
		isPlayerInService = true
	end

	cb(isPlayerInService)
end)

RDX.RegisterServerCallback('rdx_service:getInServiceList', function(source, cb, name)
	cb(InService[name])
end)

AddEventHandler('rdx:playerDropped', function(playerId, reason)
	for k,v in pairs(InService) do
		if v[_source] == true then
			v[_source] = nil
		end
	end
end)
