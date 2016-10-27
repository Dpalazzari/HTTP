require 'minitest/autorun'
require 'minitest/pride'
require './lib/game.rb'

class GameTest < Minitest::Test

  def test_it_exists
    assert Game.new
  end

  def test_game_initializes_as_false
    game = Game.new
    assert_equal false, game.start
  end

  def test_the_game_can_start
    game = Game.new
    game.start_the_game
    assert_equal true, game.start
  end

  def test_it_creates_a_random_number
    game = Game.new
    game.start_the_game
    assert_equal true, game.correct_number > 0
  end

  def test_it_stores_guessed_num_in_a_hash_with_result
    game = Game.new
    game.start_the_game
    correct_number = game.correct_number
    game.guess_your_number(1)
    game.guess_your_number(correct_number)
    guesses = game.guesses
    assert_equal "Your guess of 1 was too low. You have guessed 1 times.", guesses.first
  end

  def test_it_will_tell_you_your_guesses
    skip
    game = Game.new
    game.start_the_game
    correct_number = game.correct_number
    game.guess_your_number(100)
    game.guess_your_number(1)
    game.guess_your_number(correct_number)
    guesses = game.guesses
    assert_equal ["Your guess of 100 was too high. You have guessed 1 times.", "Your guess of 1 was too low.  You have guessed 2 times."], guesses
  end

end
