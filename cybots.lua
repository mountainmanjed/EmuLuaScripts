local rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

airboostvals = {
0x0E80,--0x00 Blodia
0x0E80,--0x01 Reptos
0x09AA,--0x02 Fordy
0x1D00,--0x03 Guldin
0x1D00,--0x04 Swordsman
0x1D00,--0x05 Lighting
0x0740,--0x06 Jackal
0x1D00,--0x07 Vise
0x09AA,--0x08 Cyclone
0x0020,--0x09 Riot
0x05CC,--0x0A Tarantula
0x0020,--0x0B Helion
0x03A0,--0x0C Super 8
0x09AA,--0x0D Gaits
0x0020,--0x0E Warlock
0x0020 --0x0F Killer Bee
}

function main()
timer = 0xFFEBA0
--Timer Cheat
ww(timer,0x9994)

--Camera
camx = rw(0xff802E)
camy = rw(0xff8030)
--Players
padr = 0xFF81A0 - 0x400

for p = 0,1,1 do
	padr = padr + 0x400

	local fliploc = rb(padr + 0x09)
	local plx = rws(padr + 0x1A) - camx
	local ply = (224 - rws(padr + 0x1E) + 16) + camy
	local life = rws(padr + 0x44)

	local boost = rw(padr + 0x16A)
	local arm = rw(padr + 0x16C)
	local weapon = rw(padr + 0x16E)
	local meter = rw(padr + 0x394)

	local bodyid = rb(padr + 0x371)
	local armid = rb(padr + 0x372)
	local weaponid = rb(padr + 0x373)

	local pressboost = airboostvals[bodyid+1]
	
	--Box Data	
	if fliploc == 0 then
	flip = 1
	else
	flip = -1
	end

	local attkid = rb(padr + 0x62)
	local headid = rb(padr + 0x63)
	local bodyid = rb(padr + 0x64)
	local legsid = rb(padr + 0x65)
	local pushid = rb(padr + 0x66)
	boxbase = rd(padr+0x32)
		
	--Attack Address
	attkbase = rw(boxbase) + boxbase
	attkadr = attkid*16 + attkbase
	--Head Address
	headbase = rw(boxbase+2) + boxbase
	headadr = headid*8 + headbase
	--Body
	bodybase = rw(boxbase+4) + boxbase
	bodyadr = bodyid*8 + bodybase
	--Legs
	legsbase = rw(boxbase+6) + boxbase
	legsadr = legsid*8 + legsbase
	--Push
	pushbase = rw(boxbase+8) + boxbase
	pushadr = pushid*8 + pushbase
	
	--Display
	drawaxis(plx,ply,4)
	--Hitboxes
	colbox(pushadr,flip,plx,ply,0x00FF0000)
	colbox(legsadr,flip,plx,ply,0xFFFF0000)
	colbox(bodyadr,flip,plx,ply,0xFFFF0000)
	colbox(headadr,flip,plx,ply,0xFFFF0000)
	colbox(attkadr,flip,plx,ply,0xFF000000)
	
	--Text
	displaytext("Arm: " .. arm,p,104,10)
	displaytext("Weapon: " .. weapon,p,32,10)
	displaytext("Flip: " .. flip,p,8,100)
	displaytext("Boost Left: " .. math.floor(boost/pressboost),p,16,56)
	displaytext("Air Boost: " .. pressboost .. "/" .. boost,p,16,64)
	
	displaytext("Life:" .. life,p,34,27)
	displaytext("Meter:" .. meter/0x100,p,58,200)
	displaytext("X,Y: " .. plx .. ", " .. ply,p,8,186)


	
		--Health Cheat
		if life <= 32 then
		ww(padr + 0x44,0x98)
		end
	end

	--Projectiles
	proadr = 0xFF92A0
	
	for proj = 0,15,1 do
	proadr = proadr + 0xC0
	local active = bit.band(rb(proadr+1),1)
	
	if active == 1 then
	local fliploc = rb(proadr + 0x09)
	--gui.text(168,64+proj*8,hexval(proadr))
	local plx = rws(proadr + 0x1A) - camx
	local ply = (224 - rws(proadr + 0x1E) + 16) + camy
	local baseadr = rd(proadr + 0x32)
	
	local attkid = rb(proadr + 0x62)
	local hurtid = rb(proadr + 0x63)
	
	if fliploc == 0 then
	flip = 1
	else
	flip = -1
	end	
	attkbase = rw(baseadr) + baseadr
	attkadr = attkid*16 + attkbase
	
	hurtbase= rw(baseadr + 0x2)+baseadr
	hurtadr = hurtid*8 + hurtbase
	
	--Display
	drawaxis(plx,ply,8)
	colbox(hurtadr,flip,plx,ply,0x77FFFF00)
	colbox(attkadr,flip,plx,ply,0xFF77FF00)
	
	end	
end
	
end

function colbox(adr,flip,px,py,color)
x = px + (rws(adr)*flip)
y = py - rws(adr + 0x2)
w = rw(adr + 0x4) * flip
h = rw(adr + 0x6)

l = x + w
r = x - w
t = y + h
b = y - h
gui.box(l,t,r,b,color)
end

function displaytext(textdata,player,x,y)
if player == 0 then
gui.text(x,y,textdata)
else
x = 384 - (x + string.len(textdata)*4)
gui.text(x,y,textdata)
end
end

function drawaxis(x,y,axis)
gui.line(x+axis,y,x-axis,y)
gui.line(x,y-axis,x,y+axis)

end

function hexval(val)
    val = string.format("%X",val)
	return val
end

emu.registerafter(function()
main()

end)
