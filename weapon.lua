weapon={}

love.filesystem.load("weapon1.lua")()
love.filesystem.load("weapon2.lua")()

drawweapon = function()
	for i,v in ipairs(weapon) do
		for j,w in ipairs(v.bullet) do
			w.draw()
		end
	end
end

