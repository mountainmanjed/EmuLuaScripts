rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

Mouse_Input = input.get()

screenx = 384
screeny = 224

winx = 0
winy = 24

function display()
gui.text(16,16,Mouse_Input.xmouse)
gui.text(114,16,Mouse_Input.ymouse)

gui.text(240,16,rws(0xff8850))
gui.text(260,16,rws(0xff8852))

window(winx,winy,68,128,"Player Data 0xFF8400")

end

function window(x,y,boxw,boxy,title)
--Comparing Window title to the box width and setting the width to be the larger one
if boxw < string.len(title) * 4.5  then
boxw = string.len(title) * 4.5 + x
else
boxw = boxw+x
end

gui.box(x,y,boxw,y + boxy,0x400000A0,0xFFFFFFFF)
gui.line(x,y+10,boxw,y+10)
windowbar(x,y,boxw)
gui.text(x+3,y+2,title)

--Window Postion
--gui.text(x + string.len(title) * 4 + 28,y+2,"X: " .. winx)
--gui.text(x + string.len(title) * 4 + 56,y+2,"Y: " .. winy)

playerdata(x+4,y+12,0xFF8400)
end

function playerdata(x,y,adr)
local px = rw(adr + 0x010)
local py = rw(adr + 0x014)
local anipnt = rd(adr + 0x1C)
local frametimer = rb(adr + 0x20)
--Animation data
local framecount = rb(anipnt)
local blockable = rbs(anipnt + 0x17)


--Attack
local atkpointer = rd(adr + 0x8C)
local attk = atkpointer + (rb(anipnt + 0x0A) * 0x20)
local redd = rb(bit.band(attk + 0x08),0x1F) 
local whtd = rb(bit.band(attk + 0x09),0x1F) + redd
local flag = rb(attk + 0x17)
--Text
gui.text(x,y,"X,Y: " .. px .. ", " .. py)
gui.text(x,y + 16,"Cell: " .. hex(anipnt))
gui.text(x,y + 24,"Frames: " .. frametimer .. "," .. framecount)
gui.text(x,y + 32,"Blockable: " .. blockable)
gui.text(x,y + 40,"Graphic PNT: " .. hex(rd(anipnt + 0x04)))

--Attack
gui.text(x,y+64,"Attack: " .. hex(attk))
gui.text(x,y+72,"RED Damage: " .. redd)
gui.text(x,y+80,"WHT Damage: " .. whtd)
gui.text(x,y+88,"Attack Flag: " .. hex(flag))
--gui.text(x,)
end

function windowbar(x,y,boxw,text)
Mouse_Input = input.get()
	local Return_Value = false
	gui.box(x, y + 1,boxw, y + 9,0xFF0000FF)--Show Collision

	if 	Mouse_Input.xmouse >= x and 
		Mouse_Input.xmouse <= boxw and 
		Mouse_Input.ymouse >= y - 1 and 
		Mouse_Input.ymouse <= y + 9 then

		if Mouse_Input.leftclick then
			winx = math.abs(x/2 + Mouse_Input.xmouse - boxw/2)
			winy = math.abs(((y-1)/2) + Mouse_Input.ymouse - ((y+9)/2))
			gui.box(x, y + 1,boxw, y + 9,0x00FFFFFF)
	    else
        	if not hold then
        	leftclickdown = false
			end
       	end	
	end
end

function hex(val)
        val = string.format("%X",val)
        return val
end

while true do
display()
emu.frameadvance()
end
