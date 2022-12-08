ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ServerConfig = {
    webhooks = "https://discord.com/api/webhooks/998598254956646462/wnQ8SkJQ7yhYIqohPb0FnqllBAcfXRwe2cKvmIjYeKkwfw6B7FLGwhGfGedvbJyhuLhB",
    webhooksTitle = "Logs Achat Vélos",
    webhooksColor = 3066993,
	webhooksColor2 = 2303786,
	webhooksColor3 = 15548997,
}

ServerToDiscord = function(name, message, color)
	date_local1 = os.date('%H:%M:%S', os.time())
	local date_local = date_local1
	local DiscordWebHook = ServerConfig.webhooks

    local embeds = {
	    {
		    ["title"]= message,
		    ["type"]="rich",
		    ["color"] =color,
		    ["footer"]=  {
			    ["text"]= "Heure : " ..date_local.. "",
		    },
	    }
    }

	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('popo_velo:achat')
AddEventHandler('popo_velo:achat', function(prix, bike, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
    })
	ServerToDiscord(ServerConfig.webhooksTitle, 'Le joueur '  ..xPlayer.getName().. " vient d'acheter pour " ..prix.. "$ le vélo : " ..bike.. "!", ServerConfig.webhooksColor)
	TriggerClientEvent('esx:showNotification', source, "Tu as acheté un " ..bike.. " pour : " ..prix.. " !")
	TriggerClientEvent('esx:showNotification', source, "~g~Ton vélo est sortie.~z~ ~r~Soit prudent sur la route !")

end)