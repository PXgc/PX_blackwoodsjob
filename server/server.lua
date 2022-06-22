ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'bariste', 'alerte bariste', true, true)
TriggerEvent('esx_society:registerSociety', 'bariste', 'bariste', 'society_bariste', 'society_bariste', 'society_bariste', {type = 'public'})

RegisterServerEvent('PX_blackwood:ouvert')
AddEventHandler('PX_blackwood:ouvert', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Bariste", "Annonce", "Le Bariste est désormais ~g~Ouvert ~s~!", "CHAR_PROPERTY_BAR_CAFE_ROJO", 5)
    end
end)

RegisterServerEvent('PX_blackwood:ferme')
AddEventHandler('PX_blackwood:ferme', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Bariste", "Annonce", "Le Bariste est désormais ~r~Fermé ~s~!", "CHAR_PROPERTY_BAR_CAFE_ROJO", 5)
	end
end) 

RegisterServerEvent('PX_blackwood:perso')
AddEventHandler('PX_blackwood:perso', function(notif)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Bariste", "Annonce", notif, "CHAR_PROPERTY_BAR_CAFE_ROJO", 5)
    end
end)

ESX.RegisterServerCallback('PX_blackwood:playerinventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.inventory
    local all_items = {}
    for k,v in pairs(items) do
        if v.count > 0 then
            table.insert(all_items, {label = v.label, item = v.name, nb = v.count})
        end
    end
    cb(all_items)
end)

ESX.RegisterServerCallback('PX_blackwood:getStockItems', function(source, cb)
    local all_items = {}
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bariste', function(inventory)
        for k,v in pairs(inventory.items) do
            if v.count > 0 then
                table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
            end
        end
    end)
    cb(all_items)
end)

RegisterServerEvent('PX_blackwood:putStockItems')
AddEventHandler('PX_blackwood:putStockItems', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item_in_inventory = xPlayer.getInventoryItem(itemName).count
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bariste', function(inventory)
        if item_in_inventory >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez déposé "..Config.Color.." "..count.." "..itemName.." ~s~dans le coffre de la société")
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'en avez pas assez sur vous")
        end
    end)
end)

RegisterServerEvent('PX_blackwood:takeStockItems')
AddEventHandler('PX_blackwood:takeStockItems', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bariste', function(inventory)
        xPlayer.addInventoryItem(itemName, count)
        inventory.removeItem(itemName, count)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez retiré "..Config.Color..""..count.." "..itemName.." ~s~du coffre de la société")
    end)
end)

RegisterServerEvent('PX_blackwood:preparer')
AddEventHandler('PX_blackwood:preparer', function(name)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(name, 1)
end)