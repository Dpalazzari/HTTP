require 'pry'
require 'socket'
require_relative 'router.rb'
require_relative 'parser.rb'
require_relative 'dictionary.rb'
require_relative 'game.rb'


class Server

  attr_reader :tcp_server, :router, :count
  def initialize
    @tcp_server = TCPServer.new(9292)
    @router = Router.new
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
      output = router.determine_the_path(parser, count)
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
end

if __FILE__ == $0
  server = Server.new
  server.loop_the_server
end
