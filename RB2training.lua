local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword
auto = 1

function main()
timercheat(0x107C28)
--0x100400

health(0x10048B,56,20,0xC0)
health(0x10058B,228,20,0xC0)
meter(0x1004BC,40,200,60)
meter(0x1005BC,248,200,60)

--	wb(0x100412,0x0F) -- P1 CP
--	wb(0x100512,0x0F) -- P2 CP

--playermem(0x100400,16,28)

end

function playermem(adr,x,y)
--Size 0x100
--local PNT = rd(adr)
--[[
0x00 some pointer
0x04 Always 0x0500
0x06 
0x08 
0x0A 
0x0C Pointer that changes if an attack lands
0x12 Cpu flag = 0x0F
0x13 Controller
0x14
0x16

0x58 Flip bit(0x80)

0x6A Frame table pointer only points to idle animations
0x6E Counter

0x9A Projectile Pointer

0xFE

0x
]]

local px = rw(adr + 0x20) --+ (rw(adr + 0x22)/0x10000)
local py = rw(adr + 0x28) --+ (rw(adr + 0x2A)/0x10000)

local walkspds = rws(adr + 0x34) + (rw(adr + 0x36)/0xFFFA)
--local walkfwd = rws(adr + 0x40) + (rw(adr + 0x42)/65530)

gui.text(x,y,px)
gui.text(x,y+16,walkspds)


end

function health(adr,x,y,maxhealth)
	gui.text(x,y,"Life: " .. rb(adr),0x00FF00FF)

	if rb(adr) <= 32 then
		wb(adr, maxhealth)

	
	end
end

function meter(adr,x,y,refill)
gui.text(x,y,"Meter: " .. rb(adr))

	if auto == 1 then
		if rb(adr) == 0 then
		--	wb(adr, refill)
		end
	end
end

function timercheat(adr)
--Timer
wb(adr,0x99)

end

gui.register(function()
main()
end)
