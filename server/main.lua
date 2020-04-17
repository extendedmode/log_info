RegisterServerEvent('log_info:login')
AddEventHandler('log_info:login', function()
	local _source = source
	local steam64 = GetPlayerIdentifiers(_source)[1]
	local rp_name = getRoleplayName(_source)
	local steam_name = GetPlayerName(_source)
	local rockstar = nil
	local ipv4 = nil
	local xbl = nil
	local fivem = nil
	local live = nil
	
	for _, foundID in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(foundID, "license:") then
			rockstar = foundID
		elseif string.match(foundID, "steam:") then
			steam64 = foundID
		elseif string.match(foundID, "ip:") then
			ipv4 = string.sub(foundID, 4)
		elseif string.match(foundID, "fivem:") then
			fivem = foundID
		elseif string.match(foundID, "discord:") then
			discord = foundID			
		elseif string.match(foundID, "xbl:") then
			xbl = foundID
		elseif string.match(foundID, "live:") then
			live = foundID			
		end
	end
	
    --print(rockstar, ipv4, fivem, steam, discord, xbl, live)
	
	MySQL.Async.fetchAll('SELECT * FROM account_info WHERE steam64_hex=@steam64_hex', {['@steam64_hex'] = steam64}, function(result)
		if result[1] == nil then
			MySQL.Async.execute("INSERT INTO account_info (steam64_hex,rp_name, steam_name, rockstar, ipv4, xbl, live, discord, fivem) VALUES (@steam64_hex,@rp_name,@steam_name,@rockstar,@ipv4,@xbl,@live,@discord,@fivem)",
			{
				['@steam64_hex'] = steam64,
				['@rp_name'] = rp_name,
				['@steam_name'] = steam_name,
				['@rockstar'] = rockstar,
				['@ipv4'] = ipv4,
				['@live'] = live,
				['@xbl'] = xbl,
				['@fivem'] = fivem,
				['@discord'] = discord				
			})
		else
			-- keep database updated
			MySQL.Sync.execute("UPDATE account_info SET rp_name=@rp_name, steam_name=@steam_name, ipv4=@ipv4, rockstar = @rockstar, xbl = @xbl, fivem = @fivem, discord = @discord WHERE steam64_hex=@steam64_hex",
			{
				['@steam64_hex'] = steam64,
				['@rp_name'] = rp_name,
				['@steam_name'] = steam_name,
				['@rockstar'] = rockstar,
				['@ipv4'] = ipv4,
				['@live'] = live,
				['@xbl'] = xbl,
				['@fivem'] = fivem,
				['@discord'] = discord
			})
		end
	end)
end)

RegisterServerEvent('log_info:updateCtime')
AddEventHandler('log_info:updateCtime', function(minutesOnline)
	local _source = source
	local steam64 = GetPlayerIdentifiers(_source)[1]
	
	MySQL.Async.fetchAll('SELECT * FROM account_info WHERE steam64_hex=@steam64_hex', {['@steam64_hex'] = steam64}, function(result)
		if result[1] ~= nil then
			local playedTime = tonumber(result[1].online_time) + tonumber(minutesOnline)
			MySQL.Sync.execute("UPDATE account_info SET online_time=@online_time WHERE steam64_hex=@steam64_hex",
			{
				['@steam64_hex'] = steam64,
				['@online_time'] = playedTime,
			})
		end
	end)
end)

function getRoleplayName(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM characters WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]
		return identity['firstname'] .. ' ' .. identity['lastname']
	else
		return '23-19!'
	end
end