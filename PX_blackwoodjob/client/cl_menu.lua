-- by. [Développeur] PX - G_Corporation | https://discord.gg/VpYP58ZjmD   
   
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-303.86, 6269.65, 30.53)  
    SetBlipSprite (blip, 536) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8) -- Taille du blip
    SetBlipColour (blip, 21) -- Couleur du blip
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Black Wood Saloon') -- Nom du blip
    EndTextCommandSetBlipName(blip)
end)
  
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local open = false 
local mainMenu = RageUI.CreateMenu('Bariste', 'Interaction')
local SubMenu = RageUI.CreateSubMenu(mainMenu, "Annonces", "Interaction")
mainMenu.Closed = function()
	open = false
end

function OpenMenu8()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
			while open do 
		   		RageUI.IsVisible(mainMenu,function() 
            		RageUI.Button("Annonce Bariste", nil, {RightLabel = "→"}, true, { --bouton dans le menu
            			onSelected = function()
            			end 
            		}, SubMenu)
					RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , { --bouton dans le menu
						onSelected = function()
							OpenBillingMenu2()
                	    	RageUI.CloseAll()
							open = false
						end
					})
        		end)
                RageUI.IsVisible(SubMenu, function() 
                    RageUI.Button("Annonce Ouvertures", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                        	TriggerServerEvent('ouvre:bariste')
                        end
                    })		
					RageUI.Button("Annonce Fermetures", nil, {RightLabel = "→"}, true , {
    					onSelected = function()
        					TriggerServerEvent('ferme:bariste')
    					end
					})
                end)
            Wait(0)
          	end
      	end)
    end
end

function OpenBillingMenu2()
	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_bariste', ('bariste'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
end

Keys.Register('F6', 'Bariste', 'Ouvrir le menu Bariste', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bariste' then
    	OpenMenu8()
	end
end)


