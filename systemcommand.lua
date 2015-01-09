if love.keyboard.isDown("escape") then
	love.event.quit()
end


if love.keyboard.isDown("r") then
	textnumber=""
end
function love.keypressed(key)
if key=="kp0" then
	textnumber=textnumber.."0"
elseif key=="kp1" then
	textnumber=textnumber.."1"
elseif key=="kp2" then
	textnumber=textnumber.."2"
elseif key=="kp3" then
	textnumber=textnumber.."3"
elseif key=="kp4" then
	textnumber=textnumber.."4"
elseif key=="kp5" then
	textnumber=textnumber.."5"
elseif key=="kp6" then
	textnumber=textnumber.."6"
elseif key=="kp7" then
	textnumber=textnumber.."7"
elseif key=="kp8" then
	textnumber=textnumber.."8"
elseif key=="kp9" then
	textnumber=textnumber.."9"
elseif key=="kp." then
	textnumber=textnumber.."."
end
end
number=tonumber(textnumber)


if love.keyboard.isDown("j") then
	for k,v in pairs(character.character) do
		v.jetpack.impulse=number -- à changer
	end
end

if love.keyboard.isDown("tab") then
	map.spawn()
end

text=textnumber
