-- by. [Développeur] PX - G_Corporation | https://discord.gg/VpYP58ZjmD   

local open = false 
local mainMenu4 = RageUI.CreateMenu('~w~Action Patron', '~w~interaction')
mainMenu4.Closed = function()
    open = false
end

function OpenMenuPatron()
	if open then 
		open = false
		RageUI.Visible(mainMenu4, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu4, true)
		CreateThread(function()
		    while open do 
		        RageUI.IsVisible(mainMenu4,function() 
			        RageUI.Button("Retirer argent de société", nil, {RightLabel = "→"}, true , {
				        onSelected = function()
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. 'bariste',
                                {
                                    title = ('Montant')
                                }, function(data, menu)
                                local amount = tonumber(data.value)

                                if amount == nil then
                                    ESX.ShowNotification('Montant invalide')
                                else
                                    menu.close()
                                    TriggerServerEvent('esx_society:withdrawMoney', 'bariste', amount)
                                end
                            end)
				        end
			        })
			        RageUI.Button("Déposer argent de société", nil, {RightLabel = "→"}, true , {
				        onSelected = function()
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. 'bariste',
                                {
                                    title = ('Montant')
                                }, function(data, menu)
                                local amount = tonumber(data.value)
                                if amount == nil then
                                    ESX.ShowNotification('Montant invalide')
                                else
                                    menu.close()
                                    TriggerServerEvent('esx_society:depositMoney', 'bariste', amount)
                                end
                            end)
				        end
			        })
		        end)
		    Wait(0)
		    end
	    end)
    end
end

local position = {
    {x = -306.85, y = 6270.79, z = 31.53} 
}

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bariste' and ESX.PlayerData.job.grade_name == 'boss' then 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
                if dist <= 2.0 then
                    wait = 0
                    DrawMarker(1, -306.85, 6270.79, 30.53, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 1.0, 69, 45, 20, 255, false, false, p19, true)  
                    if dist <= 1.0 then
                        wait = 0
                        Visual.Subtitle("Appuyez sur [~r~E~w~] pour accéder au menu patron", 1) 
                        if IsControlJustPressed(1,51) then
                            OpenMenuPatron()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)

function RefreshBaristeMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyBaristeMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyBaristeMoney(money)
    societyvignemoney = ESX.Math.GroupDigits(money)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end
