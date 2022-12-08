ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RMenu.Add('velo', 'velo_buy', RageUI.CreateMenu("Bike Shop","Choisissez votre vélo :"))
RMenu:Get('velo', 'velo_buy').Closed = function()end


RMenu.Add("velo", "cat_tribike", RageUI.CreateSubMenu(RMenu:Get("velo", "velo_buy"),"Modèles disponible:", nil))
RMenu:Get("velo", "cat_tribike").Closed = function()end


-- Génération de plaque

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

-- mixing async with sync tasks
local function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('blue_vehicleshop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

local function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

local function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

local function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(4) .. GetRandomNumber(4))

		ESX.TriggerServerCallback('blue_vehicleshop:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

--Afficher le menu--

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get("velo", "velo_buy"),true,true,true,function()

            RageUI.Button("BMX", "BMX", {RightLabel = "~g~100$"}, true,function(h,a,s)
                if (s) then
                    spawnCar("bmx")
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('popo_velo:achat', 100, "BMX", vehicleProps)
                    RageUI.CloseAll()
                end
            end)

            RageUI.Button("Cruiser", "Cruiser", {RightLabel = "~g~300$"}, true,function(h,a,s)
                if (s) then
                    spawnCar("cruiser")
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('popo_velo:achat', 300, "Cruiser", vehicleProps)
                    RageUI.CloseAll()
                end
            end)

            RageUI.Button("Fixter", "Fixter", {RightLabel = "~g~500$"}, true,function(h,a,s)
                if (s) then
                    spawnCar("fixter")
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('popo_velo:achat', 500, "Fixter", vehicleProps)
                    RageUI.CloseAll()
                end
            end)
            RageUI.Button("Scorcher", "Scorcher", {RightLabel = "~g~500$"}, true,function(h,a,s)
                if (s) then
                    spawnCar("scorcher")
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('popo_velo:achat', 500, "Scorcher", vehicleProps)
                    RageUI.CloseAll()
                end
            end)
            RageUI.Button("Tribike", "Tribike", {RightLabel = "~g~>>>"}, true,function(h,a,s)
                if (s) then
                end
            end,RMenu:Get("velo", "cat_tribike"))
        end, function()end)


        RageUI.IsVisible(RMenu:Get("velo","cat_tribike"),true,true,true,function()
            RageUI.Button("Jaune et Blanc", "Jaune et Blanc", {RightLabel = "~g~500$"}, true,function(h,a,s)
                if (s) then
                    spawnCar("tribike")
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('popo_velo:achat', 500, "Tribike", vehicleProps)
                    RageUI.CloseAll()
                end
            end)
            RageUI.Button("Rouge et Blanc", "Jaune et Blanc", {RightLabel = "~g~500$"}, true,function(h,a,s)
                if (s) then
                    spawnCar("tribike2")
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('popo_velo:achat', 500, "Tribike", vehicleProps)
                    RageUI.CloseAll()
                end
            end)
            RageUI.Button("Bleu et Blanc", "Jaune et Blanc", {RightLabel = "~g~500$"}, true,function(h,a,s)
                if (s) then
                    spawnCar("tribike3")
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(vehicle, newPlate)
                    TriggerServerEvent('popo_velo:achat', 500, "Tribike", vehicleProps)
                    RageUI.CloseAll()
                end
            end)
        end, function()end, 1)
        Citizen.Wait(0)
    end
end)

--Afficher le point s'il est loin ou non--

Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(-1221.8071, -1494.5905, 4.338)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 30 then
            interval = 200
        else
            interval = 1
            if distance < 3 then
                AddTextEntry("velo", "Appuyez sur [~b~E~w~] pour voir les vélos disponible !")
                DisplayHelpTextThisFrame("velo", false)
                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(RMenu:Get("velo","velo_buy"), true)
                end
            end
        end
        Citizen.Wait(interval)
    end  
end)


--Spawn le véhicule--

function spawnCar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, -1225.1696, -1494.9327, 4.36, 108.93, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(-1221.8071, -1494.5905, 4.338)
  
    SetBlipSprite (blip, 376)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 5)
    SetBlipAsShortRange(blip, true)
  
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Achat de Vélo")
    EndTextCommandSetBlipName(blip)
  
end)