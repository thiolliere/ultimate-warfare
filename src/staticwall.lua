staticwall.staticwall={}

staticwall.add = function ( name, color, x, y, width, height,category)-- + profondeur
	staticwall.staticwall[name]={name=name,draw=nil,update=nil}
	staticwall.staticwall[name].body=love.physics.newBody( world, x ,y,"static")
	staticwall.staticwall[name].shape=love.physics.newRectangleShape(width,height)
	staticwall.staticwall[name].fixture=love.physics.newFixture(staticwall.staticwall[name].body,staticwall.staticwall[name].shape)
	staticwall.staticwall[name].fixture:setUserData("ground") -- idem character
	staticwall.staticwall[name].fixture:setCategory(category)

	staticwall.staticwall[name].draw=function()
		love.graphics.setColor(color.red,color.green,color.blue)
		love.graphics.polygon("fill",staticwall.staticwall[name].body:getWorldPoints(staticwall.staticwall[name].shape:getPoints()))
	end

	staticwall.staticwall[name].update=function()
	end
end

staticwall.update = function()
	for k,v in pairs(staticwall.staticwall) do
		v.update()
	end
end
staticwall.draw = function()
	for k,v in pairs(staticwall.staticwall) do
		v.draw()
	end
end
