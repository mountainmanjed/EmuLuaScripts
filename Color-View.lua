ramstart = 0x400000

function display()
mame = 0x0000
size = 2
colorform = ngcolor
length = 15 --how many colors you want in each row (0=1color)
rows = 15 -- How many rows 0 = 1 row also so 3 = 4 rows
xpos = 0 -- X offset

--[[
	function		|	Board	 | Size | Ram
	f3colorram()	| taito f3	 |	4	|
	psikyosh2()		|Psikyo  SH2 |	4	|
	standard16()	| CPS3/GoF	 | 	2	| CPS3 0x04080000, Groove on Fight 0x60D0BA8, Ninja Baseball Batman 0xF8800
	jchancolor()	|	Kaneko   |	2	| 
	midwaycolor()	|Fuuki,Midway| 	2	| 
	ngcolor()		|	Neo Geo	 | 	2	| 0x400000
	cpscolor()		| Cps1 Cps2  |	2	| 0x900000
			
]]



--Table
adr = ramstart + (mame * size) - size

--gui.text(40,8,"Address: " .. hex(adr+ size))

for height = 0,rows,1 do
gui.text(xpos+(length+2)*8 ,4 + height*8,"ADR: " .. hex(adr+size))

for row1 = 0,length,1 do
	adr = adr + size
	gui.box(xpos+row1*8, 4+height*8, xpos+8+row1*8, 12+height*8, colorform(adr),0x00000000)
	end
end	
	
end

function cpscolor(adr)

	local bright = 17
	local red = bit.band(memory.readbyte(adr), 0xF)
	local green = (bit.band(memory.readbyte(adr+1), 0xF0))/16
	local blue = bit.band(memory.readbyte(adr+1), 0xF)

	local color = {(red * bright) , (green * bright) , (blue * bright)}


	return color
end

--Neo Geo
function ngcolor(adr)

	local red1 = bit.band(memory.readbyte(adr), 0xF)
	local red2 = (bit.band(memory.readbyte(adr), 0x40))/16
	local green1 = (bit.band(memory.readbyte(adr+1), 0xF0))/16
	local green2 =(bit.band(memory.readbyte(adr), 0x20))/16
	local blue1 = bit.band(memory.readbyte(adr+1), 0xF)
	local blue2 =(bit.band(memory.readbyte(adr), 0x10))/16
	local red = (red1*16) + (red2*2)
	local green = (green1*16) + (green2*4)
	local blue = (blue1*16) + (blue2*8)

	local color = {(red) , (green) , (blue)}


	return color
	
end

function psikyosh2(adr)
	local red = memory.readbyte(adr)
	local green = memory.readbyte(adr + 0x01)
	local blue = memory.readbyte(adr + 0x02)

	local color = {(red) , (green) , (blue)}
	
	return color
end

function standard16(adr) 
--[[
sfex
CPS3 0x04080000
Groove on Fight 0x60D0BA8
Ninja Baseball batman 0xF8800

]]
	
	local red = (bit.band(memory.readword(adr), 0x001F))
	local green = bit.band(memory.readword(adr), 0x03E0)/16
	local blue = (bit.band(memory.readword(adr), 0x7C00)/128)

	local color = {(red*8) , (green*4) , (blue)}

	return color
end

function jchancolor(adr)

	local red	= bit.band(memory.readword(adr), 0x3E0)/16
	local green	= (bit.band(memory.readword(adr), 0x7C00)/128)
	local blue	= (bit.band(memory.readword(adr), 0x001F))
	
	local color = {(red * 4) , (green) , (blue * 8)}
	
	return color
end

function midwaycolor(adr)

	local red = (bit.band(memory.readword(adr), 0x7C00)/128)
	local green = bit.band(memory.readword(adr), 0x03E0)/16
	local blue = (bit.band(memory.readword(adr), 0x001F))

	local color = {(red) , (green * 4) , (blue * 8)}
	

	return color
	
end


function f3colorram(adr)
	local red = memory.readbyte(adr + 0x01 )
	local green = memory.readbyte(adr + 0x02 )
	local blue = memory.readbyte(adr + 0x03 )

	local color = {(red) , (green) , (blue)}

	return color
end

function hex(val)
        val = string.format("%X",val)
		return val
end

input.registerhotkey(1, function() 
ramstart = ramstart + (size  * (rows + 1)*0x10)
end)

input.registerhotkey(2, function() 
ramstart = ramstart - (size  * (rows + 1)*0x10)
end)

while true do
display()

emu.frameadvance()
end
