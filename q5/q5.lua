
--[[

Question 5
Colter Snyder

Methodology:
    This was an interesting problem to figure out
	  how to start.
	My first attempt was to use the combat API to
	  recreate the effects.
	This did not work, however, when trying to do
	  multiple effects one after the other.
	For this, I found my solution in the sendMagicEffect()
	  call present in Position as this was able to
	  create the desired effect.
	It is not a 1 to 1 replication of the video, however,
	  as I was having trouble with the positioning
	  and operation of the Ice Tornadoes not wanting
	  to be position in the exact same spots as the video.

]]--

-- Operation of Ice Tornadoes
--   Big are Even
--   Small are Odd
--   Even and Odd Apply to both Row and Column
--     ie 1,3 will be small, 2,2 will be big
--   x + y MUST equal an even number
--   z has no affect on above
--   -x: left
--   +x: right
--   -y: up
--   +y: down
--   -z: diagonal offset (upper left)

-- Create table of tornado positions
local tornadoes = {
	{{-4,0,0}, {4,0,0}, {3,-1,0}, {3,1,0}, {2,-2,0}, {1,-3,0}},
	{{-3,-1,0}, {1,-1,0}, {-3,1,0}, {-2,2,0}, {2,2,0}},
	{{-2,0,0}, {2,0,0}, {-2,-2,0}},
	{{-1,1,0}, {-1,3,0}}
}

-- function drawTornado
-- Args:
--   creaturePos  :  Position - Position from which to start magic effect
--   tornadoFrame :  Number   - Index in tornado array to create tornado positions
-- Returns:
--   none
function drawTornado(creaturePos, tornadoFrame)
	-- Go through every tornado in this frame and add the magical effect to the specified position
	for i,v in pairs(tornadoes[tornadoFrame]) do
		-- Offset position based on which position we are currently looking add
		local pos = Position(creaturePos.x + v[1], creaturePos.y + v[2], creaturePos.z + v[3])
		-- Draw the Ice Tornado magical effect at that position
		pos:sendMagicEffect(CONST_ME_ICETORNADO)
	end
end

-- function onCastSpell
-- Args:
--   creature : Creature - Creature that cast this spell
--   variant  : Variant  - Variant for this spell (number, string, position, or thing)
--   isHotKey : Bool     - Is spell performed using a hot key?
-- Returns:
--   none
function onCastSpell(creature, variant, isHotkey)
	-- Add our tornado drawing events, one after the other
    addEvent(drawTornado, 10,  creature:getPosition(), 1)
	addEvent(drawTornado, 200, creature:getPosition(), 2)
	addEvent(drawTornado, 500, creature:getPosition(), 3)
	addEvent(drawTornado, 800, creature:getPosition(), 4)

    return true
end