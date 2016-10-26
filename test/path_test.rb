require 'minitest/autorun'
require 'minitest/pride'
require './lib/path.rb'
require 'pry'

class PathTest < Minitest::Test

  attr_reader :path
  def setup
    @path = Path.new
  end

  def test_it_exists
    assert path
  end

  def test_it_accepts_a_path_input
    
  end

end
