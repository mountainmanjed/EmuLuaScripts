local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword
--p2=28C

hurtcolor = 0xFFFF0000

--[[
Projectiles
Player Activation need to hide hitboxes on Mysterious Lion's super

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

;Defense Table
075520: lea     $d5f24.l, A6
075526: move.w  ($190,A1), D0
07552A: lsl.w   #6, D0
07552C: adda.w  D0, A6
07552E: moveq   #$0, D0
075530: move.b  ($194,A1), D0
075534: andi.w  #$7c, D0
075538: lsr.w   #1, D0
07553A: adda.w  D0, A6

;Asm Start
0759C2: moveq   #$10, D2
0759C4: tst.w   $200094.l
0759CA: bmi     $759d2; branch if negative
0759CC: move.w  $200128.l, D2
0759D2: move.w  D2, D4
0759D4: lsr.w   #2, D4
;Block Check
0759D6: move.w  ($e,A1), D3
0759DA: andi.w  #$c, D3
0759DE: cmpi.w  #$8, D3
0759E2: bne     $75a22
075A22: tst.w   ($254,A0);Damage Boost Timer add 8 to scaler if active 
075A26: beq     $75a2a
075A2A: btst    #$3, ($19f,A0);Unknown flag subtract 2 from scaler
075A30: beq     $75a34
075A34: tst.b   ($1a0,A1);unknown adds 2 to scaler and more to base damage
075A38: beq     $75a68

;basic start
075A68: mulu.w  D2, D1
075A6A: add.w   D1, ($272,A1)
075A6E: move.w  (A6), D2
075A70: move.w  #$100, D3
075A74: sub.w   D2, D3
075A76: lsr.w   #1, D3
075A78: cmpi.w  #$2, $2060b6.l
075A80: bne     $75a84
075A84: move.w  #$100, D2
075A88: sub.w   D3, D2
075A8A: mulu.w  D2, D1
075A8C: lsr.l   #4, D1
075A8E: sub.w   D1, ($194,A1)

scaler is usually 16

Example 5LP in Thorsten vs Thorsten
scaler = 16
basedmg = 8
defense = 224
gives me 
128
16
30720/16
damage = 1920

dmprt1 = (scaler * basedmg)
dmprt2 = (256 - defense)/2
dmprt3 = (256 - dmprt2)*dmprt1
dmfinal = dmprt3/16

]]	


--[[
Extra Data
P1 Palette 0x2000BD 2&3 are boss palettes

--]]


function player()
proadr = 0x2017F0 - 0x7A
for proj = 0,15,1 do
proadr = proadr + 0x7A
local projx = scale(rws(proadr+0x06))
local projy = scale(rws(proadr+0x0A)) - 16
drawaxis(projx,projy,8,0xEE00DDFF)
if proj == 0 then
--ww(proadr+0x26,0x017C)
--ww(proadr+0x2A,0x071C)
end

end
dmgscaler = rw(0x200128)

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
	local p2id = rw(padr + 0x190 + 0x28C)
	local id2 = rw(padr + 0x60)
	local address = rd(0xD6164 + (id*4))
	local address2 = rd(address + (id2*4))
	local loop = rws(address2)
	local boxes = (address2 + 2) -8
	--Attack Boxes
	local atkmath = (loop+1)*8
	local atkaddr = atkmath + address2+4
	--Attack Data
	local dmgbase = rb(atkaddr + 0x0D)
	local dmgout1 = dmgbase*dmgscaler
		
	--Defense Data
	local basedef = 0xD5F24 + p2id*64
	local defsel = bit.band(rb(padr+0x194+0x28c),0x7C)/2
	local defval = rw(basedef + defsel)
	local defval2 = (256 - defval)/2
	local defval3 = 256 - defval2
	
	local damagef = (dmgout1*defval3)/16
	
	if pxflip == 0x02 then
		pflip = -1
	else
		pflip = 1
	end
	if pyflip == 1 then
	py = scale(rws(padr + 0x0A)) - scale(210)
	else
	py = scale(rws(padr + 0x0A)) - 16
	end

--Damage Details
	local boosttimer = rw(padr + 254)
	local blockcheck = bit.band(flag2,0x08)
	local attkcheck1 = bit.band(rb(padr+0x19F),0x08)
	local attkcheck2 = rb(padr+0x1A0)


if active == 0 then
drawaxis(px,py,scale(8))

gui.text(12 + p*168,20,"Life: " .. life)
gui.text(30 + p*200,222,"Meter: " .. meter)
--gui.text(32 + p*168,32,"Address: "  .. hexval(padr))
--gui.text(4 + p*168,64,string.format("TestAtk: %X",dmgpnt))
--attacks
--gui.text(4 + p*168,64,string.format("Defense1: %d",defval))
--gui.text(4 + p*168,64,string.format("Defense1: %d",defval))

if p == 0 then
	gui.text(12 + 168,32,string.format("2P Defense Base: %d",defval))
	gui.text(12 + 168,40,string.format("2P Defense Final: %d",defval3))
	
end


	
--Hurt
		if loop >= 0 then 
			for b = 0,loop,1 do
				boxes = boxes + 8
				colbox(boxes,px,py,pflip,pyflip,hurtcolor)
				end
			end
		
--Attack
	if p == 0 then
		if rw(0x2000E6) ~= 0 then
		colbox(atkaddr,px,py,pflip,pyflip,0xFF000000)
		gui.text(32 + p*168,32,string.format("DamageBase: %d",dmgbase))
		gui.text(32 + p*168,40,string.format("Dmgfinal: %d",damagef))
		
		
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
y = ply - scale(rws(boxadr + 0x4))--Only part messed up maybe calculation for player y changes
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
