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

end
