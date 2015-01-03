local rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

mirroroffset = 0x80000000
fill = 0x00 -- Do not change or the emulator slow down to a crawl

------------------------------
-----------Settings-----------
------------------------------
Player_color = {0x00, 0xFF, 0xFF, fill}
Object_color = {0xFF, 0xFF, 0x00, fill}
Platfm_color = {0xFF, 0x00, 0xFF, fill}
Intact_color = {0xFF, 0x00, 0x00, fill}

------------------------------
------------------------------


function dungeon()
------------------------------------------------
--Dungeon
------------------------------------------------

camx = rds(0x896B0)
camy = rds(0x896B4)

--C7154

gui.text(8,200,"Cam X,Y: " .. camx .. ", " .. camy)

----------------------------------------------------------
px = ((bit.band(rds(0x1E7790),0xFFFFFF00)/256) - camx)
py = ((bit.band(rds(0x1E7794),0xFFFFFF00)/256) - camy)

plcellpnt = rd(0x1e77c4) - mirroroffset

if rw(0x1E77F2) == 1  then
plflip = -1
else
plflip = 1
end
boxoffset = rw(plcellpnt + 0x0E)
lineset = rw(plcellpnt + 0x0C)
linenum = (rw(plcellpnt + 0x08) - 1)
scaler = rd(0x1e77b4)/65536

collisionbox(plcellpnt+boxoffset,px,py,Player_color,plflip)

if linenum >= 0 then
	for pos = 0,linenum,1 do
		interactline(plcellpnt+(lineset+pos*4),px,py,Intact_color,plflip)
	end
end

gui.text(8,8,"X,Y: " .. px .. ", " .. py)
drawaxis(px,py,8/scaler)

--Debug stuff
--gui.text(8,16,"BoxOff: " .. linenum)
--gui.text(32,64,"TEST: " .. hex(plcellpnt+lineset) )
gui.text(8,24,"Player Cell: " ..hex(plcellpnt))
--gui.text(8,32,"Box: " .. hex(plcellpnt + boxoffset))
--gui.text(8,16,"Test: " .. hex(boxoffset))
--gui.text(8,16,"Scale: " .. scaler)

----------------------------------------------------------
--Enemies
----------------------------------------------------------
--I haven't seen an object before this address 0x001E988C, yet 
enadr = 0x001E988C - 0x108

for en = 0,31,1 do

		enadr = enadr + 0x108
		local encellpnt=rd(enadr + 0x38) - mirroroffset
		local boxoffset = rw(encellpnt + 0x0E)
		local enx = (bit.band(rds(enadr + 0x04),0xFFFFFF00)/256) - camx
		local eny = (bit.band(rds(enadr + 0x08),0xFFFFFF00)/256) - camy  --0x1E999C0
	
		
		local pnt1 = rd(enadr) - mirroroffset
		local froze = rb(enadr + 0x56)
		local freezetimer = rw(pnt1 + 0x40)
		local active = rw(enadr + 0x2C)

if rw(enadr + 0x06) == 1  then
	enflip = -1
	else
	enflip = 1
end


		if active ~= 0 then
		collisionbox(encellpnt+boxoffset,enx,eny,Object_color,enflip)
		drawaxis(enx,eny,8)
		--gui.text(enx-32,eny - 64,"ENADR: " .. hex(enadr))
		
			if froze == 0x40 then
				gui.text(enx-32,eny - 56,"frz: " .. freezetimer)
			end
		
		end
	end
	
	
----------------------------------------------------------
--Platforms
----------------------------------------------------------

platadr = 0x1eca0C - 0x108

for plat = 0,15,1 do

	platadr = platadr + 0x108
	
		local cellpnt= rd(platadr + 0x38) - mirroroffset
		local pltx = (bit.band(rds(platadr + 0x04),0xFFFFFF00)/256) - camx
		local plty = (bit.band(rds(platadr + 0x08),0xFFFFFF00)/256) - camy
		local plactive = rw(platadr + 0x2C)
		local ptboxoffset = rw(cellpnt + 0x0E)
	
		if plactive ~= 0 then
		
			collisionbox(cellpnt+ptboxoffset,pltx,plty,Platfm_color,1)
			drawaxis(pltx,plty,8)

			--gui.text(pltx-32,plty - 64,"ADR: " .. hex(platadr))

		end
	end
end


function battle()	
	------------------------------------------------
	--Battle
	------------------------------------------------
	gui.text(40,40,"BATTLE")
	--
	---Players
	--Slot 1 Square
	ww(0xEDD74,rd(0xEDD78))
	
	--Slot 2 Triangle
	ww(0xEE430,rd(0xEE434))
	
	--Slot 3 Cross
	ww(0xEEAEC,rd(0xEEAF0))
	
	--Slot 4 Circle
	ww(0xEF1A8,rd(0xEF1AC))

	--]]
end

function world()
Chapter = rb(0x1E5C40)
period = rb(0x1E5C41)

gui.text(32,24,"Chapter: " .. Chapter)
gui.text(32,32,"Period: " .. period)



end

function drawaxis(x,y,axis_length)

gui.line(x+axis_length,y,x-axis_length,y,'yellow')
gui.line(x,y-axis_length,x,y+axis_length,{255, 128, 255, 255})

end


function collisionbox(adr,playerx,playery,color,flip)

local hval = rws(adr + 0x0) * flip
local vval = rws(adr + 0x2)
local hrad = rb(adr + 0x4) * flip
local vrad = rb(adr + 0x5)

	local x1 = (playerx + hval)
	local y1 = playery + vval
	local x2 = x1 + hrad
	local y2 = y1 + vrad
	
	
	--gui.line(playerx,playery,left,bottom) To help ID where the box is if your maths is wrong
	gui.box(x1,y1,x2,y2,color)

end

function interactline(adr,playerx,playery,color,flip)

local extend = 5 * flip

local lx1 = (playerx + rws(adr + 0x0) * flip) - extend
local ly1 = playery + rws(adr + 0x2) - extend
local lx2 = (playerx + rws(adr + 0x0) * flip) + extend
local ly2 = playery + rws(adr + 0x2) + extend
	
	gui.box(lx1,ly1,lx2,ly2,color)
end


function hex(val)
        val = string.format("%X",val)
		return val
end



while true do
Scene = rd(0x1DF370) --Replace with a read memory when i can find the difference between all the play fields
if Scene == 0x801AF3A8 then --If Dungeon
	dungeon()
else
	battle()
	--world()
end

	emu.frameadvance()
end
