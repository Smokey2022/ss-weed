local QBCore = exports['qb-core']:GetCoreObject()

-- Create usable item for table spawn
QBCore.Functions.CreateUseableItem('weed_table', function(source, item)
    TriggerClientEvent('ss-weed:client:PlaceTable', source)
end)

-- Process Event
RegisterNetEvent('ss-weed:server:ProcessWeed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local weed_leaf = Player.Functions.GetItemByName('skunk')
    local coke_empty_bags = Player.Functions.GetItemByName('coke_empty_bags')
    if weed_leaf ~= nil and coke_empty_bags ~= nil and coke_empty_bags.amount >= 2 and weed_leaf.amount >= 1 then

        Player.Functions.RemoveItem('skunk', 1)
        Player.Functions.RemoveItem('coke_empty_bags', 2)
        Player.Functions.AddItem('weed_skunk', 2)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['weed_skunk'], "add")
    else
        TriggerClientEvent("QBCore:Notify", src, "You do not have the rigth items...", "error")
        end
end)

-- Get Weed
RegisterNetEvent('ss-weed:server:GetWeed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('skunk', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['skunk'], "add")
end)

