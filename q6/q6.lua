
--[[

Question 6
Colter Snyder

Methodology:
    This was a somewhat tricky question to solve, with a solution
      I am not fully happy with. In hindsight, with more time and
      experience with this game's API, this could likely be more
      efficiently solved using some sort of shader.
    However, the methodology I went with involves creating four
      separate creatures that are clones of the player and placing
      them behind the player with each clone becoming more transparent
      the farther behind the player they are. 
    It is not a perfect sollution by any means, but it gets the
      general idea of the question across.

]]--

-- Variable to hold our player clones
local minions = {}

-- function online
-- Description:
--   Create the clones of our player when they come online
-- Args:
--   none
-- Returns:
--   none
function online()
    -- Get our local player, if nil return
    local player = g_game.getLocalPlayer()
    if not player then
        return
    end

    -- Get the player's outfit, if nil return
    local outfit = player:getOutfit()
    if not outfit then
        return
    end

    -- Make the clones
    for i = 1,4 do
        -- Create the clone as a creature
        local clone = Creature.create()
        -- Set the clones outfit to the player's outfit
        clone:setOutfit(outfit)
        -- Set the color mask to show the full outfit (255 or white)
        local color = getOutfitColor(255)
        -- Set the alpha channel of the color based on which clone
        --   we are creating to gradually make the outfit transparent
        color.a = color.a - (color.a * 0.2 * i)
        -- Change the clone's outfit color to this new color
        clone:setOutfitColor(color)
        -- Push our clone into the minions variable
        minions[i] = clone
    end
end

-- function offline
-- Description:
--   Remove the Jump Event and reset the window when 
--      the user logs off
-- Args:
--   none
-- Returns:
--   none
function offline()
    -- Cleanup our minions
    for i = 1,4 do
        -- Make sure clone is removed from the map
        g_map.removeThing(minions[i])
        -- Set that minion to nil
        minions[i] = nil
    end
end

-- function init
-- Description:
--   Initialize the window and buttons when
--      the game starts and assign the onGameStart
--      and onGameEnd functions
-- Args:
--   none
-- Returns:
--   none
function init()
    -- Connect to our game, set onGameStart and
    --   onGameEnd functions
    connect(g_game, {
        onGameStart = online,
        onGameEnd   = offline,
        onWalk      = onWalk
    })

    -- If user is logged in, perform online actions
    if g_game.isOnline() then
        online()
    end
end

-- function terminate
-- Description:
--   Disconnect from the game and freeing the memory
--      by destroying objects
-- Args:
--   none
-- Returns:
--   none
function terminate()
    -- Disconnect from our game
    disconnect(g_game, {
        onGameStart = online,
        onGameEnd   = offline,
        onWalk      = onWalk
    })

end

-- function onWalk
-- Description:
--   Function to dictate what to do when the player walks
--   In this case, we want to know if the player is going
--     in the X or Y direction, and then spawn the four
--     "minions" or clones of the player in a line behind
--     the players current direction, one behind the next
-- Args:
--   direction : Number - What direction is the player facing?
--      = 0 - Up or -Y
--      = 1 - Right or +X
--      = 2 - Down or +Y
--      = 3 - Left or -X
--   dash      : Bool   - Is the player currently dashing?
-- Returns:
--   none
function onWalk(direction, dash)
    -- Get local player, if nil return
    local player = g_game.getLocalPlayer()
    if not player then
        return
    end

    -- Is the player moving in the Y or X direction?
    -- Even direction is Y, odd is X
    local isY = false
    if math.fmod(direction, 2) == 0 then
        isY = true
    end

    -- Get the position from the player, if nil return
    local pos = player:getPosition()
    if not pos then
        return
    end

    -- Draw the clones behind the player
    if isY then
        for i = 1,4 do
            -- Set the position to behind the last placed clone or player
            pos.y = pos.y - 1 * (direction - 1)
            -- Set clone direction to direction
            minions[i]:setDirection(direction)
            -- Set clone position to pos
            minions[i]:setPosition(pos)
            -- Add clone to the map
            g_map.addThing(minions[i], pos, 4)
            -- Schedule the clones erasure from the map
            scheduleEvent(function() g_map.removeThing(minions[i]) end, 200)
        end
    else
        for i = 1,4 do
            -- Set the position to behind the last placed clone or player
            pos.x = pos.x + 1 * (direction - 2)
            -- Set clone direction to direction
            minions[i]:setDirection(direction)
            -- Set clone position to pos
            minions[i]:setPosition(pos)
            -- Add clone to the map
            g_map.addThing(minions[i], pos, 4)
            -- Schedule the clones erasure from the map
            scheduleEvent(function() g_map.removeThing(minions[i]) end, 200)
        end
    end
end
