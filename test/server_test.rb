require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server.rb'
require './lib/parser.rb'

class ServerTest < Minitest::Test

  def test_it_exists
    assert 200, Faraday.get("http://127.0.0.1:9292").status
  end

  def test_hello_reset
    Faraday.get("http://127.0.0.1:9292/reset_hello")
    assert_equal "Hello, world! 1", Faraday.get("http://127.0.0.1:9292/hello").body
    assert_equal "Hello, world! 2", Faraday.get("http://127.0.0.1:9292/hello").body
    Faraday.get("http://127.0.0.1:9292/reset_hello")
    assert_equal "Hello, world! 1", Faraday.get("http://127.0.0.1:9292/hello").body
  end

  def test_it_outputs_hello
    server = Faraday.get("http://127.0.0.1:9292/hello")
    assert server.body.include?("Hello, world!")
  end

  def test_it_returns_good_luck_at_the_start_of_the_game
    assert_equal "Good luck!", Faraday.post("http://127.0.0.1:9292/start_game").body
  end


  def test_it_returns_how_many_guesses_have_been_taken
    Faraday.post("http://127.0.0.1:9292/start_game")
    assert_equal "You have made 1 guess(es), and they were as follows:  ", Faraday.get("http://127.0.0.1:9292/game").body
  end


end
