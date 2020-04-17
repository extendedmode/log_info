local updateInterval = 15

-- register when ready
Citizen.CreateThread(function()
	Citizen.Wait(2500)
	TriggerServerEvent('log_info:login')
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000 * 60 * updateInterval)
		TriggerServerEvent('log_info:updateCtime', updateInterval)
	end
end)
