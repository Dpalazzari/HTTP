require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server.rb'

class ServerTest < Minitest::Test

  attr_reader :server
  def setup
    @server = Faraday.get("http://127.0.0.1:9292")
  end

  def test_it_exists
    assert 200, server.status
  end

  def test_word_search
    response = Faraday.get("http://127.0.0.1:9292/wordsearch")
    binding.pry

  end

  # def test_what_its_path_is
  #   assert_equal 9292, server.port
  # end


end
