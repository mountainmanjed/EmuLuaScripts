--Arika Arcade Fighters Script
local rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

neutral = {
"Stand",
"Crouch",
"Knockdown",
"Air",
}
profile = {
{	games = {"sfex"},
	address = {
		player	= 0x802DCCF8,
		timer	= 0x802D7D44,
	},
		offset = {
		character	= 0x0002,
		color 		= 0x0003,
		
		xplace		= 0x0010,
		yplace		= 0x0014,
		zplace		= 0x0018,
		
		xmove		= 0x0028,
		ymove		= 0x002C,
		zmove		= 0x0030,
	
		lighting	= 0x0078,
	
		animation	= 0x01F8,
		
		ntrlst		= 0x143F,
		health		= 0x1440,
		meter		= 0x1441,
	},
},
{	games = {"sfexp"},
	address = {
		player	= 0x80323588,
		timer	= 0x8031D5CC,
	},
	offset = {
		player2		= 0x1474, 
		character	= 0x0002,
		color 		= 0x0003,
		
		xplace		= 0x0010,
		yplace		= 0x0014,
		zplace		= 0x0018,
		
		xmove		= 0x0028,
		ymove		= 0x002C,
		zmove		= 0x0030,
		
		lighting	= 0x0078,
		
		animation	= 0x01F8,
		
		ntrlst		= 0x145B,
		health		= 0x145C,
		meter		= 0x145D,
		ovl			= nil
	}
},
{	games = {"sfex2"},
	address = {
		player	= 0x802904B8,
		timer	= 0x80289C04,
	},
	offset = {
		player2		= 0x171C,
		character	= 0x0002,
		color 		= 0x0003,
		
		xplace		= 0x0010,
		yplace		= 0x0014,
		zplace		= 0x0018,
		
		xmove		= 0x0028,
		ymove		= 0x002C,
		zmove		= 0x0030,
		
		lighting	= 0x0078,
		
		animation	= 0x01FC,

		ntrlst		= 0x170B,	
		health		= 0x170C,
		meter		= 0x170D,
		ovl			= 0x171C,
	}
},
{	games = {"sfex2p"},
	address = {
		player	= 0x802B5100,
		timer	= 0x802AE5BC,
		unlocks	= 0x002FE430,
	},
	offset = {
		player2		= 0x1804,
		character	= 0x0002,
		color 		= 0x0003,
		
		xplace		= 0x0010,
		yplace		= 0x0014,
		zplace		= 0x0018,
		
		xmove		= 0x0028,
		ymove		= 0x002C,
		zmove		= 0x0030,
		
		lighting	= 0x0078,
		
		animation	= 0x01FC,
		
		ntrlst		= 0x17A7,
		health		= 0x17A8,
		meter		= 0x17A9,
		
		ovl			= 0x17B8,
		model		= 0x17C0
	},
	code = {
	death = 0x802186B4
	},
},
{	games = {"fgtlayer"},
	address = {
		player	= 0x8034A100,
		timer	= 0x80335430,
	},
	offset = {
		player2		= 0x1B7C,
		character	= 0x0002,
		color 		= 0x0003,
		
		xplace		= 0x0010,
		yplace		= 0x0014,
		zplace		= 0x0018,
		
		xmove		= 0x0028,
		ymove		= 0x002C,
		zmove		= 0x0030,
		
		lighting	= 0x006C,
		
		animation	= 0x01FC,
		
		ntrlst		= 0x1B43,
		health		= 0x1B44,
		meter		= 0x1B45,
	}
},

}

function main()
pladr = game.address.player
data = game.offset
cheat = game.code

if cheat ~= nil then
wd(cheat.death,0x24020000)
end


wb(game.address.timer,0x63)

if game.address.unlocks ~= nil then
wd(game.address.unlocks,0xfFFFFFFF)
end

gui.text(4,192,neutral[rb(pladr+data.ntrlst)+1])

--Text
gui.text(  4,  2,string.format("ADR  %08X",pladr))
gui.text(  4, 10,string.format("LGHT %08X",rd(pladr+data.lighting)))
gui.text( 64,  2,string.format("XSPD %08X",rd(pladr+data.xmove)))
gui.text( 64, 10,string.format("YSPD %08X",rd(pladr+data.ymove)))
gui.text( 64, 18,string.format("ZSPD %08X",rd(pladr+data.zmove)))

if data.ovl ~= nil then
gui.text(  4, 200,string.format("OVL  %08X",rd(pladr + data.ovl)))
end

gui.text(166, 26,string.format("Health  %d",rb(pladr + data.health)))
gui.text(176, 36,string.format("Meter  %d",rb(pladr + data.meter)))


end

local whatgame = function()
	print()
	game = nil
	for _, module in ipairs(profile) do
		for _, shortname in ipairs(module.games) do
			if emu.romname() == shortname or emu.parentname() == shortname then
				game = module
				print(shortname)
				return
			end
		end
	end
end

emu.registerstart(function()
	whatgame()
end)



emu.registerafter(function()
main()
end)
