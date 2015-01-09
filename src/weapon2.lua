weapon[2]={} -- changer un peu le fonctionnement pour que arme qui chauffe et tir en continue

weapon[2].impulse=0
weapon[2].position={x=0,y=2*meter}
weapon[2].recul=weapon[2].impulse
weapon[2].bulletnumber=0
weapon[2].bulletnumbermax=256
weapon[2].reloadingbullettime=2
weapon[2].reloadingmagazinetime=10
weapon[2].density=3
weapon[2].width=0.5*meter
weapon[2].height=0.3*meter
weapon[2].magazine=100

weapon[2].bullet={}

weapon[2].shoot = function ( x,y,orientation)
	local i=weapon[2].bulletnumber
	weapon[2].bullet[i]={}
	weapon[2].bullet[i].body=love.physics.newBody( world, x, y, "dynamic")
	weapon[2].bullet[i].shape=love.physics.newRectangleShape(weapon[2].width,weapon[2].height)
	weapon[2].bullet[i].fixture=love.physics.newFixture(weapon[2].bullet[i].body,weapon[2].bullet[i].shape,weapon[2].density)
	weapon[2].bullet[i].fixture:setUserData("bullet")
	weapon[2].bullet[i].fixture:setCategory(3)
	weapon[2].bullet[i].body:setBullet(true)

	weapon[2].bullet[i].draw=function()
		if weapon[2].bullet[i].body:isActive() then
			love.graphics.setColor(220,10,10)
			love.graphics.polygon("fill",weapon[2].bullet[i].body:getWorldPoints(weapon[2].bullet[i].shape:getPoints()))
		end
	end

	weapon[2].bullet[i].body:applyLinearImpulse(orientation*weapon[2].impulse,0)
	weapon[2].bulletnumber=weapon[2].bulletnumber+1%32
end

weapon[2].trigger = nil
weapon[2].trigger = function(character)
	local o = character.orientation
		local x=character.body:getX()
		local y=character.body:getY()
	local angle = character.body:getAngle()
	if character.charge then
		character.body:applyLinearImpulse(-weapon[2].recul*o,0,x+math.sin(angle),y-math.cos(angle)) -- à changer avec la position de l'arme ou pas
		weapon[2].shoot(x+weapon[2].position.x,y+weapon[2].position.y,o)
		character.magazine=character.magazine-1
		character.charge=false
		character.reloading=0
	end
end

weapon[2].update=nil
weapon[2].update=function(character)

	character.reloading=character.reloading+1
	if character.reloading>weapon[2].reloadingbullettime then
		character.charge=true
	end
	if character.magazine<=0 then
		character.charge=false
	end	
	if character.reloading>weapon[2].reloadingmagazinetime then
		character.magazine=math.min(character.magazine+1,weapon[2].magazine)
		character.reloading=0
	end

end
