local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
print"Timer Cheat"
print"bp 115D8, 1, {maincpu.pd@(6000080)=r0 + r14; g}"

axis_length = 8

function players()

local adr = 0x602DDA0 - 0x200

for player = 0,1,1 do
	adr = adr + 0x200
local px = rws(adr + 0xAC)
local py = rws(adr + 0xAE)

	if rb(adr + 0xB2) == 8 then
	flip = 1
	else
	flip = -1
	end 

local boxact = rb(adr + 0xF7)

local pushcheck = bit.band(boxact,0x80)
local hrt0check = bit.band(boxact,0x40)
local hrt1check = bit.band(boxact,0x20)
local hrt2check = bit.band(boxact,0x10)
local hrt3check = bit.band(boxact,0x08)
local atk0check = bit.band(boxact,0x04)
local atk1check = bit.band(boxact,0x02)
local atk2check = bit.band(boxact,0x01)

local boxadr = (adr + 0x100) - 8

	for cbox = 0,7,1 do

	boxadr = boxadr + 8

	hrad = scale(rb(boxadr + 6))
	vrad = scale(rb(boxadr + 7))
	hval = scale(rws(boxadr + 2))
	vval = scale(rws(boxadr + 4))

		hval   = px + hval * flip
        vval   = py + vval
        left   = hval - hrad
        right  = hval + hrad
        top    = vval - vrad
        bottom = vval + vrad

		if cbox == 7 then
			if pushcheck == 0x80 then
			gui.box(left,top,right,bottom,0x00FF0040,0x00000000)
			end
		elseif cbox == 6 then
			if hrt0check == 0x40 then
			gui.box(left,top,right,bottom,0x0040FF80,0x00000000)
			end
		elseif cbox == 5 then
			if hrt1check == 0x20 then
			gui.box(left,top,right,bottom,0x0040FF80,0x00000000)
			end
		elseif cbox == 4 then
			if hrt2check == 0x10 then
			gui.box(left,top,right,bottom,0x0040FF80,0x00000000)
			end
		elseif cbox == 3 then
			if hrt3check == 0x08 then
			gui.box(left,top,right,bottom,0x0040FF80,0x00000000)
			end		
		elseif cbox == 2 then
			if atk0check == 0x04 then
			gui.box(left,top,right,bottom,0xFF000080,0x00000000)
			end		
		elseif cbox == 1 then
			if atk1check == 0x02 then
			gui.box(left,top,right,bottom,0xFF000080,0x00000000)
			end		
		elseif cbox == 0 then
			if atk2check == 0x01 then
			gui.box(left,top,right,bottom,0xFF000080,0x00000000)
			end		

		end
	end

		gui.drawline(px,py+axis_length,px,py-axis_length)
		gui.drawline(px+axis_length,py,px-axis_length,py)

	end
end

function projectiles()
local adr = rd(0x060030A0)
local numproj = 7

for proj = 0,numproj,1 do
	local prox = rw(adr + 0x18)
	local proy = 42 

--		if active == val then
			
			--Box
			
			--Axis
			gui.drawline(prox,proy+axis_length,prox,proy-axis_length)
			gui.drawline(prox+axis_length,proy,prox-axis_length,proy)
--		end
	end
end

function cheats()
--Health
memory.writebyte(0x602DF1B,0x61)
memory.writebyte(0x602E11B,0x61)

memory.writedword(0x60030A0 + 0x40,0)


--Timer Cheat
timeadr = rd(0x6000080)
if timeadr ~= 0 then
memory.writeword(timeadr+2,0x149C)
end

end

function scale(val)
val= val*(rw(0x602ddb0)/0x003F)

return val
end

function hex(val)
        val = string.format("%X",val)
		return val
end

while true do
players()
projectiles()
cheats()
 
emu.frameadvance()
end
