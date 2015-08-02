local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

function main()
--[[
7204 Sodom Stage Check why I dunno

154F0

1B218 + 0x0A ????
1B29C + 0x14 8x8 Layer programming
1BBEE + 0x14 16x16 layer programming
1C20C + 0x3C 32x32 Layer programming
1E1FC + 0x08 ?
1E95E + 0x06 ?

1CBA4 -- Nothing

Tile Maps		| Table Location
1CC2C -- 8x8	| 1D986
1D0DE -- 16x16	| 1DA7E
1D534 -- 32x32	| 1DC36


1D1CC fills FF8240 ~ FF8244 with FFFF why? i dunno
1D60E fills FF8240 ~ FF8244 with FFFF why? i dunno
1CD42 fills FF8240 ~ FF8244 with FFFF why? i dunno


]]
--ww(0xff8100,00)

--SFZ2A
stageid = rw(0xFF8100)  
--stageid = rb(0xFF8167)*2 -- Stage Select
--stageid = rb(0xFF8482)*2 -- character id

--Sprites
part1 = rw(2 + 0x01F4D8 + 0x5C + stageid)
spriteadr = 2 + 0x01F4DC + 0x58 + part1

--
bg1p1 = rw(0x01B29C + 0x16 + stageid)
bg1p2 = 0x01B2a0 + 0x12 + bg1p1

bg2p1 = rw(0x1BBEE + 0x14  + 0x2 + stageid)
bg2p2 = 2 + 0x1BBF2 + 0x10 + bg2p1

bg3p1 = rw(0x1C20C + 0x3C  + 0x2 + stageid)
bg3p2 = 2 + 0x1C210 + 0x38 + bg3p1

gui.text(8,8,string.format("Stage ID: %02X",stageid))
gui.text(8,16,string.format("8  Program: %06X",bg1p2))
gui.text(8,24,string.format("16 Program: %06X",bg2p2))
gui.text(8,32,string.format("32 Program: %06X",bg3p2))

gui.text(240,16,string.format("BG  Sprites: %06X",spriteadr))
gui.text(240,24,"8  Tile Map: 01D986")
gui.text(240,32,"16 Tile Map: 01DA7E")
gui.text(240,40,"32 Tile Map: 01DC36")


end


emu.registerafter(function()
main()

end)
