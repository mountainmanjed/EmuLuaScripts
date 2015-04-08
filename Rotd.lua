--[[
rotdredone
print("P1 Boxes")
print("bp 6A3A4, 1, {maincpu.pd@(0x100340)=a2; g}")
print("bp 69A92, 1, {maincpu.pd@(0x100348)=a2; g}")

print("")
print("P2 Boxes")
print("bp 6A3EC, 1, {maincpu.pd@(0x100380)=a3; g}")
]]
local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte ,memory.writeword ,memory.writedword

boxcolors = {
0x00FF0000,
0xFFFF0000,
0xFF000000,
0xFF000000,

}

function display()
--Timer Cheat
wb(0x106B11,99)

--Data
camx = rws(0x106B9C)
camy = 236 - rws(0x106BA0)

local actpl=0x1023D2 + 0x178

for i = 0,1,1 do
	actpl = actpl - 0x178

	local px = rw(actpl + 0x16) - camx
	local py = camy - rw(actpl + 0x1A)
	local box1 = rd(actpl + 0x64)
	local life = rw(actpl + 0xFC)
	local redlife = rw(actpl + 0x100)
	local maxlife = rw(actpl + 0x104)
	local tagtime = rw(actpl + 0x112)
	local partner = actpl + 0x2F0
	gui.text(0+i*128,0,"ADR: " .. hexval(actpl))
	--[[
	01934A: movea.l ($4e,A6), A0
	018ECE: move.b  (A0)+, D0
	018ED0: lsl.w   #2, D0
	019164: addq.l  #1, A0	
	019166: move.w  (A0)+, D0
	019174: movea.l ($60,A6), A1
	firstA0 = rd(actpl + 0x4E)
	d0rw = rw(0x44+actpl)*4
	pushadr = rd(actpl + 0x60) + d0rw
	boxadr = rd(pushadr)
	]]



	
	if bit.band(rb(actpl + 0x55),0x01) == 1 then
		pflip = 1
		else
		pflip = -1
	end
	
	--Display
		gui.text(36 + i * 200,12,"Life: " .. life .. "|" .. maxlife)
		gui.text(36 + i * 200,20,"Red Life: " .. redlife,'red')
		gui.text(48 + i * 186,40,"Tag: " .. tagtime .. "/40")
		--gui.text(48 + i * 186,48,flip)
		drawaxis(px,py,16)
		
		--Boxes
		local box1 = rd(actpl+0x4E)
		
		if i == 0 then
		test = rd(0x100340)
		gui.text(8,96,hexval(box1))
		gui.text(8,104,hexval(test))
			pushadr = rb(test)*4
		--end
		boxadr = actpl + 0x60
		for boxes = 0,4,1 do
		boxadr = boxadr + 0x4
		gui.text(8,48 + boxes*8,hexval(rd(boxadr)))
		
		colbox(rd(boxadr),px,py,pflip,boxcolors[boxes+1])
		end
		--[[
		gui.text(8,132,hexval(boxadr))
		gui.text(8,140,hexval(box1))
		gui.text(8,148,hexval(rd(0x100340)))

		--gui.text(8,116,hexval(rd(0x100340)))
		--gui.text(32+i*182,80,hex(rd(box1 + 0x04)),0x00FF0020)
		
		colbox(box1,px,py,pflip,0xFFFF0000)
		colbox(rd(0x100340),px,py,pflip,0x008F8000)
		]]
	--	colbox(rd(0x100340),px,py,pflip,0x00FF0020)
		end
		
		--colbox(rd(box1 + 0x08),px,py,pflip,0xFFFF0020)
	
		
		--colbox(rd(box1 + 0x0C),px,py,pflip,0xFF000000)
		--gui.text(32+i*182,80,hex(rd(box1 + 0x0C)),0xFF0000FF)
		
		if i == 0 then
		--colbox(rd(0x100340),px,py,pflip,0x00FF0020)
		--colbox(rd(0x100348),px,py,pflip,0xFF000000)
		end
		
	--Cheats
	healthcheat(actpl + 0xFC, 32)

	end

end

function healthcheat(adr,refill)
local full = rw(adr + 0x08)

	if rw(adr) <= refill then
		ww(adr,full)
		ww(adr + 0x04,full)
	end
end

function drawaxis(x,y,axis_length)

gui.line(x+axis_length,y,x-axis_length,y,'yellow')
gui.line(x,y-axis_length,x,y+axis_length,'red')

end

function colbox(adr,plx,ply,flip,color)
	
	x1 = plx - rws(adr + 0x00) * flip
	x2 = x1 - rw(adr + 0x04) * flip
	y1 = ply + rws(adr + 0x02)
	y2 = y1 + rw(adr + 0x06)
	
	gui.box(x1,y1,x2,y2,color)
end

function hexval(val)
        val = string.format("%X",val)
		return val
end

emu.registerafter(function()
display()

end)
