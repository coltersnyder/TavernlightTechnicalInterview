
--[[

Question 1
Colter Snyder

Methodology:
    There wasn't much I could find with this question,
      however I did notice that the local function did
      not need to exist as it is only called once, so
      I changed it into a lambda function to prevent it
      from being stored and only be created when it needs
      to be used which, from the title of the function
      only happens when the player logs out, which will
      not happen very often. As such, this will not cause 
      a huge performance hit from this being a lambda function

]]--

function onLogout(player)
    -- Could check to make sure 1000 is a value,
    --   however nil == 1 is still a valid comparison in Lua
    if player:getStorageValue(1000) == 1 then
        -- Changed the local function to a lambda function since it is only used once
        addEvent(function(player)
            player:setStorageValue(1000, -1)
        end, 1000, player)
    end
    return true
end