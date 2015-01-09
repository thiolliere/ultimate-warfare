todo.tokill={}
todo.respawn=false

todo.update=function()
	for k,v in pairs(todo.tokill) do
		v:setActive(false)
	end
	if todo.respawn==1 then
		todo.respawn=2
	elseif todo.respawn==2 then
		wait(1)
		map.spawn()
		todo.respawn=0
	end
end
