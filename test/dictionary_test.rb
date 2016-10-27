require 'minitest/autorun'
require 'minitest/pride'
require './lib/dictionary.rb'

class DictionaryTest < Minitest::Test

  attr_reader :dictionary
  def setup
    @dictionary = Dictionary.new
  end

  def test_it_exists
    assert dictionary
  end

  def test_it_can_find_a_word_from_the_dictionary
    assert_equal "Poop is a known word.", dictionary.get_word_from_dictionary("poop")
    assert_equal "Blargh is not a known word.", dictionary.get_word_from_dictionary("blargh")
  end


end
