rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

function main()
camx = rw(0x194BF2)
camy = rw(0x194BF6)


pladr = 0x1942B0-- 1942b0

px = rw(pladr + 0x12) - camx 
py = 248 - rw(pladr + 0x16) + camy


--Flip
if rb(pladr + 0x0B) == 0 then
pflip = 1
else
pflip = -1
end 


local anipnt = rd(pladr + 0x1C) - 0x80000000 --These subtractions are need to read the data.

local boxset =  rd(pladr + 0xF4) - 0x80000000 -- Old way (rd(pladr + 0xC0)  + rb(anipnt + 0x02)*4) - 0x80000000
local headpnt = rd(pladr + 0xC4) - 0x80000000
local bodypnt = rd(pladr + 0xC8) - 0x80000000
local legspnt = rd(pladr + 0xCC) - 0x80000000
local pushpnt = rd(pladr + 0xD0) - 0x80000000
local attkpnt = rd(pladr + 0xD4) - 0x80000000

local push = pushpnt + (rb(boxset + 0x03) * 0x08)
local head = headpnt + (rb(boxset + 0x00) * 0x08)
local body = bodypnt + (rb(boxset + 0x01) * 0x08)
local legs = legspnt + (rb(boxset + 0x02) * 0x08)

local attk = attkpnt + (0x10 * 0x20) --Change this for a different Attack box

collisionbox(push,px,py,0x0FFFFF00,pflip)
collisionbox(head,px,py,{0x255,0x255,0,0},pflip)
collisionbox(body,px,py,{0x255,0x255,0,0},pflip)
collisionbox(legs,px,py,{0x255,0x255,0,0},pflip)
collisionbox(attk,px,py,{0x255,0,0,0},pflip)

drawaxis(px,py,8)

gui.text(32,32,"X,Y: " .. px .. "," .. py)
gui.text(32,40,"ANT: " .. hex(anipnt)) -- Fei-Long EF = 5 -- EC = 4
gui.text(32,48,"BOX: " .. hex(boxset))
gui.text(32,56,"ATK: " .. hex(attk))

end

function drawaxis(x,y,axis_length)

gui.line(x+axis_length,y,x-axis_length,y,'yellow')
gui.line(x,y-axis_length,x,y+axis_length,{255, 128, 255, 255})

end

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

function hex(val)
        val = string.format("%X",val)
		return val
end

while true do
main()

emu.frameadvance()
end
