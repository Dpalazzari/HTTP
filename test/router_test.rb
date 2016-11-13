require 'minitest/autorun'
require 'minitest/pride'
require './lib/router.rb'
require './lib/parser.rb'

class RouterTest < Minitest::Test

  attr_reader :router
  def setup
    @router = Router.new
  end

  def test_it_exists
    assert router
  end

  def test_it_initializes_with_hello_count_equal_to_zero
    assert_equal 0, router.hello_count
  end

  def test_it_counts_hellos
    output = router.hello
    assert_equal 1, router.hello_count
  end

end
