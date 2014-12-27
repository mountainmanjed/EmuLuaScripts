--Breakers Revenge
local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword


function player()


camx = rw(0x103A2A)
camy =  rw(0x103A30)*2
camy2 = rw(0x103a28) -- Makes the axis work on most of stages instead of 1

adr = 0x10715C - 0x560 

	for pl = 0,1,1 do
		adr = adr + 0x560

		local life = rw(adr + 0x1F2)
		local stun = rw(adr + 0x1F8)
		local stunmax = rw(adr + 0x1FA)
		local px = rw(adr + 0x20E)
		local py = rw(adr + 0x212)
		gui.text(16 + pl*228,10,"Address: " .. hex(adr))
		gui.text(16 + pl*248,18,"Life: " .. life)
		gui.text(8 + pl*240,44,"Stun: " .. stun .. "/" .. stunmax,'yellow')
		gui.text(8 + pl*240,36,"X,Y: " .. px .. "," .. py)

		--Showing on screen
		local plx =  px - camx
		local ply = camy2 + py - camy
			if rb(adr + 0x208) == 0 then
				plflip = 1
			else
				plflip = -1
			end
	
	drawaxis(plx,ply,8)

--	test(rd(adr + 0x2dc))
	--Hitboxes
	boxes = 0

	repeat boxes = boxes + 1
	until rb(rd(adr + 0x2dc) + (boxes * 5)) == 0x00
	--gui.text(64 + pl*128,64,pl .. " Number of boxes: " .. boxes)
			for nbox = 0,boxes -1,1 do
			colbox(plx,ply,rd(adr + 0x2DC)+ nbox*5,plflip)
		end
	end
end


function colbox(x,y,adr,flip)
	--Commented part is what the debug version used
	
	local hurt1   = bit.band(rb(adr),0x01) -- Yellow
	local hurt2   = bit.band(rb(adr),0x02) -- Green
	local proinv  = bit.band(rb(adr),0x04) -- Blue
	local flag08  = bit.band(rb(adr),0x08) -- Blank
	
	local invul   = bit.band(rb(adr),0x10) -- White
	local clash   = bit.band(rb(adr),0x20) -- White
	local attack1 = bit.band(rb(adr),0x40) -- Red(Sometimes it doesn't show)
	local attack2 = bit.band(rb(adr),0x80) -- Red
	
	local outred = hurt1*256
	local outgreen = hurt2*128
	local outblue = proinv*64
	local outalpha = 128 - invul*4

	local fillred = attack1*4
	local fillgreen = clash*8
	local fillblue = attack2*2
	local fillalpha = 80
	
	local outline = {outred, outgreen, outblue, outalpha}
	local fill = {fillred ,fillgreen ,fillblue , fillalpha}


	x1 = x + (rbs(adr+3)*2) * flip
	x2 = x + (rbs(adr+4)*2) * flip 
	y1 = y + (rbs(adr+1)*2)
	y2 = y + (rbs(adr+2)*2)
	
	if rb(adr) ~= 0 then
	gui.box(x1,y1,x2,y2,fill,outline)
	--gui.text((x1 + x2)/2 , (y1 + y2)/2,  hex(rb(adr)))
	
	end
end

function drawaxis(x,y,axis)

gui.line(x+axis,y,x-axis,y,'yellow')
gui.line(x,y-axis,x,y+axis,'red')

end

function hex(val)
        val = string.format("%X",val)
		return val
end

emu.registerafter(function()
player()
end)
