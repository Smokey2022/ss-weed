local QBCore = exports['qb-core']:GetCoreObject()

-- Create usable item for table spawn
QBCore.Functions.CreateUseableItem('weed_table', function(source, item)
    TriggerClientEvent('ss-weed:client:PlaceTable', source)
end)


QBCore.Functions.CreateCallback('ss-weed:server:hasItemsToProcess', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Item = Player.Functions.GetItemByName("skunk") and Player.Functions.GetItemByName("coke_empty_bags")
    if Item ~= nil and Player.Functions.GetItemByName("skunk").amount >= 1 and Player.Functions.GetItemByName("coke_empty_bags").amount >= 2 then
        cb(true)
    else
        cb(false)
    end
end)

-- Process Event

RegisterServerEvent("ss-weed:server:iDidProcess", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.RemoveItem("skunk", 1)
        Player.Functions.RemoveItem("coke_empty_bags", 2)
        Player.Functions.AddItem("weed_skunk", 2)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['weed_skunk'], "add", 2)
    else
        DropPlayer(src, "Attempted exploit abuse")
    end
end)

-- Get Weed
RegisterNetEvent('ss-weed:server:GetWeed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('skunk', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['skunk'], "add")
end)

