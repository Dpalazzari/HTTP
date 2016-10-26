require 'pry'
require 'socket'
require_relative 'parser.rb'

class Server

  attr_reader :tcp_server, :hello_count
  def initialize
    @tcp_server = TCPServer.new(9292)
    @hello_count = 0
  end
  #need to develop testing with faraday =>
  #need to implement different PATHS: /hello, /game, /word_search, /datetime, /shutdown <= loop
  #should break when the user types in /shutdown
  def loop_the_server
    loop do
      client = tcp_server.accept
      puts "Ready for a request"

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
        # binding.pry
      end
      parser = Parser.new(request_lines)
      output = determine_the_path(parser)
      parser.all_parses
      puts "Got this request:"
      puts request_lines.inspect
      puts "Sending response."
      response = "<pre>" + output + "</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%e %b %Y %H:%M:%S%p')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      puts ["Wrote this response:", headers, output].join("\n")
      client.close
      puts "\nResponse complete, exiting."
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
    end
  end
end

if __FILE__ == $0
  server = Server.new
  server.loop_the_server
end
