load GameOfLife.asm,
output-file ripconway.out,
compare-to ripconway.cmp,
output-list RAM[118]%D1.8.1 RAM[119]%D1.8.1 RAM[150]%D1.8.1 RAM[151]%D1.8.1;

set PC 0,
set RAM[99] 30,   // set number of generations
set RAM[274] 1,   // set starting pattern
set RAM[275] 1,
set RAM[276] 1,
set RAM[306] 1,
set RAM[338] 1,
set RAM[400] 1,
set RAM[433] 1,
set RAM[402] 1,
set RAM[371] 1,
set RAM[403] 1,
set RAM[435] 1,
set RAM[467] 1,
set RAM[308] 1,
set RAM[340] 1,
set RAM[404] 1,
set RAM[437] 1,
set RAM[470] 1,
set RAM[500] 1,
set RAM[532] 1,
set RAM[498] 1,
set RAM[530] 1,
repeat 30000000 {
  ticktock;
}
output;