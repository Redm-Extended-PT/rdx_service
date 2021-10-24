RDX  = nil

Citizen.CreateThread(function()
	while RDX == nil do
		TriggerEvent('rdx:getSharedObject', function(obj) rdx = obj end)
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent('rdx_service:notifyAllInService')
AddEventHandler('rdx_service:notifyAllInService', function(notification, target)
	target = GetPlayerFromServerId(target)
	if target == PlayerId() then return end

	local targetPed = GetPlayerPed(target)
	local mugshot, mugshotStr = RDX.Game.GetPedMugshot(targetPed)

	RDX.ShowAdvancedNotification(notification.title, notification.subject, notification.msg, mugshotStr, notification.iconType)
	UnregisterPedheadshot(mugshot)
end)