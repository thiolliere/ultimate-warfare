function love.load()

	function wait(seconds)
		local start = os.time()
		repeat until os.time() > start + seconds
	end

	love.window.setMode(1920, 1080, {fullscreen = true, vsync = true, fsaa = 4})

	love.physics.setMeter(8)
	meter = 8

	world = love.physics.newWorld(0,9.81*meter,true)
	world:setCallbacks(beginContact,endContact,preSolve,postSolve)

	systemcommand = love.filesystem.load("systemcommand.lua")

	todo = {load=love.filesystem.load("todo.lua"),update=nil}
	todo.load()

	map = {load=love.filesystem.load("map.lua"),spawn=nil,spawncharacter=nil,wall=nil}
	map.load()

	character={load=love.filesystem.load("character.lua"),add=nil,update=nil,draw=nil}
	character.load()

	staticwall={load=love.filesystem.load("staticwall.lua"),draw=nil,update=nil}
	staticwall.load()

	love.filesystem.load("weapon.lua")()

	keyboard={up="up",down="down",left="left",right="right",shoot="rshift",shift="!"}
	color={red=200,blue=30,green=30}
	character.add(keyboard,"rouge",color,2)
	keyboard={up="z",down="s",left="q",right="d",shoot="lctrl",shift="lshift"}
	color={red=30,blue=200,green=30}
	character.add(keyboard,"bleu",color,1)

	map.spawn()
	map.wall()

	textnumber=""
	time=0
	permanent=""
	dead=""
end

function love.update(dt)
	time=time+1
	todo.update()
	world:update(dt)
	todo.update()
	systemcommand()

	character.update()
	staticwall.update()
	redinterface="RED".."\nmagazine : "..character.character.rouge.magazine.."\nweapon : "..character.character.rouge.weapon.."\nmort : "..character.character.rouge.score
	blueinterface="BLUE".."\nmagazine : "..character.character.bleu.magazine.."\nweapon : "..character.character.bleu.weapon.."\nmort : "..character.character.bleu.score
end

function love.draw()
	love.graphics.setBackgroundColor(83,107,229)
	drawweapon()
	character.draw()
	staticwall.draw()

	love.graphics.setColor(0,0,0)
	love.graphics.print(blueinterface,2*meter,2*meter,0,1.2)
	love.graphics.print(redinterface,1920-15*meter,2*meter,0,1.2)
	love.graphics.print(dead,1920*2/5,1080/2,0,4)
	dead=""
end

function beginContact(a,b,coll)
	if a:getCategory()==2 and b:getCategory()==3 then
		dead=a:getUserData().." est mort"
		character.character[a:getUserData()].score=character.character[a:getUserData()].score+1
		todo.respawn=1
	end
	if a:getCategory()==3 and b:getCategory()==2 then
		dead=b:getUserData().." est mort"
		character.character[a:getUserData()].score=character.character[a:getUserData()].score+1
		todo.respawn=1
	end
	if a:getCategory()==3 and b:getCategory()==4 then
		todo.tokill[a]=a:getBody()
	end
	if a:getCategory()==4 and b:getCategory()==3 then
		todo.tokill[b]=b:getBody()
	end
end

function endContact(a,b,coll)
end

function preSolve(a,b,coll)
end

function postSolve(a,b,coll,normalimpulse1,tangentimpulse1,normalimpulse2tangentimpulse2)
end
