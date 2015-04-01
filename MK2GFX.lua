--mk2 lua
local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword



--[[
Notes
--14&19 Kung Lao, Liu Kang, Female ninjas
--16&20 Male Ninjas, and Jax maybe bosses
--17&22 Backgrounds, Text, and Intro

Rom 3 interlaced per byte
order
g17 j17 g22 j22

Custom A
A at 0x4000000 = 0x800000 = rom3 0x00
at 1 bit per pixel(1bpp)
Size from script 13x15 = 195 bits
195/8 = 24.375 round up to 25 bytes

Edit
00E0016C8019300686C1601818036680FDBF0136C00EFCC3FF

Break up for roms
Rom g17
00 80 86 18 FD C0 FF

Rom j17
E0 19 C1 03 BF 0E

Rom g22
01 30 60 66 01 FC

Rom j22
6C 06 18 80 36 C3

Shao Khan Tower BG
0x4070E60


]]
--Jax Portrait 55x70

--Globals
palview = 0

--Sprite Addresses
--0x01035B70 selector right bar
--0x01030D10 Jax Portrait
spradr = 0x01030D10
ramstart = 0x300200--times 8 for real address

function main()
--Palette Viewer
if palview == 1 then
	cadr = ramstart -2
	gui.text(8,64,"Paladr: " .. hexval(ramstart*8))

	for r = 0,3,1 do
	for c = 0,15,1 do
	cadr = cadr + 2
	midwaycolor(cadr,8+(c*8),8+(r*8),8)
	end
	end
end

camx = rws(0x20BA6A)
camy = rws(0x20BA26)

ww(0x20D636,0x0100)
--ww(0x20d1Da,0x7100)

if palview == 0 then
sprite(spradr/8)
end

pladr = 0x20C03E

charid = rb(pladr + 0x12)

local movep = rd(pladr+0x06)/8
local xloc = movep + 0x12
local p1x = rws(xloc) - camx
local p1y = rws(xloc + 0x04) - camy

--gui.text(32,32,charid)

end

function sprite(adr)
--Size excluding memory at pointers 0x150
x = rws(adr+0x02) - camx
y = rws(adr+0x06) - camy
spritedata = rw(adr+0x0E)

sprtype = bit.band(spritedata,0xF000)/0x1000
--[[
0~7 = Null
8 =
9 = 1bpp
A = 
B = 
C = 
D = 
E = 6bpp?
F = 7bpp?

]]
location = rd(adr + 0x10)
--[[1bpp
0x4000000 A 0x0D by 0x0F
]]
--[[ Shao Khan Tower
Type: E
Location: 0x04070E60
Size: 61,123
]]

sizex = rw(adr + 0x14)
sizey = rw(adr + 0x16)
palette = rw(adr + 0x18)

gui.text(4,0,"Address: " .. hexval(adr*8))
gui.text(4,8,"X,Y: " .. x .. ", " .. y)
gui.text(4,16,"Type: " .. hexval(sprtype))
gui.text(4,24,"Location: " .. hexval(location))
gui.text(4,32,"Size: " .. sizex .. "," .. sizey)

drawaxis(x,y,8)

end

function midwaycolor(adr,x,y,size)

	local red = (bit.band(rw(adr), 0x7C00)/128)
	local green = bit.band(rw(adr), 0x03E0)/16
	local blue = (bit.band(rw(adr), 0x001F))
	local color = {(red) , (green * 4) , (blue * 8)}
	gui.box(x,y,x+size,y+size,color)
	if size == 16 then
	gui.text(x+2,y+size+04,hexval(red),0xFF0000FF)
	gui.text(x+2,y+size+12,hexval(green*4),0x00FF00FF)
	gui.text(x+2,y+size+20,hexval(blue*8),0x0000FFFF)
	end
end

function drawaxis(x,y,axis,color)

gui.line(x+axis,y,x-axis,y,color)
gui.line(x,y-axis,x,y+axis,color)

end

if palview == 1 then
input.registerhotkey(1, function() 
ramstart = ramstart + (2  * 0x100)
end)

input.registerhotkey(2, function() 
ramstart = ramstart - (2  * 0x100)
end)

else
input.registerhotkey(1, function() 
spradr = spradr + 0x84*4
end)

input.registerhotkey(2, function() 
spradr = spradr - 0x84*4
end)

end


function hexval(val)
        val = string.format("%X",val)
		return val
end

emu.registerafter(function()
main()
end)
