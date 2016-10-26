require 'pry'
require 'socket'
require_relative 'parser.rb'
require_relative 'dictionary.rb'

class Server

  attr_reader :tcp_server, :hello_count, :count
  def initialize
    @tcp_server = TCPServer.new(9292)
    @hello_count = 0
    @count = 0
  end

  def loop_the_server
    loop do
      @count += 1
      client = tcp_server.accept
      puts "The NSA is listening..."
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      parser = Parser.new(request_lines)
      output = determine_the_path(parser)
      response = output
      output = "#{response}"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%e %b %Y %H:%M:%S%p')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output
      client.close
      puts [headers, output].join("\n")
      puts "\nNSA data suction complete. Exiting."
      if parser.path.include?("/shutdown")
        exit
      end
    end
  end

  def determine_the_path(parser)
    if parser.path == "/"
      output = parser.all_parses
    elsif parser.path == "/hello"
      @hello_count += 1
      output =  "Hello, world! #{hello_count}"
    elsif parser.path == "/datetime"
      output = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
    elsif parser.path == "/shutdown"
      output = "Total requests: #{count}"
    elsif parser.path == "/wordsearch"
      word_search(parser)
    end
  end

  def word_search(parser)
    directory = Dictionary.new
    directory.get_word_from_dictionary(parser.parameter_value)
  end
end

if __FILE__ == $0
  server = Server.new
  server.loop_the_server
end
