--Mainly shows distances when normals become far normals

local rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

function hud()
-- Player Data
adr = 0x108100

local px = rws(adr + 0x18) --rds(adr+0x18)/0x10000
local py = rws(adr + 0x20) --rds(adr+0x1C)/0x10000

local stun = rws(adr + 0x13E)
local life = rws(adr + 0x138)
local guard = rws(adr + 0x146)
local chardat = rd(adr + 0x1A6)

local walk_speed = rds(chardat)/0x10000
local jump_height = rds(chardat + 0x04)/0x10000

if px - rws(adr + 0x218) < 0 then
cmpx = rws(adr + 0x218) - px
else
cmpx = px - rws(adr + 0x218)
end

gui.text(160-string.len(cmpx)*2, 32,cmpx)
gui.text(48,48,hex(rb(0x10da40)))

gui.text(32,40,stun)
gui.text(32,32,guard) -- adr = padr + 0x1A6
local rangeA = rb(chardat + 0x0C)--2002 = 10E31E | pointer + 0x0C
local rangeB = rb(chardat + 0x0D)
local rangeC = rb(chardat + 0x0E)
local rangeD = rb(chardat + 0x0F)

--gui.text(32,32,walk_speed)
--gui.text(32,40,jump_height)

boxtext(48,8,rangeA,0xFF000080,0x600000ff)
boxtext(64,8,rangeB,0xFFFF0080,0xFF8000ff)
boxtext(80,8,rangeC,0x00FF0080,0x006000ff)
boxtext(96,8,rangeD,0x0040FF80,0x000060ff)
end

function boxtext(x,y,text,color1,color2)
boxw = 16
txtcw = 16/4
gui.box(x,y-8,x+16,y+8,color1,color2)
gui.text(x + txtcw,y-4,text)
end


function hex(val)
        val = string.format("%X",val)
        return val
end

emu.registerafter(function()
	hud()
end)
