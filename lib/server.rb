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
      request_lines = building_the_request_lines(client)
      parser = Parser.new(request_lines)
      output = router.determine_the_path(parser, count, client)
       if  output.include?("redirect")
         printed_headers = redirect
       else
         printed_headers =  what_the_header_prints(output[0], output[1])
       end
       client.puts printed_headers
       client.puts output[0]
       client.close
      if parser.path.include?("/shutdown")
        exit
      end
    end
  end

  def building_the_request_lines(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def what_the_header_prints(output, status)
    headers = "http/1.1 #{status}",
              "date: #{Time.now.strftime('%e %b %Y %H:%M:%S%p')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"
  end

  def redirect
    redirect_header = "http/1.1 301 Moved Permanently",
                       "Location: http://127.0.0.1:9292/game",
                       "date: #{Time.now.strftime('%e %b %Y %H:%M:%S%p')}",
                       "server: ruby",
                       "content-type: text/html; charset=iso-8859-1",
                       "content-length: \r\n\r\n"
  end

end

if __FILE__ == $0
  server = Server.new
  server.loop_the_server
end
