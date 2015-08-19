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
	ww(0xFF8450,0x0090)
	ww(0xFF8850,0x0090)
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
local stable1 = 0xDD292 --Special Moves inputs
local stable2 = 0xDCB92 --Attack Properties 
local stable3 = 0xDCC12 --Special Code
local animationtable = 0xDD412

--dd292

--[[
01FBC2: move.b  ($102,A4), D1
01FBC6: add.w   D1, D1
01FBC8: lea     $32c094.l, A0
01FBCE: add.w   (A0,D1.w), D0
01FBD2: lea     (A0,D0.w), A0
01FBD6: move.l  A0, ($14c,A4)
]]
local paltable = 0x32C094
local paladd =  rw(charid*2 + paltable)
local palstart = paladd + paltable --Starts on Xism Punch Palette
--[[
Each Palette is 0xA0 in size

A0*0 = X ism P
A0*1 = X ism K
A0*2 = A/Z ism P
A0*3 = A/Z ism K
A0*4 = V ism P
A0*5 = V ism K


3C0 size each character
Highest offset 6580
only 30 characters are used
there is another table after this one

Total size 0xB440

]]

local spmvstart = rd(charid*4 + stable1)
local spmvpropt = rd(charid*4 + stable3)
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
gui.text(8,184,"Specials Inputs: " .. hex(spmvstart))
gui.text(8,192,"Specials Code: " .. hex(spmvpropt))
gui.text(108,24,"Properties: " .. hex(propertystart))

gui.text(142,0,"Box Setup PT: " .. hex(boxset))
--ww(0xff843a,0x6fff)
--ww(0xff883a,0x6fff)

gui.text(8,200,"X,Y: " .. px .. ", " .. py)

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
gui.text(228,44,string.format("XP: %04X",rw(head + 0x00)))
gui.text(268,44,string.format("YP: %04X",rw(head + 0x02)))
gui.text(308,44,string.format("XR: %04X",rw(head + 0x04)))
gui.text(348,44,string.format("YR: %04X",rw(head + 0x06)))


------------------------
----------Body----------
------------------------
local bodypnt = rd(adr + 0x94)
local body = bodypnt + (rb(boxset + 0x01) * 0x08)
gui.box(224,55,383,75,{0xFF,0x88,0xFF,0x40})

gui.text(228,57,"Body Pointer: " .. hex(body))
gui.text(228,65,string.format("XP: %04X",rw(body + 0x00)))
gui.text(268,65,string.format("YP: %04X",rw(body + 0x02)))
gui.text(308,65,string.format("XR: %04X",rw(body + 0x04)))
gui.text(348,65,string.format("YR: %04X",rw(body + 0x06)))


------------------------
----------Legs----------
------------------------
local legspnt = rd(adr + 0x98)
local legs = legspnt + (rb(boxset + 0x02) * 0x08)
gui.box(224,76,383,96,{0xFF,0x88,0x00,0x40})

gui.text(228,78,"Legs Pointer: " .. hex(legs))
gui.text(228,86,string.format("XP: %04X",rw(legs + 0x00)))
gui.text(268,86,string.format("YP: %04X",rw(legs + 0x02)))
gui.text(308,86,string.format("XR: %04X",rw(legs + 0x04)))
gui.text(348,86,string.format("YR: %04X",rw(legs + 0x06)))

------------------------,string.format("XP: %04X",rw(
---------Attack---------
------------------------
local atkpointer = rd(adr + 0xA0)
local attk = atkpointer + (rb(anipnt + 0x09) * 0x20)
gui.box(8,34,168,76,{0xFF,0x00,0x00,0x40})

gui.text(012,36,"Attk Pointer: " .. hex(attk))
gui.text( 12,44,string.format("XP: %04X",rw(attk + 0x00)))
gui.text( 52,44,string.format("YP: %04X",rw(attk + 0x02)))
gui.text( 92,44,string.format("XR: %04X",rw(attk + 0x04)))
gui.text(132,44,string.format("YR: %04X",rw(attk + 0x06)))

gui.text( 12,52,string.format("DM: %02X",rb(attk + 0x08)))

gui.text( 92,52,string.format("ST: %02X",rb(attk + 0x0C)))

gui.text( 12,68,string.format("PR: %02X",rb(attk + 0x19)))


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
