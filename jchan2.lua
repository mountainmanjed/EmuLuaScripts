local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword

hurtcolor = 0xFFFF0000

--[[
Need to do
Missing Yflip Used on some specials especially Drunken Jackie's Raising Tackle.
Projectiles
Player Activation need to hide hitboxes on Mysterious Lion's Super

]]

--[[
Hurt Box ASM
074CA8: lea     $d6164.l, A2
074CAE: movea.l A2, A3
074CB0: move.w  ($190,A0), D0
074CB4: add.w   D0, D0
074CB6: add.w   D0, D0
074CB8: movea.l (A2,D0.w), A2
074CBC: move.w  ($60,A0), D0

Attack Box Asm
075552: move.w  (A2)+, D0
075554: bmi     $7555c
075556: addq.w  #1, D0
075558: lsl.w   #3, D0
07555A: adda.w  D0, A2; 0xEA436
07555C: move.w  (A2)+, D7
]]	


--[[
Extra Data
P1 Palette 0x2000BD 2&3 are boss palettes

--]]


function player()
padr = 0x200F82 - 0x28C
for p = 0,1,1 do
	padr = padr + 0x28C
	local px = scale(rws(padr + 0x06))
	local life = rws(padr+0x194)
	local meter = rw(padr+0x27E)
	local flag1 = rb(padr + 0x04)
	local flag2 = rb(padr + 0x0E)
	local flag3 = bit.bxor(flag2,flag1)
	local active = bit.band(flag2,0x40)/0x40
	local pyflip = bit.band(flag3,0x01)
	local pxflip = bit.band(flag3,0x02)
	--Hurt boxes Data
	local id = rw(padr + 0x190)
	local id2 = rw(padr + 0x60)
	local address = rd(0xD6164 + (id*4))
	local address2 = rd(address + (id2*4))
	local loop = rws(address2)
	local boxes = (address2 + 2) -8
	--Attack Boxes
	local atkmath = (loop+1)*8
	local atkaddr = atkmath + address2+4

	if pxflip == 0x02 then
		pflip = -1
	else
		pflip = 1
	end
	if pyflip == 1 then
	py = scale(rws(padr + 0x0A)) - 210
	else
	py = scale(rws(padr + 0x0A)) - 16
	end

if active == 0 then 
drawaxis(px,py,scale(8))

gui.text(12 + p*168,20,"Life: " .. life)
gui.text(30 + p*200,222,"Meter: " .. meter)
gui.text(32 + p*168,32,"Address: "  .. hexval(padr))
	
--Hurt
		if loop >= 0 then 
			for b = 0,loop,1 do
				boxes = boxes + 8
				colbox(boxes,px,py,pflip,pyflip,hurtcolor)
				end
			end
		
--Attack
	if p == 0 then
		gui.text(8,64,pyflip)
		if rw(0x2000E6) ~= 0 then
		colbox(atkaddr,px,py,pflip,pyflip,0xFF000000)
		end
	else
		if rw(0x2000E4) ~=0 then
		colbox(atkaddr,px,py,pflip,pyflip,0xFF000000)
		end
	end
	end
	end
end


function colbox(boxadr,plx,ply,flip,yflip,color)
if yflip == 0 then
x = scale(rws(boxadr + 0x0)) * flip + plx 
w = x + scale(rws(boxadr+ 0x2)) * flip
y = (scale(rws(boxadr + 0x4)) + ply)
h = y + scale(rws(boxadr + 0x6))
else 
x = scale(rws(boxadr + 0x0)) * flip + plx 
w = x + scale(rws(boxadr+ 0x2)) * flip
y = ply - scale(rws(boxadr + 0x4))
h = y - scale(rws(boxadr + 0x6))
end
--gui.drawline(plx,ply,x,y) Debug
gui.box(x,y,w,h,color)

end

function drawaxis(x,y,axis,color)
gui.line(x+axis,y,x-axis,y,color)
gui.line(x,y+axis,x,y-axis,color)
end

function hexval(val)
	val = string.format("%X",val)
	return val
end

function scale(var)
	var = var*(0x140/rw(0x200184))
	return var
end

emu.registerafter(function()
	player()
--	gui.clearuncommitted()
end)
