load GameOfLife.asm,
output-file me.out,
compare-to me.cmp,
output-list RAM[100]%D1.8.1 RAM[101]%D1.8.1 RAM[132]%D1.8.1 RAM[133]%D1.8.1;

set PC 0,
set RAM[99] 1,   // set number of generations
set RAM[100] 1,   // set starting pattern
set RAM[101] 1,
set RAM[132] 1,
repeat 5000000 {
  ticktock;
}
output;