print"For visible attack boxes paste this line into the debugger"
print"bp FFAFF4C0, 1, {maincpu.pd@(0x01000000)=a0; g}"
-- bp ff805a90, 1, {maincpu.pd@(0x01000000)=0x00000000; g}

--umk3 lua
local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword

--Global
axis_length = 4

function player1()

--Global
--This needs to be included on a loop. On final version.
camx = rws(0x20BB5C)
camy = rws(0x20BB14)

gui.text(160,240,"Cam: " .. camx .. "," .. camy)

--Data -size 0x176
local adr = 0x20C134 -- 0x10609A0

--Pointers
local movementpointer = pointer(rd(adr + 0x06)) -- 10609D0 -0x42
local pointer1 = pointer(rd(adr + 0x0E))
local pointer2 = pointer(rd(movementpointer + 0x34))
local pointer3 = pointer(rd(pointer1 + 0x14))

--Movement Memory Size 0x42
--[[
Movement Pointer - 
MovP + Offset - Size  - Data

MovP + 0x02   - Dword - Y Accel
MovP + 0x06   - Dword - X Speed
MovP + 0x0A   - Dword - Y Speed

MovP + 0x12   - Dword - X Location
MovP + 0x16   - Dword - Y location

]]

--P1 location
local p1x = rws(movementpointer + 0x12)
local p1y = rws(movementpointer + 0x16)


--if rw(0x20C424) ~= 0 then -- If life bars are active


--Display
	--Text
	gui.text(20,40,"X,Y: " .. p1x .. "," .. p1y)
	gui.text(148,26,"Life: " .. rw(adr + 0x18))
	gui.text(76,36,"Run: " .. rw(adr + 0x1A),0x00FF00FF)
	--gui.text(8,238,"Total Damage: " .. rw(0x020E7A4)) -- Changes Need to find the pointer to it.
	
	-- Axis
	local px = p1x - camx
	local py = p1y - camy

	gui.drawline(px,py+axis_length,px,py-axis_length)
	gui.drawline(px+axis_length,py,px-axis_length,py)
	
	--Boxes  
--
	test = rd(0x01000000/8)/8
	x1 = px + rws(test)
	x2 = x1 - rws(test + 0x04)
	y1 = py + rws(test + 0x02)
	y2 = y1 + rws(test + 0x06)
	
	gui.box(x1,y1,x2,y2,0xFF400060)
--]]
	--Debug
--	gui.text(20,48,"Movement: " .. hex(movementpointer) .. "," .. hex(movementpointer*8),0xDDCCEEFF)
--	gui.text(20,56,"Pointer1: " .. hex(pointer1) .. "," .. hex(pointer1*8) ,0xDDCCEEFF)
--	gui.text(20,64,"Graphics: " .. hex(pointer2) .. "," .. hex(pointer2*8) ,0xDDCCEEFF)
--	gui.text(20,72,"Pointer3: " .. hex(pointer3) .. "," .. hex(pointer3*8) ,0xDDCCEEFF)
--	gui.text(20,80,"Pointer4: " .. hex(pointer4) .. "," .. hex(pointer4*8) ,0xDDCCEEFF)
--	gui.text(20,88,"Pointer5: " .. hex(pointer5) .. "," .. hex(pointer5*8) ,0xDDCCEEFF)
--	gui.text(20,56,"Pointer6: " .. hex(pointer6) .. "," .. hex(pointer6*8) ,0xDDCCEEFF)
--	gui.text(20,56,"Pointer7: " .. hex(pointer7) .. "," .. hex(pointer7*8) ,0xDDCCEEFF)
end


function player2()
--Data
local adr = 0x20C2AA -- 0x10609A0

local movementpointer = pointer(rd(adr + 0x06)) -- 1061580
local pointer1 = pointer(rd(adr + 0x0E))
local pointer2 = pointer(rd(movementpointer + 0x34))
local pointer3 = pointer(rd(pointer1))
local pointer4 = pointer(rd(pointer3))

--Movement
local p1x = rws(movementpointer + 0x12)
local p1y = rws(movementpointer + 0x16)

--[[Cheats
	Life Refill only works on Subway
	if rw(0x020E7A4) == 0  then
	memory.writeword(adr + 0x18, 166)


	end
]]
--Text
	gui.text(212,40,"X,Y: " .. p1x .. "," .. p1y)
	gui.text(218,26,"Life: " .. rw(adr + 0x18))
	gui.text(296,36,"Run: " .. rw(adr + 0x1A),0x00FF00FF)
	

--Axis
	local px = p1x - camx
	local py = p1y - camy

	gui.drawline(px,py+axis_length,px,py-axis_length)
	gui.drawline(px+axis_length,py,px-axis_length,py)
	
--Boxes

--Debug
--	gui.text(212,48,"Movement: " .. hex(movementpointer) .. "," .. hex(movementpointer*8),0xDDCCEEFF)
--	gui.text(212,56,"Pointer1: " .. hex(pointer1) .. "," .. hex(pointer1*8) ,0xDDCCEEFF)
--	gui.text(212,64,"Graphics: " .. hex(pointer2) .. "," .. hex(pointer2*8) ,0xDDCCEEFF)
--	gui.text(212,72,"Pointer3: " .. hex(pointer3) .. "," .. hex(pointer3*8) ,0xDDCCEEFF)
--	gui.text(212,80,"Pointer4: " .. hex(pointer4) .. "," .. hex(pointer4*8) ,0xDDCCEEFF)
--	gui.text(212,88,"Pointer5: " .. hex(movementpointer) .. "," .. hex(0x20C13A*8) ,0xDDCCEEFF)
--	gui.text(212,96,"Pointer6: " .. hex(movementpointer) .. "," .. hex(0x20C13A*8) ,0xDDCCEEFF)
--	gui.text(212,104,"Pointer7: " .. hex(movementpointer) .. "," .. hex(0x20C13A*8) ,0xDDCCEEFF)
end

function unlocks()
--Unlock Characters
	if rw(0x205E22) ~= 0 then
		memory.writeword(0x20C43C,1)
		memory.writeword(0x20C43E,1)
		memory.writeword(0x20C440,1)
	end
end

function hex(val)
        val = string.format("%X",val)
		return val
end

function pointer(addr)
addr = addr/8
return addr
end

while true do
gui.register(function()
player1()
player2()

end)

unlocks()
emu.frameadvance()
end
