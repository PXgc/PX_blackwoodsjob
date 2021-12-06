-- by. [Développeur] PX - G_Corporation | https://discord.gg/VpYP58ZjmD

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'bariste', 'alerte bariste', true, true)

TriggerEvent('esx_society:registerSociety', 'bariste', 'bariste', 'society_bariste', 'society_bariste', 'society_bariste', {type = 'public'})

RegisterServerEvent('ouvre:bariste')
AddEventHandler('ouvre:bariste', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Black Woods Saloon', 'Annonce', 'Le Black Wood Café est désormais Ouvert ! N\'hésitez pas à venir prendre un café !', 'CHAR_PROPERTY_BAR_CAFE_ROJO', 8)
    end
end)

RegisterServerEvent('ferme:bariste')
AddEventHandler('ferme:bariste', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Black Woods Saloon', 'Annonce', 'Le Black Wood Café est désormais fermé ! ', 'CHAR_PROPERTY_BAR_CAFE_ROJO', 8)
	end
end) 

RegisterServerEvent('esx_baristejob:getStockItem')
AddEventHandler('esx_baristejob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bariste', function(inventory)
		local item = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', source, "Vous avez retiré x"..count.." "..item.label.."")
		else
			TriggerClientEvent('esx:showNotification', source, "quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('esx_baristejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bariste', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_baristejob:putStockItems')
AddEventHandler('esx_baristejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bariste', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', source, "quantité invalide")
		end
		TriggerClientEvent('esx:showNotification', source, "Vous avez déposé x"..count.." "..item.label.."")
	end)
end)

ESX.RegisterServerCallback('esx_baristejob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('bariste:achatshop')
AddEventHandler('bariste:achatshop', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bariste', function(account)
		societyAccount = account
	end)
	if societyAccount ~= nil then
		societyAccount.removeMoney(item.prix)
		xPlayer.addInventoryItem(item.item, 1)
		TriggerClientEvent('esx:showNotification', source, "Tu as acheté ~g~".. item.nom .."~s~ pour ~g~" .. item.prix .. "$")
	end
end)


