-- by. [Développeur] PX - G_Corporation | https://discord.gg/VpYP58ZjmD   
   
local open = false 
local mainMenu2 = RageUI.CreateMenu('Coffre', 'Interaction')
mainMenu2.Closed = function()
  	open = false
end

function Coffrebariste()
    if open then 
        open = false
        RageUI.Visible(mainMenu2, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenu2, true)
        CreateThread(function()
        	while open do 
           		RageUI.IsVisible(mainMenu2,function() 
               		RageUI.Button("Prendre Objet/s", nil, {RightLabel = "→"}, true , {
                   		onSelected = function()
							OpenGetStocksMenu()
                   			RageUI.CloseAll()
							open = false
                   		end
               		})
               		RageUI.Button("Déposer Objet/s", nil, {RightLabel = "→"}, true , {
                   		onSelected = function()
							OpenPutStocksMenu()
                   			RageUI.CloseAll()
							open = false
                   		end
               		})
           		end)
         	Wait(0)
        	end
     	end)
  	end
end

local position = {
	{x = -302.67, y = 6270.69, z = 31.53}
}

Citizen.CreateThread(function()
    while true do
    	local wait = 900
    	for k in pairs(position) do
        	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bariste' then 
            	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            	local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            	if dist <= 2.0 then
            		wait = 0
            		DrawMarker(1, -302.67, 6270.69, 30.53, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 1.0, 69, 45, 20, 255, false, false, p19, true)  
            		if dist <= 1.0 then
               			wait = 0
                		Visual.Subtitle("Appuyez sur [~r~E~w~] pour accéder au coffre", 1) 
                		if IsControlJustPressed(1,51) then
							Coffrebariste()
           				end
        			end
        		end
    		end
		Citizen.Wait(wait)
		end
	end
end)

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_baristejob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			css 	 = 'bariste',
			title    = 'bariste stock',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				css 	 = 'bariste',
				title =  'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_baristejob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_baristejob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			css 	 = 'bariste',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				css 	 = 'bariste',
				title 	= 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_baristejob:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end