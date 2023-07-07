# Game of Life
Hack-ის Assembly-ზე შექმნილი Game of Life სიმულატორი. შეიქმნა Nand2Tetris კურსის შუალედური პროექტის ფარგლებში. პროექტის შესამოწმებლად დაგჭირდებათ მხოლოდ CPU Emulator პროგრამა. ხელსაწყოების ნაკრები შეგიძლიათ გადმოწეროთ [ამ ბმულიდან](https://www.nand2tetris.org/software).

Game of Life არ არის უბრალო თამაში, ეს არის ე.წ. Cellular Automata, გამოთვლითი თეორიული კომპიუტერის ერთ-ერთი სახეობა. ცნობილია რომ ის არის Turing Complete. ეს ნიშნავს რომ მიუხედავად მისი მწირი წესებისა, თუ გვექნება უსასრულო ზომის სამყარო და სწორად განვსაზღვრავთ სამყაროს საწყის მდგომარეობას, მას შეუძლია გამოთვალოს ნებისმიერი ამოცანა, რაც კი გამოთვლადია! დეტალებისთვის იხილეთ ბმული [ვიკიპედიაზე](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

[![GE Flag](https://flagcdn.com/16x12/ge.png)](./README-ge.md) GE | [![US Flag](https://flagcdn.com/16x12/us.png)](./README.md) [US](./readme.md)

## მაგალითები
გთავაზობთ პროექტის ფარგლებში შექმნილ ანიმაციებს:

### Blinker
![blinker](https://github.com/lnadi17/game-of-life/assets/19193250/d4e3276a-e668-4902-a8af-bf47d97f5c30)

### Glider
![glider](https://github.com/lnadi17/game-of-life/assets/19193250/84f62574-961d-43af-a683-1135252dc570)

### RipConway
![ripConway](https://github.com/lnadi17/game-of-life/assets/19193250/d3048110-b3db-4456-8c03-ad8499ce446d)

## დავალება
### ამოცანა 1:

სიმულატორის სამყარო შედგება 16x32 მატრიცისგან, თითოეული უჯრა არის დაკავებული (1) ან თავისუფალი (0). სამყაროს საწყისი მდგომარეობა ჩაიტვირთება ტესტ ფაილის მეშვეობით. სამყარო მეხსიერებაზე დამეპილია შემდეგ მისამართებზე:
```
RAM[100] == grid(0, 0)
RAM[132] == grid(1, 0)
RAM[611] == grid(16, 31)
```

ხოლო RAM[99]-ში წერია თუ რამდენი იტერაცია უნდა განახორციელოს თქვენმა სიმულატორმა.
ყოველი იტერაცია აგენერირებს ახალ სამყაროს. გენერაციის წესები მარტივია:
```
For a space that is 'populated':
* Each cell with one or no neighbors dies, as if by solitude.
* Each cell with four or more neighbors dies, as if by overpopulation.
* Each cell with two or three neighbors survives.

For a space that is 'empty' or 'unpopulated'
* Each cell with three neighbors becomes populated.
```

### ამოცანა 2:
გააკეთეთ სიმულატორის ვიზუალიზაცია Hack-ის ეკრანის გამოყენებით. არსებული ეკრანი არის 256x512 რეზოლუციის. კომფორტისთვის, დავალების ფარგლებში თითოეული GameOfLife უჯრა ეკრანზე უნდა დავხატოთ 16x16 კვადრატად. შესაბამისად ეკრანიც გამოვა  16x32 კვადრატების მატრიცა.

თუ უჯრა დაკავებულია (1) მისი შესაბამისი კვადრატი უნდა გაშავდეს ეკრანზე (კვადრატის ყველა წერტილი უნდა იყოს შავი), თუ უჯრა ცარიელია (0) ეკრანზე მისი შესაბამისი კვადრატის ყველა წერტილი უნდა იყოს თეთრი. ეკრანის გადახტვა უნდა მოხდეს ყოველი იტერაციის შემდეგ!

