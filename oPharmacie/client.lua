ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshpharmacieMoney()
end)





--blips

Citizen.CreateThread(function()

        local pharmaciemap = AddBlipForCoord(378.72, 329.07, 102.57)
        SetBlipSprite(pharmaciemap, 389)
        SetBlipColour(pharmaciemap, 69)
        SetBlipAsShortRange(pharmaciemap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("pharmacie")
        EndTextCommandSetBlipName(pharmaciemap)


end)

--fin blips



--travail pharmacie

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k,v in pairs(pharmacie.pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pharmacie' then 
            if (pharmacie.Type ~= -1 and GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < pharmacie.DrawDistance) then
                DrawMarker(pharmacie.Type, v.position.x, v.position.y, v.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, pharmacie.Size.x, pharmacie.Size.y, pharmacie.Size.z, pharmacie.Color.r, pharmacie.Color.g, pharmacie.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    
end
end)

-------garage

RMenu.Add('garagepharmacie', 'main', RageUI.CreateMenu("Garage", "Pour sortir un mini-bus."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garagepharmacie', 'main'), true, true, true, function() 
            RageUI.Button("Ranger voiture", "Pour ranger une voiture.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 4 then
                ESX.ShowAdvancedNotification("Garagiste karim", "La voiture est de retour merci!", "", "CHAR_BIKESITE", 1)
                DeleteEntity(veh)
            end 
            end
            end)         
            RageUI.Button("Mini-bus", "Pour sortir un mini-bus.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            ESX.ShowAdvancedNotification("Garagiste karim", "La voiture arrive dans quelques instant..", "", "CHAR_BIKESITE", 1) 
            Citizen.Wait(2000)   
            spawnuniCar("rentalbus")
            ESX.ShowAdvancedNotification("Garagiste karim", "Abime pas la voiture grosse folle !", "", "CHAR_BIKESITE", 1) 
            end
            end)
            

            
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, pharmacie.pos.garage.position.x, pharmacie.pos.garage.position.y, pharmacie.pos.garage.position.z)
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pharmacie' then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('garagepharmacie', 'main'), not RageUI.Visible(RMenu:Get('garagepharmacie', 'main')))
                    end   
                end
               end 
        end
end)

function spawnuniCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, pharmacie.pos.spawnvoiture.position.x, pharmacie.pos.spawnvoiture.position.y, pharmacie.pos.spawnvoiture.position.z, pharmacie.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "pharmacie"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end


--coffre

RMenu.Add('coffrepharmacie', 'main', RageUI.CreateMenu("Coffre", "Pour déposer/récuperer des choses dans le coffre."))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('coffrepharmacie', 'main'), true, true, true, function()
            RageUI.Button("Prendre objet", "Pour prendre un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            OpenGetStockspharmacieMenu()
            end
            end)
            RageUI.Button("Déposer objet", "Pour déposer un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            OpenPutStockspharmacieMenu()
            end
            end)
            end, function()
            end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, pharmacie.pos.coffre.position.x, pharmacie.pos.coffre.position.y, pharmacie.pos.coffre.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pharmacie' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au coffre")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('coffrepharmacie', 'main'), not RageUI.Visible(RMenu:Get('coffrepharmacie', 'main')))
                    end   
                end
               end 
        end
end)

function OpenGetStockspharmacieMenu()
    ESX.TriggerServerCallback('oxgrod_pharmacie:prendreitem', function(items)
        local elements = {}

        for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'pharmacie',
            title    = 'pharmacie stockage',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'pharmacie',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('oxgrod_pharmacie:prendreitems', itemName, count)

                    Citizen.Wait(300)
                    OpenGetStockspharmacieMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenPutStockspharmacieMenu()
    ESX.TriggerServerCallback('oxgrod_pharmacie:inventairejoueur', function(inventory)
        local elements = {}

        for i=1, #inventory.items, 1 do
            local item = inventory.items[i]

            if item.count > 0 then
                table.insert(elements, {
                    label = item.label .. ' x' .. item.count,
                    type = 'item_standard',
                    value = item.name
                })
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'pharmacie',
            title    = 'inventaire',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'pharmacie',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('oxgrod_pharmacie:stockitem', itemName, count)

                    Citizen.Wait(300)
                    OpenPutStockspharmacieMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

--menu f6
local societypharmaciemoney = nil

RMenu.Add('pharmacief6', 'main', RageUI.CreateMenu("Menu pharmacie", "Pour mettre des factures bien fraiche chacal"))
RMenu.Add('pharmacief6', 'patron', RageUI.CreateSubMenu(RMenu:Get('pharmacief6', 'main'), "Option patron", "Option disponible pour le patron"))

Citizen.CreateThread(function()
    while true do
    	

        RageUI.IsVisible(RMenu:Get('pharmacief6', 'main'), true, true, true, function()
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pharmacie' and ESX.PlayerData.job.grade_name == 'boss' then	
        RageUI.Button("Option patron", "Option disponible pour le patron", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('pharmacief6', 'patron'))
        end
        RageUI.Button("Facture", "Pour mettre une facture à la personne proche de toi", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour')
                    else
                    	local amount = KeyboardInput('Veuillez saisir le montant de la facture', '', 4)
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_pharmacie', 'pharmacie', amount)
                    end

            end
            end)
        RageUI.Button("Annonce ouvert", "Pour annoncer au gens que la pharmacie est ouvert chacal", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                TriggerServerEvent('oxgrod_pharmacie:annonceopenchacal')
            end
            end)
            end, function()
        end)
        RageUI.IsVisible(RMenu:Get('pharmacief6', 'patron'), true, true, true, function()
            if societypharmaciemoney ~= nil then
            RageUI.Button("Montant disponible dans la société :", nil, {RightLabel = "$" .. societypharmaciemoney}, true, function()
            end)
        end
        RageUI.Button("Message aux pharmacie", "Pour écrire un message aux pharmacie", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local info = 'patron'
                local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
				TriggerServerEvent('oxgrod_pharmacie:patronmess', info, message)
            end
            end)
        RageUI.Button("Annonce recrutement", "Pour annoncer des recrutements à la pharmacie", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
				TriggerServerEvent('h4c1_pharmacie:annoncerecrutement')
            end
            end)
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pharmacie' then  
                    
                    if IsControlJustPressed(1,167) then
                        RageUI.Visible(RMenu:Get('pharmacief6', 'main'), not RageUI.Visible(RMenu:Get('pharmacief6', 'main')))
                        RefreshpharmacieMoney()
                    end   
                
               end 
        end
end)

RegisterNetEvent('oxgrod_pharmacie:infoservice')
AddEventHandler('oxgrod_pharmacie:infoservice', function(service, nom, message)
	if service == 'patron' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('INFO pharmacie', '~b~A lire', 'Patron: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_MP_STRIPCLUB_PR', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)

function RefreshpharmacieMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietypharmacieMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietypharmacieMoney(money)
    societypharmaciemoney = ESX.Math.GroupDigits(money)
end

--bureau boss


Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdboss = GetEntityCoords(GetPlayerPed(-1), false)
                local bossdist = Vdist(plycrdboss.x, plycrdboss.y, plycrdboss.z, pharmacie.pos.boss.position.x, pharmacie.pos.boss.position.y, pharmacie.pos.boss.position.z)
		    if bossdist <= 1.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pharmacie' and ESX.PlayerData.job.grade_name == 'boss' then	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à la gestion d'entreprise")
                    if IsControlJustPressed(1,51) then
                        OpenBossActionspharmacieMenu()
                    end   
                end
               end 
        end
end)

function OpenBossActionspharmacieMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacie',{
        title    = 'Action patron pharmacie',
        align    = 'top-left',
        elements = {
            {label = 'Gestion employées', value = 'boss_pharmacieactions'},
    }}, function (data, menu)
        if data.current.value == 'boss_pharmacieactions' then
            TriggerEvent('esx_society:openBossMenu', 'pharmacie', function(data, menu)
                menu.close()
            end)
        end
    end, function (data, menu)
        menu.close()

    end)
end

-------fin bureau boss