require 'pry'
require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server.rb'
require './lib/parser.rb'

class ServerTest < Minitest::Test

  attr_reader :server
  def setup
    @server = Faraday.new
    # binding.pry
  end

  def test_it_exists
    assert 200, @server.get("http://127.0.0.1:9292").status
  end

  def test_hello_reset
    @server.get("http://127.0.0.1:9292/reset_hello")
    assert_equal "Hello, world! 1", @server.get("http://127.0.0.1:9292/hello").body
    assert_equal "Hello, world! 2", @server.get("http://127.0.0.1:9292/hello").body
    @server.get("http://127.0.0.1:9292/reset_hello")
    assert_equal "Hello, world! 1", @server.get("http://127.0.0.1:9292/hello").body
  end

  def test_it_outputs_hello
    skip
    request_lines = ["GET /hello HTTP/1.1",
                      "Host: 127.0.0.1:9292",
                      "Connection: keep-alive",
                      "Cache-Control: no-cache",
                      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36",
                      "Postman-Token: 56a4de11-11ba-04b7-687f-495b6d0d9e71",
                      "Accept: */*",
                      "Accept-Encoding: gzip, deflate, sdch, br",
                      "Accept-Language: en-US,en;q=0.8"]
    parser = Parser.new(request_lines)
    # binding.pry
    assert_equal "Hello, world! 1", @server.get("http://127.0.0.1:9292/hello").body
  end

  def test_it_returns_good_luck_at_the_start_of_the_game
    assert_equal "Good luck!", @server.post("http://127.0.0.1:9292/start_game").body
  end


  def test_it_returns_how_many_guesses_have_been_taken
    @server.post("http://127.0.0.1:9292/start_game")
    assert_equal "You have made 1, and they were as follows:  ", @server.get("http://127.0.0.1:9292/game").body
  end


end
