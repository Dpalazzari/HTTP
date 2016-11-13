require 'pry'
require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server.rb'
require './lib/parser.rb'

class ServerTest < Minitest::Test

  def test_it_exists
    assert 200, Faraday.get("http://127.0.0.1:9292").status
  end

  def test_it_can_post_the_verb
    server = Faraday.get("http://127.0.0.1:9292/")
    assert server.body.include?("GET")
  end

  def test_it_can_know_a_different_verb
    server = Faraday.get("http://127.0.0.1:9292/start_game")
    assert server.body
  end

  def test_it_can_discern_the_path
    server = Faraday.get("http://127.0.0.1:9292/")
    assert server.body.include?("/")
  end

  def test_it_outputs_hello
    server = Faraday.get("http://127.0.0.1:9292/hello")
    assert server.body.include?("Hello, world!")
  end

  def test_it_can_read_the_date_time_path
    server = Faraday.get("http://127.0.0.1:9292/datetime")
    assert server.body
  end

  def test_it_can_read_the_word_search_path
    server = Faraday.get("http://127.0.0.1:9292/word_search?word=poop")
    assert server.body
  end

  def test_it_returns_the_time_of_day
    server = Faraday.get("http://127.0.0.1:9292/datetime")
    assert server.body.include?("2016")
  end

  def test_it_returns_system_error
    server = Faraday.get("http://127.0.0.1:9292/force_error")
    assert server.body.include?("System Error")
  end

  def test_it_does_nothing_with_no_path
    server = Faraday.get("http://127.0.0.1:9292/kflgjfhgk")
    assert_equal "Sorry page not found", server.body
  end


end
