// The game of life world consists of 2D grid 16x32, the grid is mapped in memory:
// RAM[100] == grid(0, 0)
// RAM[132] == grid(1, 0)
// RAM[611] == grid(16, 31)
//
// RAM[99] contains number of generations to iterate over the Game of life world (aka grid)
//
// Iteration rules:
// For a space that is 'populated':
// * Each cell with one or no neighbors dies, as if by solitude.
// * Each cell with four or more neighbors dies, as if by overpopulation.
// * Each cell with two or three neighbors survives.
//
// For a space that is 'empty' or 'unpopulated'
// * Each cell with three neighbors becomes populated.
//
// initial values are set by test. The are only two values allowed:
// 1 -- the cell is populated
// 0 -- the cell is empty


// generation = -1
@generation // current index of generation
M = -1

(GENERATE)
	// check if current index is equal to RAM[99]
	@99
	D = M
	@generation
	D = D - M
	@END
	D ; JEQ
	
	// i = 100
	@100
	D = A
	@i
	M = D
	
	// x = 0, y = 0
	@x
	M = 0
	@y
	M = 0
	
	// loop over each cell
	(LOOP)
		// if (i - 612 == 0) then jump
		@612
		D = A
		@i
		D = M - D
		@END_LOOP
		D ; JEQ
		
		// save current status (dead or alive)
		@i
		A = M // current address is RAM[i]
		D = M // D = RAM[RAM[i]]
		@status
		M = D
		
		// save all neighbour coordinates (including invalid ones) in R[0..15] registers
		(FILL_REGISTERS)
			// R0 = R12 = R14 = x - 1
			@x
			D = M - 1
			@R0
			M = D
			@R12
			M = D
			@R14
			M = D
			
			// R2 = R10 = x
			@x
			D = M
			@R2
			M = D
			@R10
			M = D
			
			// R4 = R6 = R8 = x + 1
			@x
			D = M + 1
			@R4
			M = D
			@R6
			M = D
			@R8
			M = D
			
			// R1 = R3 = R5 = y - 1
			@y
			D = M - 1
			@R1
			M = D
			@R3
			M = D
			@R5
			M = D
			
			// R15 = R7 = y
			@y
			D = M
			@R15
			M = D
			@R7
			M = D
			
			// R13 = R11 = R9 = y + 1
			@y
			D = M + 1
			@R13
			M = D
			@R11
			M = D
			@R9
			M = D
		(END_FILL_REGISTERS)
		
		// reg = 0
		@reg
		M = 0
		
		// nbval = 0 (neighbour count)
		@nbval
		M = 0
		
		// count neighbours by looping over memories addressed by registers
		(NEIGHBOUR_LOOP)
			// if (reg - 16 == 0) then jump
			@16
			D = A
			@reg
			D = M - D
			@END_NEIGHBOUR_LOOP
			D ; JEQ
			
			// currentx = RAM[reg], currenty = RAM[reg + 1]
			@reg
			A = M
			D = M
			@currentx
			M = D
			
			@reg
			A = M + 1
			D = M
			@currenty
			M = D
			
			// if (currentx == -1) then skip
			@currentx
			D = M + 1 // if currentx == -1 then D will contain 0
			@NEIGHBOUR_INCREMENT
			D ; JEQ
			
			// if (currenty == -1) then skip
			@currenty
			D = M + 1
			@NEIGHBOUR_INCREMENT
			D ; JEQ
			
			// if (currentx == 32) then skip
			@32
			D = A
			@currentx
			D = M - D
			@NEIGHBOUR_INCREMENT
			D ; JEQ
			
			// if (currenty == 32) then skip
			@32
			D = A
			@currenty
			D = M - D
			@NEIGHBOUR_INCREMENT
			D ; JEQ
			
			// at this point coordinates are valid, so we increase neighbour count
			// nbval += RAM[i + (currentx - x) + (currenty - y) * 32]
			
			// if (currenty - y == 1) then deltay = 32
			// if (currenty - y == -1) then deltay = -32
			// if (currenty - y == 0) then deltay = 0
			(IF_Y)
				@currenty
				D = M
				@y
				D = D - M
				@temp
				M = D // temp = currenty - y
				@32
				D = A
				@deltay
				M = D
				@temp
				D = M // write (currenty - y) back in D register
				@END_IF_Y
				D - 1 ; JEQ
				// if got here, then (currenty - y) is either 0 or -1
				@32
				D = A
				@0
				D = A - D // -32
				@deltay
				M = D
				@temp
				D = M
				@END_IF_Y
				D + 1 ; JEQ
				// if got here, then (currenty - y) is 0
				@deltay
				M = 0
			(END_IF_Y)
			
			// deltax is just (currentx - x)
			@currentx
			D = M
			@x
			D = D - M
			@deltax
			M = D // deltax = (currentx - x)
			
			// step is equal to (deltax + deltay)
			@deltax
			D = M
			@deltay
			D = D + M
			@step
			M = D
			
			// nbval += RAM[i + step]
			@i
			A = M + D // A = i + step
			D = M // D = RAM[i + step]
			@nbval
			M = M + D // nbval = nbval + RAM[i + step]
		
			(NEIGHBOUR_INCREMENT)
			// at this point nbval is updated (or it's skipped to here)
			// we increment reg by 2 and visit neighbour loop again
			@reg
			M = M + 1
			M = M + 1
			@NEIGHBOUR_LOOP
			0 ; JMP
		(END_NEIGHBOUR_LOOP)
		
		// we have all info about current cell, now we just make decisions
		@futstat
		M = 1
		// if nbval == 3 then futstat = 1
		@nbval
		D = M
		@3
		D = D - A // D = nbval - 3
		@END_FUTURE_IFS
		D ; JEQ
		// if status == 1 and nbval == 2 then futstat = 1 -- at this point this is the same as:
		// if status + nbval == 3 then futstat = 1
		@status
		D = M
		@nbval
		D = D + M
		@3
		D = D - A // status + nbval - 3
		@END_FUTURE_IFS
		D ; JEQ
		// else futstat is 0 (cell doesn't survive)
		@futstat
		M = 0
		(END_FUTURE_IFS)
		
		// now that we know current cell's future state, save it into RAM
		// RAM[i + 600] = futstat
		@i
		D = M
		@600
		D = D + A // D = i + 600
		@temp
		M = D // temp = i + 600
		@futstat
		D = M // D = futstat
		@temp
		A = M // A = i + 600
		M = D // RAM[i + 600] = futstat
		
		// i++
		@i
		M = M + 1
		
		// increase x and increase y
		// x = x + 1
		@x
		MD = M + 1
		@32
		D = D - A 
		// if (x + 1 == 32) then x = 0, y = y + 1
		@END_XY_IFS
		D ; JNE
		@x
		M = 0
		@y
		M = M + 1
		(END_XY_IFS)
		
		@LOOP
		0 ; JMP
	(END_LOOP)
	

	// gamecell = 100
	@100
	D = A
	@gamecell
	M = D
	
	// i = 0
	@i
	M = 0
	
	// colcount = 0
	@colcount
	M = 0
	(UPDATE_SCREEN_LOOP)	
		@7680
		D = A
		@i
		D = D - M // D = 8192 - i // SCREEN + 8192 = KBD
		@END_UPDATE_SCREEN_LOOP
		// if (i == 8192) then skip
		D ; JEQ
		
		// save cell state into temp
		@gamecell
		A = M
		D = M // RAM[RAM[gamecell]]
		@temp
		M = D
		
		// if temp == 1 then temp == -1 (it's all ones in binary)
		@temp
		D = M - 1
		@END_SMALL_IF
		D ; JNE
		@temp
		M = -1
		(END_SMALL_IF)
		
		// write temp into RAM[SCREEN + i]
		@i
		D = M
		@SCREEN
		D = D + A // D = i + SCREEN
		@scradd
		M = D
		@temp
		D = M
		@scradd
		A = M
		M = D
		
		// do that again 15 times for cells below // value to write is in temp
		// j = 0
		@j
		M = 0
		
		// start that loop
		(FILL_COL_LOOP)
			// if (j == 15) then skip
			@15
			D = A
			@j
			D = M - D // D = j - 15
			@END_FILL_COL_LOOP
			D ; JEQ
			
			// calculate next screen address (scradd += 32)
			@32
			D = A
			@scradd
			M = D + M // scradd = 32 + scradd
			
			// load temp into D register and write it into address written in scradd
			@temp
			D = M
			@scradd
			A = M
			M = D
			
			// j++
			@j
			M = M + 1
			
			@FILL_COL_LOOP
			0 ; JMP
		(END_FILL_COL_LOOP)
		
		// colcount++
		@colcount
		M = M + 1
		
		// i++
		@i
		M = M + 1
		
		// gamecell++
		@gamecell
		M = M + 1
		
		// if (colcount == 32) then colcount = 0, i += 480 // (15*32)
		@32
		D = A
		@colcount
		D = D - M 
		@END_JUMP_IF
		D ; JNE
		@colcount
		M = 0
		@480
		D = A
		@i
		M = M + D // i = i + 480
		(END_JUMP_IF)
		
		@UPDATE_SCREEN_LOOP
		0 ; JMP
	(END_UPDATE_SCREEN_LOOP)
	
	// check if it's the last generation. if yes, go to end
	// generation++
	@generation
	M = M + 1
	// check if current index is equal to RAM[99]
	@99
	D = M
	@generation
	D = D - M
	@END
	D ; JEQ
	
	// RAM[700..1211] should be full with next state, copy it into [100..612] and into screen
	
	// i = 700
	@700
	D = A
	@i
	M = D
	
	// loop over each new cell ([700..1211]) and copy it into [100..611]
	(COPY_LOOP)
		// if (i - 1212 == 0) then jump
		@1212
		D = A
		@i
		D = M - D
		@END_COPY_LOOP
		D ; JEQ
		
		// calculate index of memory in which to copy value
		@600
		D = A
		@i
		D = M - D // D = i - 600
		@temp
		M = D // temp = i - 600
		
		// copy value into that address
		@i
		A = M
		D = M // D = RAM[RAM[i]]
		@temp
		A = M
		M = D // RAM[i - 600] = value
		
		// i++
		@i
		M = M + 1
		@COPY_LOOP
		0 ; JMP
	(END_COPY_LOOP)
	
	// jump to the start of the generate loop
	@GENERATE
	0 ; JMP
	
(END)
	@END
	0 ; JMP