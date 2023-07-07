# Game of Life
Game of Life simulator created for the Hack assembly language. 
This project was developed as part of the Nand2Tetris course. 
To test the project, you will need the CPU Emulator program. 
You can download the tools from [this link](https://www.nand2tetris.org/software).

Game of Life is not just a game, it is a cellular automata, a type of theoretical computer model. 
It is known to be Turing Complete, which means that despite its simple rules, 
given an infinite-sized grid and properly defining the initial state of the grid, 
it can compute any computable problem! For more details, refer to the link to the [Wikipedia page](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

[![GE Flag](https://flagcdn.com/16x12/ge.png)](./README-ge.md) [GE](./README-ge.md) | [![US Flag](https://flagcdn.com/16x12/us.png)](./README.md) US

## Examples
Here are some animations created for this project:

### Blinker
![blinker](https://github.com/lnadi17/game-of-life/assets/19193250/d4e3276a-e668-4902-a8af-bf47d97f5c30)

### Glider
![glider](https://github.com/lnadi17/game-of-life/assets/19193250/84f62574-961d-43af-a683-1135252dc570)

### RipConway
![ripConway](https://github.com/lnadi17/game-of-life/assets/19193250/d3048110-b3db-4456-8c03-ad8499ce446d)

## Assignment
### Part 1:
Create a simulator with a 16x32 matrix, where each cell can be either populated (1) or unpopulated (0). The initial state of the simulation should be loaded from a test file. The RAM addresses are as follows:
```
RAM[100] == grid(0, 0)
RAM[132] == grid(1, 0)
RAM[611] == grid(16, 31)
```
And the number of iterations that should be executed by the simulator is written to RAM[99].

Each iteration generates a new universe. Rules for generation are as follows:
```
For a space that is 'populated':
* Each cell with one or no neighbors dies, as if by solitude.
* Each cell with four or more neighbors dies, as if by overpopulation.
* Each cell with two or three neighbors survives.

For a space that is 'empty' or 'unpopulated'
* Each cell with three neighbors becomes populated.
```

### Part 2:
Implement the visualization of the simulator using the Hack screen. 
The existing screen has a resolution of 256x512. For convenience, each GameOfLife cell should be drawn as a 
16x16 square on the screen. Therefore, the screen consists of 16x32 squares.

If a cell is populated (1), the corresponding square should be black on the screen. If a cell is unpopulated (0), 
the corresponding square should be white on the screen. The screen should be refreshed after each iteration!
