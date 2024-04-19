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

-- Create an instance of Question 5
-- local q5 = Spell(SPELL_INSTANT)

-- function drawTornado
-- Args:
--   creaturePos:  Position - Position from which to start magic effect
--   tornadoFrame: Number   - Index in tornado array to create tornado positions
-- Returns:
--   none
function drawTornado(creaturePos, tornadoFrame)
	for i,v in pairs(tornadoes[tornadoFrame]) do
		local pos = Position(creaturePos.x + v[1], creaturePos.y + v[2], creaturePos.z + v[3])
		pos:sendMagicEffect(CONST_ME_ICETORNADO)
	end
end

function onCastSpell(creature, variant, isHotkey)
    addEvent(drawTornado, 10,  creature:getPosition(), 1)
	addEvent(drawTornado, 200, creature:getPosition(), 2)
	addEvent(drawTornado, 500, creature:getPosition(), 3)
	addEvent(drawTornado, 800, creature:getPosition(), 4)

    return true
end