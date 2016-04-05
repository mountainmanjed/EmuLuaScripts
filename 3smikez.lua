--Short Cuts
local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

--[[
Mame RR allows Breakpoints and watchpoints
Offial Mame allows editing
06xxxxx Drop the 06 to get the rom location anything past 0x68xxxxx is on simms 2

rom 10 = simm 1.0 1.1 1.2 1.3
rom 20 = simm 2.0 2.1 2.2 2.3

interleaved like so if 
memory 00010203 04050607 08090A0B 0C0D0E0F
simms  S0S1S2S3 S0S1S2S3 S0S1S2S3 S0S1S2S3

excerpt from dammit's hitbox script
{	games = {"sfiii3"},
	player = {0x02068C6C, 0x2069104}, --0x498
	object = {initial = 0x02028990, index = 0x02068A96},
	screen = {x = 0x02026CB0, y = 0x02026CB4},
	match  = 0x020154A6,
	scale  = 0x0200DCBA,
	char_id = 0x3C0,
	ptr = {
		valid_object = 0x2A0,
		{offset = 0x2D4, type = "push"},
		{offset = 0x2C0, type = "throwable"},
		{offset = 0x2A0, type = "vulnerability", number = 4},
		{offset = 0x2A8, type = "ext. vulnerability", number = 4},
		{offset = 0x2C8, type = "attack", number = 4},
		{offset = 0x2B8, type = "throw"},
	},
},

Animation format 16 or 24 bytes
0x00 Frame count 8b
0x01 Unknown
0x02
0x03

0x04 Extra graphic 12b unknown4b
0x06 Cell 16b

0x08
0x0A Collsion Boxes 8b

0x0C
0x0D Cancels Binary flags below 
0x0E Projectile Spawn 8b
0x0F
Sometimes not used
0x10
0x11
0x12
0x13
0x14
0x15
0x16
0x17
0x18

Cancel Flags
0x80 ???
0x40 Supers
0x20 Specials 
0x10 ???
0x08 Target combos
0x04 Nomrals
0x02 Dash  
0x01 Super Jump

Fighting Sprite Cells
0x0000 Gill
0x0600 Alex
0x0C00 Ryu
0x1200 Yun
0x1800 Dudley
0x1E00 Necro
0x2400 Hugo
0x2A00 Ibuki
0x3000 Elena Has more later
0x3600 Oro
0x3C00 Yang
0x4200 Ken
0x4800 Sean
0x4E00 Urien
0x5400 Akuma
0x5A00 Chun li
0x6000 Makoto Has more later
0x6600 Q
0x6C00 No.12
0x7200 Remy

character order
00 Gill
01 Alex
02 Ryu
03 Yun
04 Dudley
05 Necro
06 Hugo
07 Ibuki
08 Elena
09 Oro
0A Yang
0B Ken
0C Sean
0D Urien
0E Akuma
0F Shin Cookie
10 Chun li
11 Makoto
12 Q
13 No.12
14 Remy

Whiff Normal tables


5EAA00 SA2 Akuma

Cell IDs
DE11 Chun Stage Table
DE5A Table items

4772f0 Yang SA2 graphic needs to be 60 not 50


]]
function main()
camx = rw(0x02026CB0)
camy = rws(0x02026CB4)

player(0x02068C6C)
--player(0x02069104)
end

function player(addr)

local flipx = rb(addr + 0x0A)

local hitfreeze = rw(addr + 0x44)
local plx =  192 + rws(addr + 0x64) - camx
local ply =  201 - rws(addr + 0x68) + camy

local life = rws(addr  + 0x9E)

--wb(addr  + 0x214,0xFF)
local animationpnt = rd(addr + 0x200)

local framecount= rb(addr + 0x214)
local cancels = rb(addr + 0x221)

local cpnt1 = rd(addr + 0x2A0)--Hurt boxes
local cpnt2 = rd(addr + 0x2A8)--Even more hurtboxes boxes
local cpnt3 = rd(addr + 0x2C8)--Attack boxes


local attkpnt = rd(addr + 0x2D8) 
--Attack data start pointer. Data appears to be 16bytes. LP is usually the first attack

local whiffdata1 = rw(addr + 0x2F2)--whiff meter build reads this

local id = rw(addr + 0x3C0)
local metpnt = rd(addr + 0x3F0)


if flipx ~=0 then 
flip = -1
else
flip = 1
end
--Displays

gui.text(2, 0,string.format("ADDR: %X",addr))
gui.text(2, 8,string.format("MET: %X",metpnt))
gui.text(64, 0,string.format("ANI: %X",animationpnt))

gui.text(2, 48,string.format("ATD: %X",attkpnt))
gui.text(2,16,string.format("ID  : %d",id))

--Hurt Boxes
collisionbox(cpnt1+0x00,plx,ply,0x00FF8040,flip)
collisionbox(cpnt1+0x08,plx,ply,0x00FF8040,flip)
collisionbox(cpnt1+0x10,plx,ply,0x00FF8040,flip)
collisionbox(cpnt1+0x18,plx,ply,0x00FF8040,flip)
--Even More Hurt Boxes
collisionbox(cpnt2+0x00,plx,ply,0xFFFF0040,flip)
collisionbox(cpnt2+0x08,plx,ply,0xFFFF0040,flip)
collisionbox(cpnt2+0x10,plx,ply,0xFFFF0040,flip)
collisionbox(cpnt2+0x18,plx,ply,0xFFFF0040,flip)
--Attack boxes
collisionbox(cpnt3+0x00,plx,ply,0xFF00FF40,flip)
collisionbox(cpnt3+0x08,plx,ply,0xFF00FF40,flip)
collisionbox(cpnt3+0x10,plx,ply,0xFF00FF40,flip)
collisionbox(cpnt3+0x18,plx,ply,0xFF00FF40,flip)
--I like CvS2/A3 setup more still

drawaxis(plx,ply,8,0xFF00FFFF,0xFFFF00FF)
end

function collisionbox(adr,playerx,playery,color,flip)

local xl = rws(adr + 0x0)
local xr = rws(adr + 0x2)
local yb = rw(adr + 0x4)
local yt = rw(adr + 0x6)

local left = playerx + xl * flip
local right = left + xr * flip
local top = playery - yb
local bottom = top - yt


	--gui.line(playerx,playery,left,bottom) To help ID where the box is if your maths is wrong
	gui.box(left,top,right,bottom,color)
end

function drawaxis(x,y,axis,color1,color2)
gui.line(x+axis,y,x-axis,y,color1)
gui.line(x,y+axis,x,y-axis,color2)

end

while true do
main()
emu.frameadvance()
end
