Bienvenus dans ce script café crée par moi même : [Développeur] | 𝐏𝐗 #7291
discord :  https://discord.gg/VpYP58ZjmD


Pour utiliser ce job il vous faudra mettre dans votre basicneeds :

------------------------------------------------------------------------------------------
server : 

ESX.RegisterUsableItem('cookie', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cookie', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cookie'))
end)

ESX.RegisterUsableItem('cafe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cafe', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cafe'))
end)

------------------------------------------------------------------------------------------

et dans le local : 

	['used_cookie'] = 'Vous en avez mangé un ~g~Cookie~s~',
	['used_cafe'] = 'Vous en avez bus un ~g~Café~s~',
