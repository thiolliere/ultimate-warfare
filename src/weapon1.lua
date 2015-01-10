weapon[1]={}

weapon[1].impulse=200
weapon[1].recul=weapon[1].impulse
weapon[1].bulletnumber=0
weapon[1].bulletnumbermax=10
weapon[1].reloadingmagazinetime=70
weapon[1].reloadingbullettime=10
weapon[1].density=0.7
weapon[1].width=0.5*meter
weapon[1].height=0.3*meter
weapon[1].magazine=5

weapon[1].bullet={}

weapon[1].shoot = function ( x,y,orientation)
	local i=weapon[1].bulletnumber
	weapon[1].bullet[i]={}
	weapon[1].bullet[i].body=love.physics.newBody( world, x, y, "dynamic")
	weapon[1].bullet[i].shape=love.physics.newRectangleShape(weapon[1].width,weapon[1].height)
	weapon[1].bullet[i].fixture=love.physics.newFixture(weapon[1].bullet[i].body,weapon[1].bullet[i].shape,weapon[1].density)
	weapon[1].bullet[i].fixture:setUserData("bullet")
	weapon[1].bullet[i].fixture:setCategory(3)
	weapon[1].bullet[i].body:setBullet(true)

	weapon[1].bullet[i].draw=function()
		if weapon[1].bullet[i].body:isActive() then
			love.graphics.setColor(10,10,10)
			love.graphics.polygon("fill",weapon[1].bullet[i].body:getWorldPoints(weapon[1].bullet[i].shape:getPoints()))
		end
	end

	weapon[1].bullet[i].body:applyLinearImpulse(orientation*weapon[1].impulse,0)
	weapon[1].bulletnumber=weapon[1].bulletnumber+1%32
end

weapon[1].trigger = nil
weapon[1].trigger = function(character)
	local o = character.orientation
	local angle = character.body:getAngle()
		local x=character.body:getX()
		local y=character.body:getY()
	if character.charge then
		character.body:applyLinearImpulse(-weapon[1].recul*o,0,x+math.sin(angle),y-math.cos(angle)) -- à changer avec la position de l'arme ou pas
		weapon[1].shoot(x+o*character.height*1.5,y,o)
		character.magazine=character.magazine-1
		character.charge=false
		character.reloading=0
	end
end

weapon[1].update=nil
weapon[1].update=function(character)
	if not character.charge then
		character.reloading=character.reloading+1
		if character.magazine==0 then
			if character.reloading>weapon[1].reloadingmagazinetime then
				character.charge=true
				character.magazine=weapon[1].magazine
			end
		else
			if character.reloading>weapon[1].reloadingbullettime then
				character.charge=true
			end
		end
	end
end


