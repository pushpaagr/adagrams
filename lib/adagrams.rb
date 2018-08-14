#wave 1
def draw_letters()
  letter_pool = [ "A", "A", "A", "A", "A", "A", "A", "A", "A", "B", "B", "C", "C", "D", "D", "D", "D", "E", "E", "E", "E", "E", "E","E", "E", "E","E", "E", "E", "F", "F", "G", "G", "G", "H", "H", "I", "I", "I", "I", "I", "I", "I", "I", "I", "J", "K", "L", "L", "L", "L", "M", "M", "N", "N", "N", "N", "N", "N", "O", "O", "O", "O", "O", "O", "O", "O", "P", "P", "Q", "R", "R", "R", "R", "R", "R", "S", "S", "S", "S", "T", "T", "T", "T", "T", "T", "U", "U", "U", "U", "V", "V", "W", "W", "X", "Y", "Y", "Z" ]

  player_hand = []

  10.times do
    random_index = rand(0..letter_pool.length)
    player_hand << letter_pool[random_index]
    letter_pool.slice!(random_index)
  end
  player_hand.each do |i|
    letter_pool << i
  end
  puts "#{letter_pool}"
  return player_hand
end

#wave 2

def uses_available_letters(input, letters_in_hand)
  input_split_array = input.scan(/\w/)

  input_split_array.each do |letter|
    if letters_in_hand.include?(letter)
      del_index = letters_in_hand.index(letter)
      puts letters_in_hand.slice!(del_index)
    else
      return false
    end
  end
return true
end
