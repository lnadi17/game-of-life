# Nand2Tetris Midterm Project: Game of Life
Hack-ის Assembly-ზე დაწერეთ Game of Life სიმულატორი. პროექტის შესამოწმებლად დაგჭირდებათ მხოლოდ CPU Emulator პროგრამა.

### [50%] ამოცანა 1:

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

### [50%] ამოცანა 2:
გააკეთეთ სიმულატორის ვიზუალიზაცია Hack-ის ეკრანის გამოყენებით. არსებული ეკრანი არის 256x512 რეზოლუციის. კომფორტისთვის, დავალების ფარგლებში თითოეული GameOfLife უჯრა ეკრანზე უნდა დავხატოთ 16x16 კვადრატად. შესაბამისად ეკრანიც გამოვა  16x32 კვადრატების მატრიცა.

თუ უჯრა დაკავებულია (1) მისი შესაბამისი კვადრატი უნდა გაშავდეს ეკრანზე (კვადრატის ყველა წერტილი უნდა იყოს შავი), თუ უჯრა ცარიელია (0) ეკრანზე მისი შესაბამისი კვადრატის ყველა წერტილი უნდა იყოს თეთრი.

ეკრანის გადახტვა უნდა მოხდეს ყოველი იტერაციის შემდეგ!

Game of Life არ არის უბრალო თამაში, ეს არის ე.წ. Cellular automata, გამოთვლითი თეორიული კომპიუტერის ერთ-ერთი სახეობა. ცნობილია რომ ის არის Turing complete. რაც ნიშნავს რომ მიუხედავად მისი მწირი წესებისა, თუ გვექნება უსასრულო ზომის სამყარო და სწორად განვსაზღვრავთ სამყაროს საწყის მდგომარეობას, მას შეუძლია გამოთვალოს ნებისმიერი ამოცანა, რაც კი გამოთვლადია!

დეტალებისთვის იხილეთ ბმული https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
