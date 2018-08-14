require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/adagrams'

# Get that nice colorized output
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe 'Adagrams' do
  xdescribe 'draw_letters method' do
    it 'draws ten letters from the letter pool' do
      drawn_letters = draw_letters
      expect(drawn_letters.size).must_equal 10
    end

    it 'returns an array, and each item is a single-letter string' do
      drawn_letters = draw_letters
      expect(drawn_letters.size).must_equal 10

      expect(drawn_letters).must_be_instance_of Array
      drawn_letters.each do |letter|
        expect(letter).must_be_instance_of String
        expect(letter.length).must_equal 1
      end
    end
  end

  describe 'uses_available_letters method' do

    it 'returns true if the submitted letters are valid against the drawn letters' do
      drawn_letters = ['D', 'O', 'G', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
      test_word = 'DOG'

      is_valid = uses_available_letters test_word, drawn_letters

      expect(is_valid).must_equal true
    end

    it 'returns false word contains letters not in the drawn letters' do
      drawn_letters = ['D', 'O', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
      test_word = 'DOG'

      is_valid = uses_available_letters test_word, drawn_letters

      expect(is_valid).must_equal false
    end

    it 'returns false word contains repeated letters more than in the drawn letters' do
      drawn_letters = ['A', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
      test_word = 'AAA'

      is_valid = uses_available_letters test_word, drawn_letters

      expect(is_valid).must_equal false
    end

  end

  xdescribe 'score_word method' do
    it 'returns an accurate numerical score according to the score chart' do
      expect(score_word("A")).must_equal 1
      expect(score_word("DOG")).must_equal 5
      expect(score_word("WHIMSY")).must_equal 17
    end

    it 'returns a score regardless of input case' do
      expect(score_word("a")).must_equal 1
      expect(score_word("dog")).must_equal 5
      expect(score_word("wHiMsY")).must_equal 17
    end

    it 'returns a score of 0 if given an empty input' do
      expect(score_word("")).must_equal 0
    end

    it 'adds an extra 8 points if the word is 7 or more characters long' do
      expect(score_word("XXXXXXX")).must_equal 64
      expect(score_word("XXXXXXXX")).must_equal 72
      expect(score_word("XXXXXXXXX")).must_equal 80
    end
  end

  xdescribe 'highest_score_from method' do
    it 'returns a hash that contains the word and score of best word in an array' do
      words = ['X', 'XX', 'XXX', 'XXXX']
      best_word = highest_score_from words

      expect(best_word[:word]).must_equal 'XXXX'
      expect(best_word[:score]).must_equal 32
    end

    it 'accurately finds best scoring word even if not sorted' do
      words = ['XXX', 'XXXX', 'XX', 'X']
      best_word = highest_score_from words

      expect(best_word[:word]).must_equal 'XXXX'
      expect(best_word[:score]).must_equal 32
    end

    it 'in case of tied score, prefers the word with fewer letters' do
      # the character 'M' is worth 3 points, 'W' is 4 points
      words = ['MMMM', 'WWW']

      # verify both have a score of 12
      expect(score_word(words.first)).must_equal 12
      expect(score_word(words.last)).must_equal 12

      best_word = highest_score_from words

      expect(best_word[:word]).must_equal 'WWW'
      expect(best_word[:score]).must_equal 12
    end

    it 'in case of tied score, prefers the word with fewer letters regardless of order' do
      # the character 'M' is worth 3 points, 'W' is 4 points
      words = ['WWW', 'MMMM']

      # verify both have a score of 12
      expect(score_word(words.first)).must_equal 12
      expect(score_word(words.last)).must_equal 12

      best_word = highest_score_from words

      expect(best_word[:word]).must_equal 'WWW'
      expect(best_word[:score]).must_equal 12
    end

    it 'in case of tied score, prefers most the word with 10 letters' do
      # the character 'A' is worth 1 point, 'B' is 3 points
      words = ['AAAAAAAAAA', 'BBBBBB']

      # verify both have a score of 10
      expect(score_word(words.first)).must_equal 18
      expect(score_word(words.last)).must_equal 18

      best_word = highest_score_from words

      expect(best_word[:word]).must_equal 'AAAAAAAAAA'
      expect(best_word[:score]).must_equal 18
    end

    it 'in case of tied score, prefers most the word with 10 letters regardless of order' do
      # the character 'A' is worth 1 point, 'B' is 3 points
      words = ['BBBBBB', 'AAAAAAAAAA']

      # verify both have a score of 10
      expect(score_word(words.first)).must_equal 18
      expect(score_word(words.last)).must_equal 18

      best_word = highest_score_from words

      expect(best_word[:word]).must_equal 'AAAAAAAAAA'
      expect(best_word[:score]).must_equal 18
    end

    it 'in case of tied score and same length words, prefers the first word' do
      # the character 'A' is worth 1 point, 'E' is 1 point
      words = ['AAAAAAAAAA', 'EEEEEEEEEE']

      # verify both have a score of 10
      expect(score_word(words.first)).must_equal 18
      expect(score_word(words.last)).must_equal 18

      best_word = highest_score_from words

      expect(best_word[:word]).must_equal words.first
      expect(best_word[:score]).must_equal 18
    end
  end
end
