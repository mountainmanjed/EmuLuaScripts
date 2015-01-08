local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte ,memory.writeword ,memory.writedword

--[[
ASM
079036: move.b  ($12c,A6), D1
07903A: ext.w   D1
07903C: add.w   D1, D0
07903E: add.w   D1, D0

079040: cmpi.b  #$2a, ($55,A6)
079046: beq     $7908c
079048: cmpi.b  #$46, ($55,A6)
07904E: beq     $7908c
079050: cmpi.b  #$32, ($55,A6)
079056: beq     $7908c
079058: cmpi.b  #$36, ($55,A6)
07905E: beq     $7907a
079060: cmpi.b  #$30, ($55,A6)
079066: bne     $7909e

07909E: move.w  ($34,PC,D0.w), D1
0790A2: move.b  ($1fd,A6), D0
0790A6: jsr     $524e.w
00524E: movea.l #$100088, A4
005254: bra     $525c
00525C: move.b  ($391,A6), D6
005260: tst.b   ($3bd,A6)
005264: beq     $5272
005272: tst.b   ($38e,A6)
005276: beq     $5282
005278: tst.b   ($3b6,A6)
00527C: beq     $5282
005282: ext.w   D6
005284: lsl.w   #2, D6
005286: movea.l (A4,D6.w), A4
00528A: jmp     (A4)
10FF1C: move.w  ($28,PC,D1.w), D1
10FF20: lea     ($24,PC,D1.w), A0
10FF24: ext.w   D0
10FF26: add.b   D0, D0
10FF28: move.w  (A0,D0.w), D0
10FF2C: lea     (A0,D0.w), A0
10FF30: move.l  A0, ($1a,A6)
]]

function main()

padr = 0xFF884E
	
	-- move.b  ($12c,A6), D1
	local oddhit = rb(padr + 0x12C)
	
	-- add.w   D1, D0 & add.w   D1, D0
	local firstD0 = oddhit + oddhit
	
	-- move.w  ($34,PC,D0.w), D1 --1A or 1C
	local tableval1 = rw(0x0790D4 + firstD0)

	-- move.b  ($1fd,A6), D0
	local secondD0 = rb(padr + 0x1FD)
	
	-- move.b  ($391,A6), D6
	local charid = rb(padr + 0x391)
	
	-- lsl.w   #2, D6
	local charid4 = charid * 4
	
	-- movea.l (A4,D6.w), A4
	local enemycharstart = rd(0x100088 + charid4) 
	
	-- move.w  ($28,PC,D1.w), D1
	local base = rw(0x2A + enemycharstart + tableval1)  
	
	-- lea     ($24,PC,D1.w), A0; add 4 cause of PC address has changed
	local adr1 = (0x2A + enemycharstart + base)
	
	-- add.b   D0, D0
	local D0p2 = secondD0 + secondD0
	
	-- move.w  (A0,D0.w), D0
	local D0p3 = rw(adr1 + D0p2)

	-- lea     (A0,D0.w), A0
	local finaladr = adr1 + D0p3
	
	gui.text(210,32,"Odd Hit: " .. oddhit)
	gui.text(210,40,"TableVal1: " .. hexval(tableval1))
	gui.text(210,48,"SecondD0: " .. hexval(secondD0))
	gui.text(210,56,"Char ID: " .. charid)
	gui.text(210,64,"Enemy Code Start: " .. hexval(enemycharstart))
	gui.text(210,72,"TableVal2: " .. hexval(base))
	gui.text(210,80,"Address1: " .. hexval(adr1))
	gui.text(210,88,"D0 P3: " .. hexval(D0p3))
	gui.text(210,96,"finaladr: " .. hexval(finaladr))
	
end

function hexval(val)
        val = string.format("%X",val)
		return val
end

gui.register(function()
main()

end)
