require_relative 'parser.rb'
require_relative 'dictionary.rb'
require_relative 'server.rb'

class Router

  attr_reader :hello_count, :game
  def initialize
    @hello_count = 0
    @game = Game.new
  end

  def determine_the_path(parser, count, client)
    if parser.path == "/"
      [parser.all_parses, "200 Ok"]
    elsif parser.path == "/hello"
      [hello, "200 Ok"]
    elsif parser.path == "/datetime"
      [date_time, "200 Ok"]
    elsif parser.path == "/shutdown"
      ["Total requests: #{count}", "200 Ok"]
    elsif parser.path == "/word_search"
      [word_search(parser), "200 Ok"]
    elsif parser.path == "/start_game" && parser.verb == "POST"
      if game.start
        ["Game already started.", "403 Forbidden"]
      else
        [start_a_game(parser), "200 Ok"]
      end
    elsif parser.path == "/game" && parser.verb == "POST"
      [game_post(client, parser), "200 Ok"]
    elsif parser.path == "/game"
      [game_play(parser), "200 Ok"]
    elsif parser.path == "/force_error"
      ["System Error", "500 Internal Server Error"]
    else
      ["Sorry page not found", "404 Not Found"]
    end
  end

  def hello
    @hello_count += 1
    "Hello, world! #{hello_count}"
  end

  def date_time
    Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
  end

  def word_search(parser)
    directory = Dictionary.new
    directory.get_word_from_dictionary(parser.parameter_value)
  end

  def start_a_game(parser)
    game.start_the_game
    "Good luck!"
  end

  def game_play(parser)
    game.play_the_game
  end

  def game_post(client, parser)
    value = parser.content_length
    game.get_guess_value(client, value)
  end

end
