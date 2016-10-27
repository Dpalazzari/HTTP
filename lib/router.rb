require 'pry'
require_relative 'parser.rb'
require_relative 'dictionary.rb'
require_relative 'server.rb'


class Router

  attr_reader :hello_count
  def initialize
    @hello_count = 0
  end

  def determine_the_path(parser, count)
    if parser.path == "/"
      output = parser.all_parses
    elsif parser.path == "/hello"
      hello
    elsif parser.path == "/reset_hello"
      reset_hello
    elsif parser.path == "/datetime"
      date_time
    elsif parser.path == "/shutdown"
      output = "Total requests: #{count}"
    elsif parser.path == "/word_search"
      word_search(parser)
    elsif parser.path == "/start_game" && parser.verb == "POST"
      start_a_game
    elsif parser.path == "/game" && parser.verb == "POST"
      game_post(parser)
    elsif parser.path == "/game"
      game
    end
  end

  def hello
    @hello_count += 1
    output =  "Hello, world! #{hello_count}"
  end

  def reset_hello
    @hello_count = 0
  end

  def date_time
    output = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
  end

  def word_search(parser)
    directory = Dictionary.new
    directory.get_word_from_dictionary(parser.parameter_value)
  end

  def start_a_game
    @game = Game.new
    @game.start_the_game
    "Good luck!"
  end

  def game
    num_guesses = @game.guess_count
    guesses = @game.guesses.join("\n")
    output = "You have made #{num_guesses} guess(es), and they were as follows: #{guesses} "
  end

  def game_post(parser)
    output = @game.guess_your_number(parser.guess_grabber)
  end

end
