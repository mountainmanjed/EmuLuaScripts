local rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

emu.registerbefore(function()
cell = 0
rest = 0

end)

function main()
padr = 0xFF8400
--Lilth Standing 0x22F964 ~ 0x22FB2C 0x80
--Lilith Far LP 0x234946 FC ~ 0x234976 LC 0x40
--Lilith Crouch Idle 22FD90 ~ 230048 0x80
--Jedah 248C68~2490D0 0x80
--Aulbath 1D9024 1D90CC = 8 cells
--7,7,7,7,7,7,7,7 = 56 


local anipnt = rd(padr + 0x01C)
local frametimer = rb(padr + 0x020)
local hitstop = rb(padr + 0x05C)
local attack = bit.band(rb(padr + 0x105),0x01)

gui.text(8,40,"Anipnt: " .. hexval(anipnt))
gui.text(8,48,"FC: " .. frametimer)
gui.text(8,56,"Hit Stop: " .. hitstop)

if bit.band(rb(anipnt+(cell*0x18)+1),0x80) ~= 0x80 then
		repeat cell = cell + 1
		until bit.band(rb(anipnt+(cell*0x18)+1),0xC0) ~= 0x00 -- or bit.band(rb(anipnt+(cell*0x18)+1),0x40) == 0x40
	else
		cell = 0
	end


gui.text(8,64,"Cells left: " .. cell)

for ani = 0,cell-1,1 do
	if cell > 1 then
	rest = rest + rb(anipnt)
	elseif cell == 1 then
	rest = rb(anipnt)
	else
	rest = 0
end

end
gui.text(8,72,"Frames Left: " .. rest)
local boxx = frametimer+rest
gui.text(8,80,"Box Length: " .. boxx)
gui.box(16+boxx,166,16,170,0xFFFFFFFF,0x000000FF)
gui.line(16,164,16,172,"red")
end

function hexval(val)
	val = string.format("%X",val)
	return val
end

emu.registerafter(function()
main()

end)
