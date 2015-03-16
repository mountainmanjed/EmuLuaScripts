local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

function main()
--Camera
camx = rw(0xFFA728)
camy = rw(0xFFA72A)
gui.drawtext(8,32,"Cam X,Y: " .. camx .. ", " .. camy)
--ww(0xFFA91A,1000)
superjar = rw(0xFFA91A)
if superjar ~= 0 then
gui.text(272,32,superjar)
end
--[[
--Toejam
tjx = rws(0xFF8DDC)
tjy = rws(0xFF8DE4)
tjlife = rw(0xffa92a)

gui.drawtext(8,40,"TJ X,Y: " .. tjx .. ", " .. tjy)
drawaxis(tjx-camx,tjy-camy,8)
--Earl
bex = rws(0xff8E5C)
bey = rws(0xFF8e64)

gui.drawtext(8,48,"BE X,Y: " .. bex .. ", " .. bey)


drawaxis(bex-camx,bey-camy,8)
]]
--Other Sprites
itemadr = 0xFF805C - 0x80
for i = 0,63,1 do
itemadr = itemadr + 0x80
local itemx = rws(itemadr) - camx
local xspeed = rws(itemadr + 0x02)
local maxxspeed = rws(itemadr + 0x06)

local itemy = rws(itemadr + 0x08) - camy
local yspeed = rws(itemadr + 0x0A)
local maxyspeed = rws(itemadr + 0x0E)

--Extra data
local itemu = rb(itemadr + 0x10)
local titemx = rws(itemadr) 
local titemy = rws(itemadr + 0x8)

local pnt1 = rd(itemadr + 0x2A)
local pnt2 = rd(itemadr + 0x2E)
local pnt3 = rd(itemadr + 0x3C)
local active = bit.band(rb(itemadr + 0x4B),0x01)

local hboxx = 8--rbs(pnt2 + 0x04)

local cboxx1 = rbs(pnt2 + 0x01)
local cboxx2 = rbs(pnt2 + 0x02)

local boxy = rbs(itemadr + 0x47)--rbs(pnt2 + 0x03) -- bp 21120

if active ~= 0 then
--gui.text(itemx-32,itemy - 64, hexval(itemadr))
--gui.text(itemx-32,itemy - 56, hexval(pnt1))
--gui.text(itemx-32,itemy - 48, hexval(pnt2))

gui.box(itemx+cboxx2,itemy+boxy,itemx+cboxx1,itemy,0x00FFFF00)
gui.box(itemx+hboxx,itemy-boxy,itemx-hboxx,itemy,0xFFFF0000)
gui.text(itemx-16,itemy + 8, titemx .. ", " .. titemy)

--gui.drawline(itemx,itemy-ytest,itemx,itemy,0xFFFF00FF)

drawaxis(itemx,itemy,4)
end

end



end


function drawaxis(x,y,axis,color)

gui.line(x+axis,y,x-axis,y,color)
gui.line(x,y+axis,x,y-axis,color)

end

function hexval(val)
	val = string.format("%X",val)
	return val
end

emu.registerafter(function()
main()

end)
