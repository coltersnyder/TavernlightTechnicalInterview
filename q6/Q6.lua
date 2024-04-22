

local minions = {}

-- function online
-- Description:
--   Show the top bar button when user is online
-- Args:
--   none
-- Returns:
--   none
function online()
    local player = g_game.getLocalPlayer()
    if not player then
        return
    end

    local outfit = player:getOutfit()
    if not outfit then
        return
    end

    for i = 1,4 do
        local clone = Creature.create()
        clone:setOutfit(outfit)
        local color = getOutfitColor(255)
        color.a = color.a - (color.a * 0.2 * i)
        clone:setOutfitColor(color)
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
    for i = 1,4 do
        g_map.removeThing(minions[i])
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

function onWalk(direction, dash)
    local player = g_game.getLocalPlayer()
    if not player then
        return
    end

    local isY = false
    if math.fmod(direction, 2) == 0 then
        isY = true
    end

    local pos = player:getPosition()
    if not pos then
        return
    end

    if isY then
        for i = 1,4 do
            pos.y = pos.y - 1 * (direction - 1)
            minions[i]:setDirection(direction)
            minions[i]:setPosition(pos)
            g_map.addThing(minions[i], pos, 4)
            scheduleEvent(function() g_map.removeThing(minions[i]) end, 200)
        end
    else
        for i = 1,4 do
            pos.x = pos.x + 1 * (direction - 2)
            minions[i]:setDirection(direction)
            minions[i]:setPosition(pos)
            g_map.addThing(minions[i], pos, 4)
            scheduleEvent(function() g_map.removeThing(minions[i]) end, 200)
        end
    end
end

--[[
    local spawner = Spawn.create()
    spawner:setCenterPos(player:getPosition())
    spawner:setRadius(4)

    local creatureType = CreatureType.create("playerCopy")
    creatureType:setOutfit(outfit)

    spawner:addCreature(player:getPosition(), creatureType)
]]--
