local QBCore = exports['qb-core']:GetCoreObject()
local spawnedPlants = 0
local weedPlants = {}

-- Process Event
RegisterNetEvent('ss-weed:client:StartProcess', function()
    local playerPed = PlayerPedId()
    QBCore.Functions.Progressbar("WeedProcess1", "STARTING PROCESS...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function()
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("ss-weed:server:ProcessWeed")
        ClearPedTasks(playerPed)
    end)
end)

-- Process Menu
RegisterNetEvent('ss-weed:client:MenuProcessWeed', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Processing Table",
            txt = ""
        },
        {
            id = 2,
            header = "Process Weed",
            txt = "Needed: <br> 2 - Empty Bags <br> 1 - Raw Skunk",
            params = {
                event = "ss-weed:client:StartProcess",
            }
        },
        {
            id = 6,
            header = "< Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },

    })
end)

-- Target to process
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("ProcessWeed", vector3(1145.66, -1659.84, 36.61), 5, 1, {
        name = "ProcessoWeed",
        heading = 30,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "ss-weed:client:MenuProcessWeed",
                icon = "fas fa-leaf",
                label = "Process Weed",
            },
        },
        distance = 2.5
    })
end)

-- Pick Plants
RegisterNetEvent('ss-weed:client:GetWeed', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID
	for i=1, #weedPlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 1.2 then
			nearbyObject, nearbyID = weedPlants[i], i
		end
	end
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
			if nearbyObject and IsPedOnFoot(playerPed) then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
                QBCore.Functions.Progressbar("HAVERSTWEED", "HARVESTING PLANT..", 6500, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
				ClearPedTasks(playerPed)
				Wait(1000)
				DeleteObject(nearbyObject) 
				table.remove(weedPlants, nearbyID)
				spawnedPlants = spawnedPlants - 1
				TriggerServerEvent('ss-weed:server:GetWeed')
            end)
			else
				QBCore.Functions.Notify('You are too far away..', 'error', 3500)
			end
		else
			QBCore.Functions.Notify('You dont have a trowel!', 'error', 3500)
		end
	end, "trowel")
end)


-- Get Coordinates
CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.WeedField, true) < 50 then
			SpawnweedPlants()
			Wait(500)
		else
			Wait(500)
		end
	end
end)

-- Eliminate Plants on Pickup
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			DeleteObject(v)
		end
	end
end)

-- Spawn Plants
function SpawnObject(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end

-- Generate Coordinates for Plants
function SpawnweedPlants()
	while spawnedPlants < 15 do
		Wait(1)
		local plantCoords = GeneratePlantsCoords()
		SpawnObject('prop_weed_02', plantCoords, function(obj)
			table.insert(weedPlants, obj)
			spawnedPlants = spawnedPlants + 1
		end)
	end
end 

-- Validate Coordinates
function ValidatePlantsCoord(plantCoord)
	if spawnedPlants > 0 then
		local validate = true
		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, Config.WeedField, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end

-- Generate Box Coords
function GeneratePlantsCoords()
	while true do
		Wait(1)
		local weedCoordX, weedCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-15, 15)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-15, 15)
		weedCoordX = Config.WeedField.x + modX
		weedCoordY = Config.WeedField.y + modY
		local coordZ = GetCoordZPlants(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)
		if ValidatePlantsCoord(coord) then
			return coord
		end
	end
end

-- Check Height of Coordinates
function GetCoordZPlants(x, y)
	local groundCheckHeights = { 35, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end

--Target for picking
exports['qb-target']:AddTargetModel(`prop_weed_02`, {
    options = {
        {
            event = "ss-weed:client:GetWeed",
            icon = "fas fa-seedling",
            label = "Harvest Plant",
        },
    },
    distance = 2.0
})
