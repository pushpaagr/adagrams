letter_pool = [
  {letter: "A", quantity: 9},
  {letter: "B", quantity: 2},
  {letter: "C", quantity: 2},
  {letter: "D", quantity: 4},
  {letter: "E", quantity: 12},
  {letter: "F", quantity: 2},
  {letter: "G", quantity: 3},
  {letter: "H", quantity: 2},
  {letter: "I", quantity: 9},
  {letter: "J", quantity: 1},
  {letter: "K", quantity: 1},
  {letter: "L", quantity: 4},
  {letter: "M", quantity: 2},
  {letter: "N", quantity: 6},
  {letter: "O", quantity: 8},
  {letter: "P", quantity: 2},
  {letter: "Q", quantity: 1},
  {letter: "R", quantity: 6},
  {letter: "S", quantity: 4},
  {letter: "T", quantity: 6},
  {letter: "U", quantity: 4},
  {letter: "V", quantity: 2},
  {letter: "W", quantity: 2},
  {letter: "X", quantity: 1},
  {letter: "Y", quantity: 2},
  {letter: "Z", quantity: 1}
]

player_hand = []

#create new working array with .map and change line 41 to accomodate

2.times do
  random_index = rand(0..25)
  puts random_index
  while letter_pool[random_index][:quantity] == 0
    random_index = rand(0..25)
  end
  #will need to change letter_pool to new working array
  letter_pool[random_index][:quantity] = letter_pool[random_index][:quantity] - 1
  player_hand << letter_pool[random_index][:letter]

end
puts player_hand
