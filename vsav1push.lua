local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

--[[
02760A: 102E 0170                  move.b  ($170,A6), D0;
02760E: 0C00 0008                  cmpi.b  #$8, D0; compare counter to 8
027612: 6418                       bcc     $2762c; if 8 then branch to pushblock

;Rng comparison if you failed to get 8 inputs
027614: E548                       lsl.w   #2, D0;Multiply Push Block counter by 4
027616: 41FA 1738                  lea     ($1738,PC), A0; ($28d50);set up the table at 28d50
02761A: 2430 0000                  move.l  (A0,D0.w), D2; Read the Table + pbcounter*4
02761E: 4EB9 0001 4E8A             jsr     $14e8a.l;RNG FUNCTION Writes to D0
027624: 0240 001F                  andi.w  #$1f, D0;extract any thing below 32 from rng value

027628: 0102                       btst    D0, D2;Compare RNG with value from table
02762A: 673C                       beq     $27668;
]]

pushtable = {
"00000000000000000000000000000000",--0x00000000,--00
"00000000000000000000000000000000",--0x00000000,--01
"00000000000000000000000000000000",--0x00000000,--02
"00000000000000000000000011111111",--0x000000FF,--03
"00000000000000001111111111111111",--0x0000FFFF,--04
"00000000111111111111111111111111",--0x00FFFFFF,--05
"11111111111111111111111111111111",--0xFFFFFFFF,--06
"11111111111111111111111111111111",--0xFFFFFFFF,--07
"11111111111111111111111111111111",--0xFFFFFFFF --08;Not actually on the table
}

function main()
rng = rb(0xFF80D5)
bitrng = bit.band(rng,0x1F)
padr= 0xFF8400
pbc = rb(padr+ 0x170)
pbtimer = rb(padr + 0x1ab)
binaryview(bitrng,pbc)

gui.box(16,24,16+pbtimer*4,30,0xFF0000FF,0xFFFFFFFF)

gui.text( 48,198,string.format("PB: %02X",pbc))
gui.text( 84,198,string.format("Timer: %02X",pbtimer))
gui.text(128,198,string.format("RNG: %02X",bitrng))
end


function binaryview (val,pbc)
gui.text(16,32,pushtable[pbc+1])

place = val*4

gui.text(140-place,40,'^')

end

while true do
main()
emu.frameadvance()
end
