function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(function(player)
            player:setStorageValue(1000, -1)
        end, 1000, player)
    end
    return true
end