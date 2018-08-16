#wave 1

def draw_letters()

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

  letter_pool = []

  static_letter_hash.each do |letter, quantity|
    quantity.times do
      letter_pool << letter.to_s
    end
  end
  player_hand = []

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
  input_split_array = input.scan(/\w/)

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
  letters_to_score = word.scan(/\w/)
  score = 0

  if letters_to_score.length >= 7
    score = score + 8
  end

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

wordy = ['MMMM', 'WWW']

def highest_score_from(words)

  scored_array = []
  winners_or_ties = []

  # score each word inputted
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

# sort input and if score == highest score variable and put in a winner array
  scored_array.each do |item|
    if item[:score] == highest_score
      winners_or_ties << item
    end
  end

puts "#{winners_or_ties}"
winner = []
  if winners_or_ties.length == 1
    return winners_or_ties.first
  elsif
    winners_or_ties.each do |item|
      if item[:word].length == 10
        return item
      else
        winners_
        winners_or_ties.each do |item|
        ties << item[:word].length
      end
          return
        end
      end
    end
end

puts highest_score_from(wordy)
