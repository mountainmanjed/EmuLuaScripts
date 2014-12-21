--SFEX2 Plus Script
local rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword


Stage = 0x08
--Notes
--Stage Order
--[[
0x00 Intro
0x01 Lost Sea
0x02 Church
0x03 Tiger
0x04 Crowded Town
0x05 Train Station
0x06 Museum
0x07 Before Moon
0x08 Garuda Stage
0x09 Mountain Temple(Outside)
0x0A Amusement Park
0x0B Kairi Stage
0x0C Snow Land
0x0D Ken Stage
0x0E Refrigerator 
0x0F Shuttle
0x10 Jungle
0x11 Construction
0x12 Boss Stage
0x13 Void Bison 2
0x14 Space 1
0x15 Space 2
0x16 Air Port


8002C000
8002C004

--]]

--Camera Memory
--[[
Camera Controller 0x02AE10E

Camera X 0x02AE11E
Camera Y 0x02AE122
Camera Z 0x02AE136

Camera Rotation X 0x02AE142
Camera Rotation Y 0x02AE146
--]]

--[[
Ryu Fireball
4AE0C

4B2AC -- X origin

--]]

--Player Memory
--[[
P1 0x002B5100 
P2 + 1804

Byte Adr + 0x0003 = Palette
Byte Adr + 0x0004 = Character
Byte Adr + 0x0005 = Attack

Dword Adr + 0x0010 = X
Dword Adr + 0x0014 = Y
Dword Adr + 0x0018 = Z
Dword Adr + 0x001C = X(Mirrored)
Dword Adr + 0x0020 = Y(Mirrored)
Dword Adr + 0x0024 = Z(Mirrored)
Dword Adr + 0x0028 = X move
Dword Adr + 0x002C = Y move
Dword Adr + 0x0030 = Y move

Dword Adr + 0x0068 = Pointer to Opponent

Dword Adr + 0x0078 = Lighting Pointer

Word Adr + 0x0104 = Scale Z
Word Adr + 0x0108 = Scale Y
Word Adr + 0x0108 = Scale X
Word Adr + 0x012A = Scale Flag


Limb Section  Size D8


Byte ADR + 17A8 = Health

Dword ADR + 17B8 = OVL File
--[
  OVL Table
  Table + 0x30 = Movement
  
  Table + 0x34 = ???
  
  --Projectiles Character Dependant
	HEXNUMBR APOINTER
  ]

ADR + 17C0 = Model Pointer 
  
  
-----------
Body shperes
2b4ba0

Attack spheres
 2B4BD0
 
 0x2B5100 + 122C9EA
]]


function mainsetup()
--Stage Selection EX2+
--wb(0x02AE5B8,Stage)


--Mirror? 28ec68
charactermemory(0x2B5100,32,32) ---- Console 1E7FD2 | P2 187C
--charactermemory(0x2B5100 + 0x1804,324,32)


--Render
--ww(0x803e9d60 + 2,0x00F0)
--ww(0x803edeb0 + 2,0x0000)


--Timer
wb(0x02AE5BC, 0x63)



--Character Unlock
--wd(0x2fe430,0x03FFFFFF)

attack = rd(0x2B4BD0)+8
atlimb = rb(attack)
atsize = rb(attack+0x01)
atplcx = rws(attack + 0x2)
atplcz = rws(attack + 0x4)
atplcy = rws(attack + 0x6)

gui.text(8,124,"Attack Pointer: " .. hex(attack))
gui.text(8,132,"Limb ID: " .. hex(atlimb))
gui.text(8,140,"Size: " .. (atsize))
gui.text(8,148,"PLC X: " .. (atplcx))
gui.text(8,156,"PLC Z: " .. (atplcz))
gui.text(8,164,"PLC Y: " .. (atplcy))


--gui.text(300,124,"Attack Pointer: " .. hex(rd(0x2B4BD4)))


end

function charactermemory(adr,x,y)

--------------------------
--DATA-----DATA-----DATA--
--------------------------
local costume = rb(adr + 0x0003)
local character = rb(adr+ 0x0002)

local health = rb(adr + 0x17A8)
local meter = rb(adr + 0x17A9)

--Placement
local px = rws(adr + 0x0012)
local py = rws(adr + 0x0016)
local pz = rws(adr + 0x001A)

local xmov = (rds(adr + 0x0028)/0x10000) * -1
local ymov = rws(adr + 0x002E) * -1
local zmov = rws(adr + 0x0032) * -1


--Limb

--Pointers
local lighting_pointer = rd(adr + 0x0078)
local model_pointer = rd(adr + 0x17C0)

--Table Pointers
local charovl = rd(adr + 0x17B8)


--Table 1
local mov = rd(charovl + 0x30)

--Movement
local walkfor = rds(mov + 0x00)
local walkback = rds(mov + 0x04)

local jmp8h = rds(mov + 0x08)/0x10000
local jmp8g = rds(mov + 0x0C)/0x10000
local jmp8v = rws(mov + 0x10)

local jmp9h = rds(mov + 0x14)/0x10000
local jmp9g = rds(mov + 0x18)/0x10000
local jmp9v = rws(mov + 0x1C)

local jmp7h = rds(mov + 0x20)/0x10000
local jmp7g = rds(mov + 0x24)/0x10000
local jmp7v = rws(mov + 0x28)

--DISPLAY----------DISPLAY--
--TEXT-TEXT-TEXT-TEXT-TEXT--
----------------------------
gui.text(x-24,y,hex(character))
gui.text(x-8,y,hex(costume))
gui.text(x+100 ,y - 8,"Life: " .. health)
gui.text(x+80 ,y + 8,"Meter: " .. meter)

--Placement 
gui.text(x-24,y-32,"X: " .. px)
gui.text(x-24,y-24,"Y: " .. py)
gui.text(x-24,y-16,"Z: " .. pz)

gui.text(x+16,y-32,"X Move: " .. xmov)
gui.text(x+16,y-24,"Y Move: " .. ymov)
gui.text(x+16,y-16,"Z Move: " .. zmov)

--Pointers
gui.text(x - 24,y+192,"Lighting: " .. hex(lighting_pointer))
gui.text(x - 24,y+200,"Model: " .. hex(model_pointer))
gui.text(x - 24,y+208,"Character OVL: " .. hex(charovl))

--[[
--Movement Data
gui.text(x-24,y+160,"Move Pointer: " .. hex(mov))

gui.text(x-24,y+100,"Walk Speed F,B: " .. walkfor/16 ..", " .. walkback/16)
gui.text(x-24,y+108,"8 Jump H,G,V: " ..jmp8h ..", " .. jmp8g .. ", " .. jmp8v/16 )
gui.text(x-24,y+116,"9 Jump H,G,V: " ..jmp9h ..", " .. jmp9g .. ", " .. jmp9v/16 )
gui.text(x-24,y+124,"7 Jump H,G,V: " ..jmp7h ..", " .. jmp7g .. ", " .. jmp7v/16 )
]]

end

function limb()


end

function hex(val)
	val = string.format("%X",val)
	return val
end


while true do
mainsetup()
emu.frameadvance()
end 
