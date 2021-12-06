-- by. [Développeur] PX - G_Corporation | https://discord.gg/VpYP58ZjmD   

local open = false 
local mainMenu3 = RageUI.CreateMenu('Shop', 'Interaction')
mainMenu3.Closed = function()
    open = false
end

function Shopbariste()
    if open then 
        open = false
        RageUI.Visible(mainMenu3, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenu3, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(mainMenu3,function() 
                    for k,v in pairs(shop.list) do 
                        RageUI.Button(v.nom, nil, {RightLabel = "~g~"..v.prix.."$"}, true , {
                            onSelected = function()
                                local item = v.item
                                local prix = v.prix
                                local nom = v.nom 
                                TriggerServerEvent('bariste:achatshop', v)
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end
end

local position = {
	{x = -305.56, y = 6269.04, z = 31.53}
}

Citizen.CreateThread(function()
    while true do
        local wait = 750
        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bariste' then 	
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
                if dist <= 2.0 then
                    wait = 0
                    DrawMarker(1, -305.56, 6269.04, 30.53, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 1.0, 69, 45, 20, 255, false, false, p19, true)  
                    if dist <= 1.0 then
                        wait = 0
                        Visual.Subtitle("Appuyez sur [~r~E~w~] pour accéder au Shop", 1) 
                        if IsControlJustPressed(1,51) then
					        Shopbariste()
           		        end
        	        end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)

shop = {}
shop.list = {
    {nom = "Café", prix = 5, item = "cafe"},    
    {nom = "Cookie", prix = 10, item = "cookie"}
}

