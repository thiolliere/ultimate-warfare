character.character={}

character.add = function ( keyboard, name, color, number)
	character.character[name]={number=number,name=name,draw=nil,update=nil}

	character.character[name].width=0.5*meter
	character.character[name].height=1.7*meter
	character.character[name].density=2
	character.character[name].jetpack={}
	character.character[name].jetpack.impulse=20
	character.character[name].jetpack.y=-0.2*meter --distance au centre
	character.character[name].jetpack.width=0.7*meter
	character.character[name].jetpack.height=character.character[name].jetpack.width
	character.character[name].linearDamping=1
	character.character[name].angularDamping=360
	character.character[name].lifeMax=100
	character.character[name].lifeReg=1.5
	character.character[name].score=0
	character.character[name].timetoarme=10

	character.character[name].counterarmed=0
	character.character[name].weapon=1
	character.character[name].body=love.physics.newBody( world, 0, 0, "dynamic")
	character.character[name].shape=love.physics.newRectangleShape(character.character[name].width,character.character[name].height)
	character.character[name].fixture=love.physics.newFixture(character.character[name].body,character.character[name].shape,character.character[name].density)
	character.character[name].fixture:setUserData(character.character[name].name) 
	character.character[name].fixture:setCategory(2)
	character.character[name].body:setLinearDamping(character.character[name].linearDamping)
	character.character[name].orientation=1 
	character.character[name].body:setAngle(0)
	character.character[name].body:setBullet(true)
	character.character[name].body:setAngularDamping(character.character[name].linearDamping)

	character.character[name].charge=true

	character.character[name].draw=function()
		love.graphics.setColor(color.red,color.green,color.blue)
		love.graphics.polygon("fill",character.character[name].body:getWorldPoints(character.character[name].shape:getPoints()))
		love.graphics.setColor(20,20,20)
		local x = character.character[name].body:getX()+character.character[name].jetpack.y*math.sin(character.character[name].body:getAngle()) - character.character[name].jetpack.width/2
		local y = character.character[name].body:getY()-character.character[name].jetpack.y*math.cos(character.character[name].body:getAngle()) - character.character[name].jetpack.height/2

		love.graphics.rectangle("fill",x,y,character.character[name].jetpack.width,character.character[name].jetpack.height)
	end

	character.character[name].update=function()
		local angle=character.character[name].body:getAngle()
		local x=character.character[name].body:getX()
		local y=character.character[name].body:getY()
		local o=character.character[name].orientation
		local xi=0
		local yi=0
		local xj=0
		local yj=0
		local w=character.character[name].weapon

		if love.keyboard.isDown(keyboard.up) then
			yi=-character.character[name].jetpack.impulse
		end
		if love.keyboard.isDown(keyboard.right) then
			character.character[name].orientation=1
			xi=character.character[name].jetpack.impulse
		end
		if love.keyboard.isDown(keyboard.left) then
			character.character[name].orientation=-1
			xi=-character.character[name].jetpack.impulse
		end
		if love.keyboard.isDown(keyboard.down) then
			yi=character.character[name].jetpack.impulse
		end

		xj = x+character.character[name].jetpack.y*math.sin(angle)
		yj = y-character.character[name].jetpack.y*math.cos(angle)

		character.character[name].body:applyLinearImpulse(xi,yi,xj,yj)

		if character.character[name].armed then

			if love.keyboard.isDown(keyboard.shoot) and character.character[name].armed then
				weapon[w].trigger(character.character[name])
			end

			weapon[w].update(character.character[name])

			if love.keyboard.isDown(keyboard.shift) then -- et c'ees uniquement sur la pression du bouton
				character.character[name].armed=false
				character.character[name].counterarmed=0
				character.character[name].charge=false
				character.character[name].magazine=0 -- ou alors temps de changer different de temps de charge
				character.character[name].weapon=character.character[name].weapon %2 +1 -- ou alors un nom aux armes
			end

		else	
			character.character[name].counterarmed=character.character[name].counterarmed+1
			if character.character[name].counterarmed>=character.character[name].timetoarme then
				character.character[name].armed=true
				character.character[name].counterarmed=0
			end
		end





		character.character[name].life=math.min(character.character[name].lifeMax,character.character[name].life*character.character[name].lifeReg)
	end
end

character.update = function()
	for k,v in pairs(character.character) do
		v.update()
	end
end
character.draw = function()
	for k,v in pairs(character.character) do
		v.draw()
	end
end
