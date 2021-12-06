-- by. [Développeur] PX - G_Corporation | https://discord.gg/VpYP58ZjmD   

local open = false 
local mainmenu5 = RageUI.CreateMenu('Vestiaire', 'Interaction')
mainmenu5.Closed = function()
    open = false
end

function vestiairebariste()
    if open then 
        open = false
        RageUI.Visible(mainmenu5, false)
        return
    else
        open = true 
        RageUI.Visible(mainmenu5, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(mainmenu5,function() 
                    RageUI.Button("Tenue Civile", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            tenuecivil()
                            RageUI.CloseAll()
                            open = false
                        end
                    })
                    RageUI.Separator("~w~↓ ~w~Tenue Bariste ~w~↓")
                    RageUI.Button("Tenue Bariste", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            tenuebariste()
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

function tenuecivil() ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin) TriggerEvent('skinchanger:loadSkin', skin) end) end

function tenuebariste()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local elements = {}
        if skin.sex == 0 then
            clothesSkin = {
                        ['tshirt_1'] = 32,  ['tshirt_2'] = 0,
                        ['torso_1'] = 31,   ['torso_2'] = 6,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 44,
                        ['pants_1'] = 24,   ['pants_2'] = 6,
                        ['shoes_1'] = 20,   ['shoes_2'] = 0,
                        ['chain_1'] = 12,  ['chain_2'] = 2
            }
        else
            clothesSkin = {
                        ['tshirt_1'] = 38,   ['tshirt_2'] = 14,
                        ['torso_1'] = 57,    ['torso_2'] = 6,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 36,
                        ['pants_1'] = 37,   ['pants_2'] = 6,
                        ['shoes_1'] = 0,    ['shoes_2'] = 0,
                        ['chain_1'] = 21,    ['chain_2'] = 2
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        ESX.ShowNotification('Vous avez équipé votre ~b~tenue de Bariste')
    end)
end

local position = {
	{x = -295.72, y = 6268.3, z = 31.53}
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
                    DrawMarker(1, -295.72, 6268.3, 30.53, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 1.0, 69, 45, 20, 255, false, false, p19, true)  
                    if dist <= 1.0 then
                        wait = 0
                        Visual.Subtitle("Appuyez sur [~r~E~w~] pour accéder au Vestiaire", 1) 
                        if IsControlJustPressed(1,51) then
                            vestiairebariste()
           		        end
        	        end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)



