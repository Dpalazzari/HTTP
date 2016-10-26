require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/parser.rb'

class ParserTest < Minitest::Test

  attr_reader :request_lines
  def setup
    @request_lines = ["GET / HTTP/1.1",
                      "Host: 127.0.0.1:9292",
                      "Connection: keep-alive",
                      "Cache-Control: no-cache",
                      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36",
                      "Postman-Token: 56a4de11-11ba-04b7-687f-495b6d0d9e71",
                      "Accept: */*",
                      "Accept-Encoding: gzip, deflate, sdch, br",
                      "Accept-Language: en-US,en;q=0.8"]
  end

  def test_it_initializes_with_request_lines
    parser = Parser.new(request_lines)
    assert_equal "GET / HTTP/1.1", parser.request_lines[0]
  end

  def test_it_finds_the_verb
    parser = Parser.new(request_lines)
    assert_equal "GET", parser.verb
  end

  def test_it_finds_the_path
    parser = Parser.new(request_lines)
    assert_equal "/", parser.path
  end

  def test_it_can_detect_the_parameter
    parser = Parser.new(request_lines)
    assert_equal nil, parser.parameter_value
  end

  def test_it_finds_the_protocol
    parser = Parser.new(request_lines)
    assert_equal "HTTP/1.1", parser.protocol
  end

  def test_it_finds_the_host
    parser = Parser.new(request_lines)
    assert_equal "127.0.0.1", parser.host
  end

  def test_it_finds_the_port
    parser = Parser.new(request_lines)
    assert_equal "9292", parser.port
  end

  def test_it_finds_the_origin
    parser = Parser.new(request_lines)
    assert_equal "127.0.0.1", parser.origin
  end

  def test_it_can_find_the_accept
    parser = Parser.new(request_lines)
    assert_equal " */*", parser.accept
  end

  def test_it_inputs_parser_objects_in_to_diagnostic
    parser = Parser.new(request_lines)
    assert_equal "GET", parser.all_parses.split[1]
    assert_equal "/", parser.all_parses.split[3]
  end


end
