--[[

Question 3
Colter Snyder

Methodology:
    Add variable checking to this file
    Check if playerId and membername exist as players
      and check if the player has a party
      
]]--

function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)

    -- Ensure that we have a player
    -- If nil, return
    if not player then
        return
    end


    -- Create memberPlayer as we use it a few times in this function
    memberPlayer = Player(membername)

    -- Ensure that memberPlayer is a valid member
    -- If nil, return
    if not memberPlayer then
        return
    end

    local party = player:getParty()

    -- Ensure that the player has a party
    -- If nil, return
    if not party then
        return
    end
    
    for k,v in pairs(party:getMembers()) do
        if v == memberPlayer then
            party:removeMember(memberPlayer)
        end
    end
end