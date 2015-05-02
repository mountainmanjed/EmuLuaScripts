local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword
freezeframe = 0

--[[
Sodom Check
0298DE: cmpi.b  #$6, ($102,A6)
0298E4: bne     $2990e
]]
function main()
camx = rws(0xff8290)
camy = rws(0xff8294)


	playerdata(0xFF8400,0,0)
	
	--Timer
	wb(0xFF8109,0x63)
	if freezeframe == 1 then
	wb(0xff8432,0xFF)
	end
end

function playerdata(adr,x,y)
local px = rw(adr + 0x010) - camx
local py = 244 - rw(adr + 0x014) + camy
local anipnt = rd(adr + 0x1C)
local boxset = rd(adr + 0x88) + rb(anipnt + 0x08)*4
local charid = rb(adr + 0x102)
local stable1 = 0xDD292
local stable2 = 0xDCB92
local spmvstart = rd(charid*4 + stable1)
local propertystart = rd(charid*4 + stable2)


if rb(adr + 0x0B) == 0 then
pflip = 1
else
pflip = -1
end 

--Dunno where to place
gui.text(42,8,"Anim Pointer: " .. hex(anipnt))
gui.text(42,0,"Animation: " .. rb(adr + 0x32) .. "/" .. rb(anipnt))
gui.text(42,16,"Character: " .. hex(rb(adr+0x102)))
gui.text(42,24,"Specials: " .. hex(spmvstart))
gui.text(108,24,"Properties: " .. hex(propertystart))

gui.text(142,0,"Box Setup PT: " .. hex(boxset))
--ww(0xff843a,0x6fff)
--ww(0xff883a,0x6fff)

gui.text(8,200,"X,Y: " .. rb(0xff8411) .. ", " .. rb(0xff8415))

------------------------
----------Push----------
------------------------
local pushpnt = rd(adr + 0x9C)
local push = pushpnt + (rb(boxset + 0x03) * 0x08)
collisionbox(push,px,py,0x00FF0000,pflip)
gui.text(8,212,"Push Pointer: " .. hex(push))


------------------------
----------Head----------
------------------------
local headpnt = rd(adr + 0x90)
local head = headpnt + (rb(boxset + 0x00) * 0x08)
gui.box(224,34,383,54,{0x00,0xFF,0xFF,0x40})

gui.text(228,36,"Head Pointer: " .. hex(head))
gui.text(228,44,"XP: " .. hex(rw(head + 0x00)))
gui.text(268,44,"YP: " .. hex(rw(head + 0x02)))
gui.text(308,44,"XR: " .. hex(rw(head + 0x04)))
gui.text(348,44,"YR: " .. hex(rw(head + 0x06)))


------------------------
----------Body----------
------------------------
local bodypnt = rd(adr + 0x94)
local body = bodypnt + (rb(boxset + 0x01) * 0x08)
gui.box(224,55,383,75,{0xFF,0x88,0xFF,0x40})

gui.text(228,57,"Body Pointer: " .. hex(body))
gui.text(228,65,"XP: " .. hex(rw(body + 0x00)))
gui.text(268,65,"YP: " .. hex(rw(body + 0x02)))
gui.text(308,65,"XR: " .. hex(rw(body + 0x04)))
gui.text(348,65,"YR: " .. hex(rw(body + 0x06)))


------------------------
----------Legs----------
------------------------
local legspnt = rd(adr + 0x98)
local legs = legspnt + (rb(boxset + 0x02) * 0x08)
gui.box(224,76,383,96,{0xFF,0x88,0x00,0x40})

gui.text(228,78,"Legs Pointer: " .. hex(legs))
gui.text(228,86,"XP: " .. hex(rw(legs + 0x00)))
gui.text(268,86,"YP: " .. hex(rw(legs + 0x02)))
gui.text(308,86,"XR: " .. hex(rw(legs + 0x04)))
gui.text(348,86,"YR: " .. hex(rw(legs + 0x06)))

------------------------
---------Attack---------
------------------------
local atkpointer = rd(adr + 0xA0)
local attk = atkpointer + (rb(anipnt + 0x09) * 0x20)
gui.box(8,34,168,76,{0xFF,0x00,0x00,0x40})

gui.text(012,36,"Attk Pointer: " .. hex(attk))
gui.text( 12,44,"XP: " .. hex(rw(attk + 0x00)))
gui.text( 52,44,"YP: " .. hex(rw(attk + 0x02)))
gui.text( 92,44,"XR: " .. hex(rw(attk + 0x04)))
gui.text(132,44,"YR: " .. hex(rw(attk + 0x06)))

gui.text( 12,52,"DM: " .. hex(rb(attk + 0x08)))

gui.text( 92,52,"ST: " .. hex(rb(attk + 0x0C)))


--Boxes
collisionbox(head,px,py,{0x00,0xFF,0xFF,0x00},pflip)
collisionbox(body,px,py,{0xFF,0x88,0xFF,0x00},pflip)
collisionbox(legs,px,py,{0xFF,0x88,0x00,0x00},pflip)
collisionbox(attk,px,py,{0xFF,0x00,0x00,0x00},pflip)

drawaxis(px,py,8)

end

function drawaxis(x,y,axis)

gui.line(x+axis,y,x-axis,y,'yellow')
gui.line(x,y-axis,x,y+axis,'red')

end

function hex(val)
        val = string.format("%X",val)
		return val
end

function getcolor(adr,transparency)
	--This is Example is for cps2 and cps1.
	--Transparency is still possible with this.
	--Example for a box gui.box(32,32,40,40,getcolor(0x900000))
	local red = bit.band(memory.readbyte(adr), 0xF)
	local green = (bit.band(memory.readbyte(adr+1), 0xF0))/16
	local blue = bit.band(memory.readbyte(adr+1), 0xF)
	
	local color = {(red * 17) , (green * 17) , (blue * 17),transparency}
	return color
end

function drawaxis(x,y,axis)

gui.line(x+axis,y,x-axis,y,"white")
gui.line(x,y+axis,x,y-axis,"white")

end

--Collision Box function
function collisionbox(adr,playerx,playery,color,flip)

local hval = rws(adr + 0x0)
local vval = rws(adr + 0x2)
local hrad =  rw(adr + 0x4)
local vrad =  rw(adr + 0x6)

	local hval	 = playerx + hval * flip
	local vval	 = playery - vval
	local left	 = hval - hrad
	local right	 = hval + hrad
	local top	 = vval - vrad
	local bottom = vval + vrad
	
	--gui.line(playerx,playery,left,bottom) To help ID where the box is if your maths is wrong
	gui.box(left,top,right,bottom,color)

end

input.registerhotkey(1, function() 
if freezeframe == 0 then
freezeframe = freezeframe + 1
else
freezeframe = 0
end

end)


emu.registerafter(function()
main()
end)
