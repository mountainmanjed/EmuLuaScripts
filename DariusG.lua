--Darius Gaiden

dofile"shitiuseallthetime.lua"

function main()
getmouse = input.get()

--0x4161D4 
--gui.text(8,8,"MX,MY: " .. getmouse.xmouse .. ", " .. getmouse.ymouse )

padr = 0x41B190--Different in Extra 
	for p = 0,1,1 do  
	padr = padr + p*0x8A
	
	local activatepnt = rd(padr)
	local px = rws(padr + 0x14)
	local py = rws(padr + 0x18)
	
	local boxx1 = px + rws(padr + 0x2C)
	local boxx2 = px + rws(padr + 0x2E)
	local boxy1 = py + rws(padr + 0x30)
	local boxy2 = py + rws(padr + 0x32)
	
	local hp = rds(padr + 0x24)
	local hpmax  = rds(padr + 0x28)
	local enemy = rd(padr + 0x36)
	local lives = rws(padr + 0x4C)
	local shield = rws(padr + 0x4E)
	local shieldunkwn = rws(padr + 0x5E)--Mirror?
	
--Display
	if activatepnt == 0xC7946 then
	--drawaxis(px,py+8,2)
	--gui.text(32,32+p*8,"X,Y:" .. px .. "," .. py)
	--gui.text(132,32+p*8,hexval(pointer))

	gui.box(boxx1,boxy1,boxx2,boxy2,0x0040FF20)
	
	if shield > 0 then
		gui.text(px,py+16,shield)
		end

	end
end
---------------------------

enemyaddresstable = 0x41ACE0
--CBFDE moves x
--41444C,4144B8,414524
--ww(0x414590+0x14,64)
--ww(0x414590+0x18,48)

-------------------------------------------------------------
--Determine amount enemies/projectiles doesn't include bosses
enemies = 0
repeat enemies = enemies + 1
until (rd(enemyaddresstable + (enemies * 4))) == 0
gui.text(8,32,"Enemies: " .. enemies)
--------------------------------------------------------------

for en = 0,enemies,1 do
	enadr = rd(enemyaddresstable + en*0x4)
	local pnt = rd(padr)
	local enx = rws(enadr + 0x14)
	local eny = rws(enadr + 0x18)
	local hp = rws(enadr + 0x24)
	local boxx1 = enx + rws(enadr + 0x2C)
	local boxx2 = enx + rws(enadr + 0x2E)
	local boxy1 = eny + rws(enadr + 0x30)
	local boxy2 = eny + rws(enadr + 0x32)
	local acttest = rd(enadr + 0x9F)
	
	--[[if enadr == 0x414668 then
	ww(enadr + 0x14,getmouse.xmouse)
	ww(enadr + 0x18,getmouse.ymouse)
	end--]]
	
	if acttest ~= 0 then
	gui.box(boxx1,boxy1,boxx2,boxy2,0xEE00DD40)
	
	--drawaxis(enx,eny+8,4)
	--gui.text(enx + 16, eny - 16,"ADR: " .. hexval(enadr))
	--gui.text(enx - 16, eny + 16,"HP: " .. hp)
--]]
	end
	end
end


gui.register(function()
main()

end)
