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

  def test_it_can_add_one_to_hello_count
    assert_equal "Hello, world! 1", router.hello
  end

  def test_it_can_reset_the_hello_count
    assert_equal 0, router.reset_hello
  end

end
