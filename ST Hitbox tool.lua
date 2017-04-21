local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

print("Hotkey 1: Freeze animation")

freezeframe = 0

function main()
camx = rw(0xFF8ED4)
camy = rw(0xFF8ED8)

	playerdata(0xFF844E,0,0)
	
	--Timer
	wb(0xFF8DCE,0x63)
	if freezeframe == 1 then
		ww(0xFF8466, 0x20)
	
	end
end

function playerdata(adr,x,y)
local px = rw(adr + 0x006) - camx
local py = 244 - rw(adr + 0x00A) + camy
local anipnt = rd(adr + 0x1A)

if rb(adr + 0x12) == 0 then
pflip = 1
else
pflip = -1
end 

--Dunno where to place
gui.text(42,8,"Anim Pointer: " .. hex(anipnt))
gui.text(42,0,"Animation: " .. rw(adr + 0x18) .. "/" .. rw(anipnt))
gui.text(42,80,"X,Y: " .. rw(adr + 0x006) .. "/" .. rw(adr + 0x00A))

local boxpnt = rd(adr + 0x34)

------------------------
----------Push----------
------------------------
local pushoff = rw(boxpnt + 0x8)
local pushpnt = boxpnt + pushoff
local push = pushpnt + (rb(anipnt + 0x0D) * 0x04)
collisionbox(push,px,py,0x00FF0000,pflip)
gui.text(8,212,"Push Pointer: " .. hex(push))


------------------------
----------Head----------
------------------------
local headoff = rw(boxpnt + 0x0)
local headpnt = boxpnt + headoff
local head = headpnt + (rb(anipnt + 0x08) * 0x04)
gui.box(224,34,383,54,{0x00,0xFF,0xFF,0x40})

gui.text(228,36,"Head Pointer: " .. hex(head))
gui.text(228,44,"XP: " .. hex(rb(head + 0x00)))
gui.text(268,44,"YP: " .. hex(rb(head + 0x01)))
gui.text(308,44,"XR: " .. hex(rb(head + 0x02)))
gui.text(348,44,"YR: " .. hex(rb(head + 0x03)))


------------------------
----------Body----------
------------------------
local bodyoff = rw(boxpnt + 0x2)
local bodypnt = boxpnt + bodyoff
local body = bodypnt + (rb(anipnt + 0x09) * 0x04)
gui.box(224,55,383,75,{0xFF,0x88,0xFF,0x40})

gui.text(228,57,"Body Pointer: " .. hex(body))
gui.text(228,65,"XP: " .. hex(rb(body + 0x00)))
gui.text(268,65,"YP: " .. hex(rb(body + 0x01)))
gui.text(308,65,"XR: " .. hex(rb(body + 0x02)))
gui.text(348,65,"YR: " .. hex(rb(body + 0x03)))


------------------------
----------Legs----------
------------------------
local legsoff = rw(boxpnt + 0x4)
local legspnt = boxpnt + legsoff
local legs = legspnt + (rb(anipnt + 0x0A) * 0x04)
gui.box(224,76,383,96,{0xFF,0x88,0x00,0x40})

gui.text(228,78,"Legs Pointer: " .. hex(legs))
gui.text(228,86,"XP: " .. hex(rb(legs + 0x00)))
gui.text(268,86,"YP: " .. hex(rb(legs + 0x01)))
gui.text(308,86,"XR: " .. hex(rb(legs + 0x02)))
gui.text(348,86,"YR: " .. hex(rb(legs + 0x03)))

------------------------
---------Attack---------
------------------------
local attkoff = rw(boxpnt + 0x6)
local atkpointer = boxpnt + attkoff
local attk = atkpointer + (rb(anipnt + 0xC) * 0x10)
gui.box(8,34,168,76,{0xFF,0x00,0x00,0x40})

gui.text(012,36,"Attk Pointer: " .. hex(attk))
gui.text(012,44,"XP: " .. hex(rb(attk + 0x00)))
gui.text(052,44,"YP: " .. hex(rb(attk + 0x01)))
gui.text(092,44,"XR: " .. hex(rb(attk + 0x02)))
gui.text(132,44,"YR: " .. hex(rb(attk + 0x03)))

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

		val_x  = playerx + rbs(adr + 0) * flip
		val_y  = playery - rbs(adr + 1)
		rad_x  =  rb(adr + 2)
		rad_y  =  rb(adr + 3)
		
		left   = val_x - rad_x
		right  = val_x + rad_x
		top    = val_y - rad_y
		bottom = val_y + rad_y

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