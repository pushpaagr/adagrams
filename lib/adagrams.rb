#wave 1

def draw_letters()

#static hash -- easy to change for future developer
  static_letter_hash = {
    A: 9,
    B: 2,
    C: 2,
    D: 4,
    E: 12,
    F: 2,
    G: 3,
    H: 2,
    I: 9,
    J: 1,
    K: 1,
    L: 4,
    M: 2,
    N: 6,
    O: 8,
    P: 2,
    Q: 1,
    R: 6,
    S: 4,
    T: 6,
    U: 4,
    V: 2,
    W: 2,
    X: 1,
    Y: 2,
    Z: 1
  }

#creates a letter_pool array from hash, to maintain letter/quantity odds, also to devloper to change hash orginal quanity value of letters.
  letter_pool = []

# iterating hash into letter pool array.
  static_letter_hash.each do |letter, quantity|
    quantity.times do
      letter_pool << letter.to_s
    end
  end
  player_hand = []


#randomly pulls from letter pool and puts 10 cards in players hand

  10.times do
    random_index = rand(0..letter_pool.length)
    player_hand << letter_pool[random_index]
    letter_pool.slice!(random_index)
  end
  player_hand.each do |i|
    letter_pool << i
  end
  return player_hand
end

#wave 2

def uses_available_letters(input, letters_in_hand)

#takes input word and converts into a array for each letter
  input_split_array = input.scan(/\w/)

#compares each letter in input word to see if it's in the player_hand array and deltes letter in hand to make sure it's not used to twice. return false if letter from input word is not in the player_hand.
  input_split_array.each do |letter|
    if letters_in_hand.include?(letter)
      del_index = letters_in_hand.index(letter)
      letters_in_hand.slice!(del_index)
    else
      return false
    end
  end
  return true
end


# wave 3

def score_word (word)

#spits the input word into an array of letter for each letter.
  letters_to_score = word.scan(/\w/)
  score = 0

#check if length of word is greater than or = 7, if so adds 8 to score.
  if letters_to_score.length >= 7
    score = score + 8
  end

#checks to see what the score value is of each letter from player's word, and adds to the score.
  letters_to_score.each do |letter|

    case letter.upcase
    when "A", "E", "I", "O", "U", "L", "N", "R", "S", "T"
      score = score + 1
    when "D", "G"
      score = score + 2
    when "B", "C", "M", "P"
      score = score + 3
    when "F", "H", "V", "W", "Y"
      score = score + 4
    when "K"
      score = score + 5
    when "J", "X"
      score = score + 8
    when "Q", "Z"
      score = score + 10
    end
  end
  return score
end

# wave 4
#array of words (words)
def highest_score_from(words)

  scored_array = []
  winners_or_ties = []

  # score each word inputted using score_word method, and then puts word, and score in hash for each word, that then goes inside of an array.  we now have array(scored_array) of hashes (scored_word).
  words.each do |word|
    points = score_word(word)
    scored_word = {
      word: word,
      score: points
    }
    scored_array << scored_word
  end

  # make array of all scores to find max value
  values = []
  scored_array.each do |item|
    values << item[:score]
  end

  # find highest score value
  highest_score = values.max

  # sorts scored_array and if the word score value  == highest score variable then it puts in a winner array
  scored_array.each do |item|
    if item[:score] == highest_score
      winners_or_ties << item
    end
  end

  winner = []
# gives the winner in the array if there is only one winner(index)
  if winners_or_ties.length == 1
    return winners_or_ties.first
  end

 # gives winner if length of word in the winners_or_ties is  10
  winners_or_ties.each do |item|
    if item[:word].length == 10
      winner = item
      return winner
    end
  end

# finds the shortest length of a word in the winners_or_ties and puts the winner with the shortest word 
  winner_first_hash = winners_or_ties.first
  winners_or_ties.each do |item|
    if item[:word].length < winner_first_hash[:word].length
      winner_first_hash = item
    end
  end
  return winner_first_hash
end
