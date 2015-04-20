local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

function main()
playeradr = 0x400200

convert(playeradr+0x00, 12+(54*0), 4)
convert(playeradr+0x02, 12+(54*1), 4)
convert(playeradr+0x04, 12+(54*2), 4)
convert(playeradr+0x06, 12+(54*3), 4)
convert(playeradr+0x08, 12+(54*4), 4)

convert(playeradr+0x0A, 12+(54*0), 4+(42*1))
convert(playeradr+0x0C, 12+(54*1), 4+(42*1))
convert(playeradr+0x0E, 12+(54*2), 4+(42*1))
convert(playeradr+0x10, 12+(54*3), 4+(42*1))
convert(playeradr+0x12, 12+(54*4), 4+(42*1))

convert(playeradr+0x14, 12+(54*0), 4+(42*2))
convert(playeradr+0x16, 12+(54*1), 4+(42*2))
convert(playeradr+0x18, 12+(54*2), 4+(42*2))
convert(playeradr+0x1A, 12+(54*3), 4+(42*2))
convert(playeradr+0x1C, 12+(54*4), 4+(42*2))

convert(playeradr+0x1E, 12+(54*0), 4+(42*3))

gui.text(16,204,"Address: " .. hexval(playeradr))
end

function convert(adr,x,y)

	red1 = bit.band(memory.readword(adr), 0x4000)/0x4000
	red2 = (bit.band(memory.readword(adr), 0x0F00))/0x080
	red = red1 + red2
	
	green1 = (bit.band(rw(adr), 0x00F0))/0x8
	green2 = (bit.band(rw(adr), 0x2000))/0x2000
	green = green1+green2
	
	blue1 = (bit.band(rw(adr), 0x000F))*2
	blue2 = (bit.band(rw(adr), 0x1000))/0x1000
	blue = blue1 + blue2
	
	--555
	outr = red*0x400
	outg = green * 0x20	
	outb = blue
	out = outr + outg + outb + 0x8000
	
	color = {red*8,green*8, blue*8} 
	
gui.text(x,y,"NeoGeo: " .. hexval(rw(adr)))	
gui.text(x,y+8,"R: " .. red)
gui.text(x,y+16,"G: " .. green)
gui.text(x,y+24,"B: " .. blue)
gui.text(x,y+32,"RGB555: " .. hexval(out))

gui.box(x+22,y+8,x+42,y+28,color)

end


function hexval(val)
        val = string.format("%X",val)
		return val
end

emu.registerafter(function()
main()

end)
