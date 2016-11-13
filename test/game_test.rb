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
    game.start_the_game
    assert rand(0..100), game.correct_number
  end

  def test_it_will_tell_you_your_guesses
    game = Game.new
    game.start_the_game
    game.play_the_game
    game.play_the_game
    guesses = game.guesses
    assert_equal ["Your guess of 0 was too low. You have guessed 1 times.", "Your guess of 0 was too low. You have guessed 2 times."], guesses
  end

end
