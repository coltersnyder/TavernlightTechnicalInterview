
--[[

Question 7
Colter Snyder

Methodology:
    This was a fun question to try and figure out.
    It really gave me an understanding of how the UI
      system in OTClient works.
    As for the methodology, I didn't deviate too much
      from how the other UI windows in the OTClient
      operate beyond using scheduleEvent() in order
      to move the button from the right side of the
      screen to the left and getting rid of that buttons
      anchoring to the window.

]]--

-- Main UI window
q7Window   = nil

-- Top bar button
q7Button   = nil

-- Jump Button
-- Actions:
--  onClick: Reset Position to righthand side of window
--      at random Y in the window
jumpButton = nil

-- Jump Event
-- Description:
--   Event to scroll the jump button left at a speed of
--      5 every 50 milliseconds
jumpEvent  = nil

-- function online
-- Description:
--   Show the top bar button when user is online
-- Args:
--   none
-- Returns:
--   none
function online()
    q7Button:show()
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
    removeEvent(jumpEvent)
    resetWindow()
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
        onGameEnd   = offline
    })

    -- Make new UI window and hide
    q7Window = g_ui.displayUI('Q7', modules.game_interface.getRightPanel())
    q7Window:hide()

    -- Set top bar button
    q7Button = modules.client_topmenu.addRightGameToggleButton('Q7', tr('Q7'), '/images/topbuttons/q7', toggle)

    -- Set Jump Button as defined in Q7.otui
    jumpButton = q7Window:getChildById('buttonJump')

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
        onGameEnd   = offline
    })

    -- Destroy our UI objects
    q7Window:destroy()
    q7Button:destroy()
end

-- function jump
-- Description:
--   Set the Jump Button to the right side of the
--      UI window at a random Y within the
--      UI window
-- Args:
--   none
-- Returns:
--   none
function jump()
    -- Get the UI window's position
    local pos = q7Window:getPosition()

    -- Calculate the proper distance from the far
    --   right of the screen so it's not too far
    pos.x = pos.x + q7Window:getWidth() - 80

    -- Find a random Y 40 units below the top and
    --   40 units above the bottom of the window
    pos.y = pos.y + math.random(40, (q7Window:getHeight() - 40))

    -- Set the Jump Button to this new position
    jumpButton:setPosition(pos)
end

-- function jumpScroll
-- Description:
--   Get the current position of the Jump Button
--      and subtract 5 from it. If that position
--      leads the button to the very left side
--      of the screen, reset the button back to
--      the right side by calling jump()
-- Args:
--   none
-- Returns:
--   none
function jumpScroll()
    -- Get the Jump Button's position
    local pos = jumpButton:getPosition()

    -- Offset the position 5 units to the left
    pos.x = pos.x - 5

    -- If the position is at the very left of the window
    --      reset the button back to the right side of
    --      the screen
    -- Else set Jump Button position to pos
    if pos.x < q7Window:getPosition().x + 16 then
        jump()
    else
        jumpButton:setPosition(pos)
    end
end

-- function toggle
-- Description:
--   Toggle the UI window by using the Jump
--      Button's on state. When toggled either
--      hides or shows the window and either
--      starts or stop the Jump Event
-- Args:
--   none
-- Returns:
--   none
function toggle()
    if q7Button:isOn() then
        -- Set the top bar button to an off state
        q7Button:setOn(false)

        -- Hide the UI window
        q7Window:hide()

        -- If the event exists, remove it
        if jumpEvent then
            removeEvent(jumpEvent)
        end
    else
        -- Set the top bar button to an on state
        q7Button:setOn(true)

        -- Show the UI window
        q7Window:show()

        -- Raise the window to the top
        q7Window:raise()

        -- Make the window focused
        q7Window:focus()

        -- Reset the Jump Button
        jump()

        -- Turn on the event
        jumpEvent = cycleEvent(jumpScroll, 50)
    end
end

-- function resetWindow
-- Description:
--   Reset this script by hiding the UI box, 
--      setting the top row button to an off state,
--      and finally stops the Jump Event
-- Args:
--   none
-- Returns:
--   none
function resetWindow()
    q7Window:hide()
    q7Button:setOn(false)

    -- If event exists, remove it
    if jumpEvent then
        removeEvent(jumpEvent)
    end
end