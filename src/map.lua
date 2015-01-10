map.spawncharacter = function (number, character)
	position={{ x = 12*meter , y = 1080-5*meter , o =  1 } , { x = 1920-12*meter , y = 1080 - 5*meter , o = -1 } }
	character.body:setLinearVelocity(0,0)
	character.body:setAngularVelocity(0)
	character.body:setPosition(position[number].x,position[number].y)
	character.orientation=position[number].o
	character.body:setAngle(math.pi)
	character.body:setActive(true)
	character.life=character.lifeMax
	character.weapon=1
	character.magazine=weapon[character.weapon].magazine
	character.charge=true
	character.reloading=0
end

map.spawn = function ()
	for k,v in pairs(character.character) do
		map.spawncharacter(v.number,v)
	end
end


map.wall = function()
	staticwall.add("ground",{red=30,blue=8,green=180},1920/2,1080-meter,1920,2*meter,4)
	staticwall.add("outleft",{red=150,blue=0,green=0},0,1080/2,2*meter,1080+2*meter,3)
	staticwall.add("outright",{red=150,blue=0,green=0},1920,1080/2,2*meter,1080+2*meter,3)
	staticwall.add("outup",{red=150,blue=0,green=0},1920/2,0,1920+2*meter,2*meter,3)
	staticwall.add("wall1",{red=80,blue=80,green=80},1920/2,1080/4,10*meter,30*meter,4)
	staticwall.add("wall2",{red=80,blue=80,green=80},1920/2,1080*3/4,10*meter,30*meter,4)
	staticwall.add("wall3",{red=80,blue=80,green=80},1920/4,1080/2,10*meter,30*meter,4)
	staticwall.add("wall4",{red=80,blue=80,green=80},1920*3/4,1080/2,10*meter,30*meter,4)
end
