print"Taken from Crystal_Cube's 3s Script"
print"Works on Vsav,SFA2,SFA3"

--Required Libary
require "gd"

--Art work
keyDisp2Reba = {
	gd.createFromPng("resources/command/keyDisp2_reba1_1.png"):gdStr(),
	gd.createFromPng("resources/command/keyDisp2_reba1_2.png"):gdStr(),
	gd.createFromPng("resources/command/keyDisp2_reba1_3.png"):gdStr(),
	gd.createFromPng("resources/command/keyDisp2_reba1_4.png"):gdStr(),
	gd.createFromPng("resources/command/keyDisp2_reba1_5.png"):gdStr(),
	gd.createFromPng("resources/command/keyDisp2_reba1_6.png"):gdStr(),
	gd.createFromPng("resources/command/keyDisp2_reba1_7.png"):gdStr(),
	gd.createFromPng("resources/command/keyDisp2_reba1_8.png"):gdStr(),
	gd.createFromPng("resources/command/keyDisp2_reba1_9.png"):gdStr()
}

punch_1 = gd.createFromPng("resources/command/punch_1.png"):gdStr()
punch_2 = gd.createFromPng("resources/command/punch_2.png"):gdStr()
punch_3 = gd.createFromPng("resources/command/punch_3.png"):gdStr()
punch_1_2 = gd.createFromPng("resources/command/punch_1_2.png"):gdStr()
punch_2_2 = gd.createFromPng("resources/command/punch_2_2.png"):gdStr()
punch_3_2 = gd.createFromPng("resources/command/punch_3_2.png"):gdStr()

kick_1 = gd.createFromPng("resources/command/kick_1.png"):gdStr()
kick_2 = gd.createFromPng("resources/command/kick_2.png"):gdStr()
kick_3 = gd.createFromPng("resources/command/kick_3.png"):gdStr()
kick_1_2 = gd.createFromPng("resources/command/kick_1_2.png"):gdStr()
kick_2_2 = gd.createFromPng("resources/command/kick_2_2.png"):gdStr()
kick_3_2 = gd.createFromPng("resources/command/kick_3_2.png"):gdStr()

button_l1 = gd.createFromPng("resources/command/button_l1.png"):gdStr()
button_l2 = gd.createFromPng("resources/command/button_l2.png"):gdStr()
button_m1 = gd.createFromPng("resources/command/button_m1.png"):gdStr()
button_m2 = gd.createFromPng("resources/command/button_m2.png"):gdStr()
button_h1 = gd.createFromPng("resources/command/button_h1.png"):gdStr()
button_h2 = gd.createFromPng("resources/command/button_h2.png"):gdStr()

button_s1 = gd.createFromPng("resources/command/button_s1.png"):gdStr()
button_s2 = gd.createFromPng("resources/command/button_s2.png"):gdStr()

keyDisp2_dir0 = gd.createFromPng("resources/command/keyDisp2_dir0.png"):gdStr()
keyDisp2_dir1 = gd.createFromPng("resources/command/keyDisp2_dir1.png"):gdStr()
keyDisp2_dir0_real = gd.createFromPng("resources/command/keyDisp2_dir0_real.png"):gdStr()
keyDisp2_dir1_real = gd.createFromPng("resources/command/keyDisp2_dir1_real.png"):gdStr()

keyDisp2_lp1 = gd.createFromPng("resources/command/keyDisp2_lp1.png"):gdStr()
keyDisp2_lk1 = gd.createFromPng("resources/command/keyDisp2_lk1.png"):gdStr()
keyDisp2_l2 = gd.createFromPng("resources/command/keyDisp2_l2.png"):gdStr()
keyDisp2_mp1 = gd.createFromPng("resources/command/keyDisp2_mp1.png"):gdStr()
keyDisp2_mk1 = gd.createFromPng("resources/command/keyDisp2_mk1.png"):gdStr()
keyDisp2_m2 = gd.createFromPng("resources/command/keyDisp2_m2.png"):gdStr()
keyDisp2_hp1 = gd.createFromPng("resources/command/keyDisp2_hp1.png"):gdStr()
keyDisp2_hk1 = gd.createFromPng("resources/command/keyDisp2_hk1.png"):gdStr()
keyDisp2_h2 = gd.createFromPng("resources/command/keyDisp2_h2.png"):gdStr()
keyDisp2_hold1 = gd.createFromPng("resources/command/keyDisp2_hold1.png"):gdStr()
keyDisp2_hold2 = gd.createFromPng("resources/command/keyDisp2_hold2.png"):gdStr()



arrow_up1 = gd.createFromPng("resources/command/arrow_up1.png"):gdStr()
arrow_up2 = gd.createFromPng("resources/command/arrow_up2.png"):gdStr()
arrow_up3 = gd.createFromPng("resources/command/arrow_up3.png"):gdStr()

arrow_right1 = gd.createFromPng("resources/command/arrow_right1.png"):gdStr()
arrow_right2 = gd.createFromPng("resources/command/arrow_right2.png"):gdStr()
arrow_right3 = gd.createFromPng("resources/command/arrow_right3.png"):gdStr()

arrow_down1 = gd.createFromPng("resources/command/arrow_down1.png"):gdStr()
arrow_down2 = gd.createFromPng("resources/command/arrow_down2.png"):gdStr()
arrow_down3 = gd.createFromPng("resources/command/arrow_down3.png"):gdStr()

arrow_left1 = gd.createFromPng("resources/command/arrow_left1.png"):gdStr()
arrow_left2 = gd.createFromPng("resources/command/arrow_left2.png"):gdStr()
arrow_left3 = gd.createFromPng("resources/command/arrow_left3.png"):gdStr()


keyDisplay2_box1P = {
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
}

keyDisplay2_box2P = {
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
	{"","","0000000"},
}
no_input_time1P = 0
no_input_time2P = 0
no_input_limit = 300

--そのボタンが押されていると、カウントを１増やして返すだけの関数
function buttonCount(button, count)
	if button == 0 then
		count = count + 1
	else
		count = 0
	end
	return count
end


local input_dir

--前の入力から経過したフレームを表す変数
local reba_flame_from_before_input1P = 0
local button_flame_from_before_input1P = 0
local reba_flame_from_before_input2P = 0
local button_flame_from_before_input2P = 0

--
before_time_in_game1P = 1234
before_time_in_game2P = 1234
time_in_game1P = 5678
time_in_game2P = 5678


--レバーの入力状態を表す変数
local input_up, input_down, input_right, input_left

--ボタンの入力状態を表す変数
local input_lp, input_mp, input_hp, input_lk, input_mk, input_hk
--1フレーム前の入力を保存しておく変数
local before_reba1P = 0
local before_input_lp1P = 0
local before_input_mp1P = 0
local before_input_hp1P = 0
local before_input_lk1P = 0
local before_input_mk1P = 0
local before_input_hk1P = 0
local before_reba2P = 0
local before_input_lp2P = 0
local before_input_mp2P = 0
local before_input_hp2P = 0
local before_input_lk2P = 0
local before_input_mk2P = 0
local before_input_hk2P = 0
--レバーの画像ファイル名に使う変数
local reba_num


function keyDisplayp1(image_l1, image_l2, image_m1, image_m2, image_h1, image_h2, image_s1, image_s2, x, y, buttonAddress,startAddress)
	--入力の内容を、それぞれの変数に分けてわかりやすくする
			input_up = bit.band(memory.readbyte(buttonAddress+1),0x08)/0x08
			input_down = bit.band(memory.readbyte(buttonAddress+1),0x04)/0x04
			input_left = bit.band(memory.readbyte(buttonAddress+1),0x02)/0x02
			input_right = bit.band(memory.readbyte(buttonAddress+1),0x01)
			input_lp = bit.band(memory.readbyte(buttonAddress),0x01)
			input_mp = bit.band(memory.readbyte(buttonAddress),0x2)/0x2
			input_hp = bit.band(memory.readbyte(buttonAddress),0x4)/0x4
			input_lk = bit.band(memory.readbyte(buttonAddress),0x10)/0x10
			input_mk = bit.band(memory.readbyte(buttonAddress),0x20)/0x20
			input_hk = bit.band(memory.readbyte(buttonAddress),0x40)/0x40
				
	input_s = bit.band(memory.readbyte(startAddress),0x01)
	
	--入力状態によって、表示する画像番号を決定する
	if input_up == 1 then
		if input_right == 1 then
			reba_num = 9
		elseif input_left == 1 then
			reba_num = 7
		else
			reba_num = 8
		end
	elseif input_down == 1 then
		if input_right == 1 then
			reba_num = 3
		elseif input_left == 1 then
			reba_num = 1
		else
			reba_num = 2
		end
	elseif input_right == 1 then
		reba_num = 6
	elseif input_left == 1 then
		reba_num = 4
	else
		reba_num = 5
	end
	
	--画像の読み込みと表示を同時に行っている
	reba = gd.createFromPng("resources/command/reba"..reba_num..".png"):gdStr()
	
	gui.image(x, y, reba)
	
	x = x + 24
	
	--入力に応じてボタンを光らせる
	if input_lp == 1 then
		gui.image(x, y, image_l2)
	else
		gui.image(x, y, image_l1)
	end
	
	x = x + 12
	
	if input_mp == 1 then
		gui.image(x, y, image_m2)
	else
		gui.image(x, y, image_m1)
	end
	
	x = x + 12
	
	if input_hp == 1 then
		gui.image(x, y, image_h2)
	else
		gui.image(x, y, image_h1)
	end
	
	x = x - 12 - 12 + 2
	y = y + 12
	
	if input_lk == 1 then
		gui.image(x, y, image_l2)
	else
		gui.image(x, y, image_l1)
	end
	
	x = x + 12
	
	if input_mk == 1 then
		gui.image(x, y, image_m2)
	else
		gui.image(x, y, image_m1)
	end
	
	x = x + 12
	
	if input_hk == 1 then
		gui.image(x, y, image_h2)
	else
		gui.image(x, y, image_h1)
	end
	
	x = x + 16
	y = y - 8
	if input_s == 1 then
		gui.image(x, y, image_s2)
	else
		gui.image(x, y, image_s1)
	end
end
function keyDisplayp2(image_l1, image_l2, image_m1, image_m2, image_h1, image_h2, image_s1, image_s2, x, y, buttonAddress,startAddress)
	--入力の内容を、それぞれの変数に分けてわかりやすくする
	input_up = bit.band(memory.readbyte(buttonAddress),0x08)/0x08
	input_down = bit.band(memory.readbyte(buttonAddress),0x04)/0x04
	input_left = bit.band(memory.readbyte(buttonAddress),0x02)/0x02
	input_right = bit.band(memory.readbyte(buttonAddress),0x01)
	input_lp = bit.band(memory.readbyte(buttonAddress),0x10)/0x10
	input_mp = bit.band(memory.readbyte(buttonAddress),0x20)/0x20
	input_hp = bit.band(memory.readbyte(buttonAddress),0x40)/0x40
	input_lk = bit.band(memory.readbyte(buttonAddress+0x11),0x10)/0x10
	input_mk = bit.band(memory.readbyte(buttonAddress+0x11),0x20)/0x20
	input_hk = bit.band(memory.readbyte(buttonAddress+0x20),0x40)/0x40
	
	input_s = bit.band(memory.readbyte(startAddress),0x02)/2
	
	--入力状態によって、表示する画像番号を決定する
	if input_up == 0 then
		if input_right == 0 then
			reba_num = 9
		elseif input_left == 0 then
			reba_num = 7
		else
			reba_num = 8
		end
	elseif input_down == 0 then
		if input_right == 0 then
			reba_num = 3
		elseif input_left == 0 then
			reba_num = 1
		else
			reba_num = 2
		end
	elseif input_right == 0 then
		reba_num = 6
	elseif input_left == 0 then
		reba_num = 4
	else
		reba_num = 5
	end

	--画像の読み込みと表示を同時に行っている
	reba = gd.createFromPng("resources/command/reba"..reba_num..".png"):gdStr()
	
	gui.image(x, y, reba)
	
	x = x + 24
	
	--入力に応じてボタンを光らせる
	if input_lp == 0 then
		gui.image(x, y, image_l2)
	else
		gui.image(x, y, image_l1)
	end
	
	x = x + 12
	
	if input_mp == 0 then
		gui.image(x, y, image_m2)
	else
		gui.image(x, y, image_m1)
	end
	
	x = x + 12
	
	if input_hp == 0 then
		gui.image(x, y, image_h2)
	else
		gui.image(x, y, image_h1)
	end
	
	x = x - 12 - 12 + 2
	y = y + 12
	
	if input_lk == 0 then
		gui.image(x, y, image_l2)
	else
		gui.image(x, y, image_l1)
	end
	
	x = x + 12
	
	if input_mk == 0 then
		gui.image(x, y, image_m2)
	else
		gui.image(x, y, image_m1)
	end
	
	x = x + 12
	
	if input_hk == 0 then
		gui.image(x, y, image_h2)
	else
		gui.image(x, y, image_h1)
	end
	
	x = x + 16
	y = y - 8
	if input_s == 0 then
		gui.image(x, y, image_s2)
	else
		gui.image(x, y, image_s1)
	end
end


--player = bit.band(memory.readbyte(0xFF840B),0x01)

--*******キーディスプレイその２の２*******
function keyDisplay2_2(image_l1, image_l2, image_m1, image_m2, image_h1, image_h2, image_s1, image_s2, x, y, player)
	dispNumber=16
	offsetX1P2P = 270
	
	if player == 1 then
	--ゲーム内時間のようなもの
		before_time_in_game1P = time_in_game1P
		time_in_game1P = memory.readbyte(0xFF8080)
	
		--ゲーム内で時間が経っていたら、入力履歴を更新したい
		if before_time_in_game1P ~= time_in_game1P then
			reba_flame_from_before_input1P = reba_flame_from_before_input1P+1
			button_flame_from_before_input1P = button_flame_from_before_input1P+1
			
			buttonAddress = 0xFF8058
			startAddress = 0xFF8060
			dirAddress = 0xFF840B
			
			--キャラの向き
			direction1P = memory.readbyte(dirAddress)
			
			--入力の内容を、それぞれの変数に分けてわかりやすくしておく
			input_up = bit.band(memory.readbyte(buttonAddress+1),0x08)/0x08
			input_down = bit.band(memory.readbyte(buttonAddress+1),0x04)/0x04
			input_left = bit.band(memory.readbyte(buttonAddress+1),0x02)/0x02
			input_right = bit.band(memory.readbyte(buttonAddress+1),0x01)
			input_lp1P = bit.band(memory.readbyte(buttonAddress),0x01)
			input_mp1P = bit.band(memory.readbyte(buttonAddress),0x2)/0x2
			input_hp1P = bit.band(memory.readbyte(buttonAddress),0x4)/0x4
			input_lk1P = bit.band(memory.readbyte(buttonAddress),0x10)/0x10
			input_mk1P = bit.band(memory.readbyte(buttonAddress),0x20)/0x20
			input_hk1P = bit.band(memory.readbyte(buttonAddress),0x40)/0x40
			
			input_s = bit.band(memory.readbyte(startAddress),0x01)
			
			if input_down==1 and input_right==0 and input_left==1 then
				reba1P = 1
			end
			if input_down==1 and input_right==0 and input_left==0 then
				reba1P = 2
			end
			if input_down==1 and input_right==1 and input_left==0 then
				reba1P = 3
			end
			if input_up==0 and input_down==0 and input_left==1 then
				reba1P = 4
			end
			if input_up==0 and input_down==0 and input_right==0 and input_left==0 then
				reba1P = 5		
			end
			if input_down==0 and input_right==1 and input_left==0 then
				reba1P = 6
			end
			if input_up==1 and input_right==0 and input_left==1 then
				reba1P = 7
			end
			if input_up==1 and input_right==0 and input_left==0 then
				reba1P = 8
			end
			if input_up==1 and input_right==1 and input_left==0 then
				reba1P = 9
			end
			if input_down==1 and input_right==1 and input_left==1 then
				reba1P = 3
			end
			
			--現在の状態や入力を一時的に格納しておくための箱
			input_temp = {0,0,"",0}
			input_temp[1] = reba_flame_from_before_input1P
			input_temp[4] = button_flame_from_before_input1P
			input_temp[2] = direction1P
			input_temp[3] = reba1P..input_lp..input_mp..input_hp..input_lk..input_mk..input_hk
			
			--何かが入力されたら、配列を１個ずらす
			if (reba1P ~= before_reba1P and reba1P ~= 5)
				or input_lp1P > before_input_lp1P
				or input_mp1P > before_input_mp1P
				or input_hp1P > before_input_hp1P
				or input_lk1P > before_input_lk1P
				or input_mk1P > before_input_mk1P
				or input_hk1P > before_input_hk1P then
				for i = dispNumber, 2, -1 do
					keyDisplay2_box1P[i] = keyDisplay2_box1P[i-1]
				end
				
				--レバーの入力がされていたら
				if (reba1P ~= before_reba1P and reba1P ~= 5) then
					reba_flame_from_before_input1P = 0
				end
				--ボタンの入力がされていたら
				if input_lp1P > before_input_lp1P
				or input_mp1P > before_input_mp1P
				or input_hp1P > before_input_hp1P
				or input_lk1P > before_input_lk1P
				or input_mk1P > before_input_mk1P
				or input_hk1P > before_input_hk1P then
					button_flame_from_before_input1P = 0
				end
				
				--配列の１個目に、現在の入力を格納する
				keyDisplay2_box1P[1] = input_temp
				if reba_flame_from_before_input1P ~= 0 then
					keyDisplay2_box1P[1][1] = 0
				end
				if button_flame_from_before_input1P ~= 0 then
					keyDisplay2_box1P[1][4] = 0
				end
				no_input_time1P = 0
			end
			
			if reba1P == 5
			and input_lp1P == 0
			and input_mp1P == 0
			and input_hp1P == 0
			and input_lk1P == 0
			and input_mk1P == 0
			and input_hk1P == 0 then
				--何も入力されていなければ、無入力時間を増やす
				no_input_time1P = no_input_time1P+1
				if no_input_time1P > no_input_limit then
					for i = 1, dispNumber-1, 1 do
						keyDisplay2_box1P[i]={"","","0000000"}
					end
					no_input_time1P = 0
				end
			end
			
			before_reba1P = reba1P
			before_input_lp1P = input_lp1P
			before_input_mp1P = input_mp1P
			before_input_hp1P = input_hp1P
			before_input_lk1P = input_lk1P
			before_input_mk1P = input_mk1P
			before_input_hk1P = input_hk1P
		end
	
	
		--頑張って描画
		offsetY=40
	
		if direction1P == 0 then
			gui.image(8,8,keyDisp2_dir0_real)
		else
			gui.image(8,8,keyDisp2_dir1_real)
		end
		for i = 1, dispNumber-1, 1 do
			reba1P = string.sub(keyDisplay2_box1P[i][3],1,1)+0
			--入力履歴があったら
			if reba1P ~= 0 then
			
				offsetX=2
				if keyDisplay2_box1P[i][1] ~= 0 then
					gui.text(offsetX,offsetY+6,numSpaceLeft(keyDisplay2_box1P[i][1],4))
				end
				
				offsetX=offsetX+16
				if keyDisplay2_box1P[i][4] ~= 0 then
					gui.text(offsetX,offsetY+6,numSpaceLeft(keyDisplay2_box1P[i][4],4))
				end
				
				offsetX=offsetX+16
				if keyDisplay2_box1P[i][2] == 0 then
					gui.image(offsetX,offsetY,keyDisp2_dir0)
				else
					gui.image(offsetX,offsetY,keyDisp2_dir1)
				end
				
				offsetX=offsetX+16
				gui.image(offsetX,offsetY,keyDisp2Reba[reba1P])
				
				offsetX=offsetX+12
				
				if string.sub(keyDisplay2_box1P[i][3],2,2)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_lp1)
					offsetX=offsetX+8
				end
				
				if string.sub(keyDisplay2_box1P[i][3],3,3)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_mp1)
					offsetX=offsetX+8
				end
				
				if string.sub(keyDisplay2_box1P[i][3],4,4)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_hp1)
					offsetX=offsetX+8
				end
				
				
				if string.sub(keyDisplay2_box1P[i][3],5,5)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_lk1)
					offsetX=offsetX+8
				end
				
				if string.sub(keyDisplay2_box1P[i][3],6,6)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_mk1)
					offsetX=offsetX+8
				end
				
				if string.sub(keyDisplay2_box1P[i][3],7,7)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_hk1)
					offsetX=offsetX+8
				end
				offsetY=offsetY+9
			end
		end
	else
	--ゲーム内時間のようなもの
		before_time_in_game2P = time_in_game2P
		time_in_game2P = memory.readbyte(0x020157CF)
	
		--ゲーム内で時間が経っていたら、入力履歴を更新したい
		if before_time_in_game2P ~= time_in_game2P then
			reba_flame_from_before_input2P = reba_flame_from_before_input2P+1
			button_flame_from_before_input2P = button_flame_from_before_input2P+1
			
			buttonAddress = 0x0202568F
			startAddress = 0x0206AA90
			dirAddress = 0x0206910F
			
			--キャラの向き
			direction2P = memory.readbyte(dirAddress)
			
			--入力の内容を、それぞれの変数に分けてわかりやすくしておく
			input_up = bitReturn(memory.readbyte(buttonAddress),0)
			input_down = bitReturn(memory.readbyte(buttonAddress),1)
			input_left = bitReturn(memory.readbyte(buttonAddress),2)
			input_right = bitReturn(memory.readbyte(buttonAddress),3)
			input_lp2P = bitReturn(memory.readbyte(buttonAddress),4)
			input_mp2P = bitReturn(memory.readbyte(buttonAddress),5)
			input_hp2P = bitReturn(memory.readbyte(buttonAddress),6)
			input_lk2P = bitReturn(memory.readbyte(buttonAddress-1),0)
			input_mk2P = bitReturn(memory.readbyte(buttonAddress-1),1)
			input_hk2P = bitReturn(memory.readbyte(buttonAddress-1),2)
			
			input_s = (memory.readbyte(startAddress) - (memory.readbyte(startAddress) % 16)) / 16
			
			if input_down==1 and input_right==0 and input_left==1 then
				reba2P = 1
			end
			if input_down==1 and input_right==0 and input_left==0 then
				reba2P = 2
			end
			if input_down==1 and input_right==1 and input_left==0 then
				reba2P = 3
			end
			if input_up==0 and input_down==0 and input_left==1 then
				reba2P = 4
			end
			if input_up==0 and input_down==0 and input_right==0 and input_left==0 then
				reba2P = 5		
			end
			if input_down==0 and input_right==1 and input_left==0 then
				reba2P = 6
			end
			if input_up==1 and input_right==0 and input_left==1 then
				reba2P = 7
			end
			if input_up==1 and input_right==0 and input_left==0 then
				reba2P = 8
			end
			if input_up==1 and input_right==1 and input_left==0 then
				reba2P = 9
			end
			if input_down==1 and input_right==1 and input_left==1 then
				reba2P = 3
			end
			
			--現在の状態や入力を一時的に格納しておくための箱
			input_temp = {0,0,"",0}
			input_temp[1] = reba_flame_from_before_input2P
			input_temp[4] = button_flame_from_before_input2P
			input_temp[2] = direction2P
			input_temp[3] = reba2P..input_lp..input_mp..input_hp..input_lk..input_mk..input_hk
			
			--何かが入力されたら、配列を１個ずらす
			if (reba2P ~= before_reba2P and reba2P ~= 5)
				or input_lp2P > before_input_lp2P
				or input_mp2P > before_input_mp2P
				or input_hp2P > before_input_hp2P
				or input_lk2P > before_input_lk2P
				or input_mk2P > before_input_mk2P
				or input_hk2P > before_input_hk2P then
				for i = dispNumber, 2, -1 do
					keyDisplay2_box2P[i] = keyDisplay2_box2P[i-1]
				end
				
				--レバーの入力がされていたら
				if (reba2P ~= before_reba2P and reba2P ~= 5) then
					reba_flame_from_before_input2P = 0
				end
				--ボタンの入力がされていたら
				if input_lp2P > before_input_lp2P
				or input_mp2P > before_input_mp2P
				or input_hp2P > before_input_hp2P
				or input_lk2P > before_input_lk2P
				or input_mk2P > before_input_mk2P
				or input_hk2P > before_input_hk2P then
					button_flame_from_before_input2P = 0
				end
				
				--配列の１個目に、現在の入力を格納する
				keyDisplay2_box2P[1] = input_temp
				if reba_flame_from_before_input2P ~= 0 then
					keyDisplay2_box2P[1][1] = 0
				end
				if button_flame_from_before_input2P ~= 0 then
					keyDisplay2_box2P[1][4] = 0
				end
				no_input_time2P = 0
			end
			
			if reba2P == 5
			and input_lp2P == 0
			and input_mp2P == 0
			and input_hp2P == 0
			and input_lk2P == 0
			and input_mk2P == 0
			and input_hk2P == 0 then
				--何も入力されていなければ、無入力時間を増やす
				no_input_time2P = no_input_time2P+1
				if no_input_time2P > no_input_limit then
					for i = 1, dispNumber-1, 1 do
						keyDisplay2_box2P[i]={"","","0000000"}
					end
					no_input_time2P = 0
				end
			end
			
			before_reba2P = reba2P
			before_input_lp2P = input_lp2P
			before_input_mp2P = input_mp2P
			before_input_hp2P = input_hp2P
			before_input_lk2P = input_lk2P
			before_input_mk2P = input_mk2P
			before_input_hk2P = input_hk2P
		end
	
	
		--頑張って描画
		offsetY=46
	
		if direction2P == 0 then
			gui.image(42+offsetX1P2P,36,keyDisp2_dir0_real)
		else
			gui.image(42+offsetX1P2P,36,keyDisp2_dir1_real)
		end
		for i = 1, dispNumber-1, 1 do
			reba2P = string.sub(keyDisplay2_box2P[i][3],1,1)+0
			--入力履歴があったら
			if reba2P ~= 0 then
			
				offsetX=2+offsetX1P2P
				if keyDisplay2_box2P[i][1] ~= 0 then
					gui.text(offsetX,offsetY+6,numSpaceLeft(keyDisplay2_box2P[i][1],4))
				end
				
				offsetX=offsetX+16
				if keyDisplay2_box2P[i][4] ~= 0 then
					gui.text(offsetX,offsetY+6,numSpaceLeft(keyDisplay2_box2P[i][4],4))
				end
				
				offsetX=offsetX+16
				if keyDisplay2_box2P[i][2] == 0 then
					gui.image(offsetX,offsetY,keyDisp2_dir0)
				else
					gui.image(offsetX,offsetY,keyDisp2_dir1)
				end
				
				offsetX=offsetX+16
				gui.image(offsetX,offsetY,keyDisp2Reba[reba2P])
				
				offsetX=offsetX+12
				
				if string.sub(keyDisplay2_box2P[i][3],2,2)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_lp1)
					offsetX=offsetX+8
				end
				
				if string.sub(keyDisplay2_box2P[i][3],3,3)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_mp1)
					offsetX=offsetX+8
				end
				
				if string.sub(keyDisplay2_box2P[i][3],4,4)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_hp1)
					offsetX=offsetX+8
				end
				
				
				if string.sub(keyDisplay2_box2P[i][3],5,5)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_lk1)
					offsetX=offsetX+8
				end
				
				if string.sub(keyDisplay2_box2P[i][3],6,6)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_mk1)
					offsetX=offsetX+8
				end
				
				if string.sub(keyDisplay2_box2P[i][3],7,7)+0 == 1 then
					gui.image(offsetX,offsetY,keyDisp2_hk1)
					offsetX=offsetX+8
				end
				offsetY=offsetY+9
			end
		end	
	end
end

function numSpaceLeft(val,keta)
	temp=""
	for i = 1, keta-#(val..""), 1 do
		temp = temp.." "
	end
	temp = temp..val
	return temp
end


emu.registerafter( function()
keyDisplayp1(button_l1, button_l2, button_m1, button_m2, button_h1, button_h2, button_s1, button_s2, 38, 180, 0xFF8058, 0xFF8060)
keyDisplay2_2(button_l1, button_l2, button_m1, button_m2, button_h1, button_h2, button_s1, button_s2, 40, 184, 1)

--keyDisplayp2(button_l1, button_l2, button_m1, button_m2, button_h1, button_h2, button_s1, button_s2, 278, 180, 0x804000, 0x804020)

end)
