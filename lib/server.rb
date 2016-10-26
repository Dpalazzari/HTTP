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
      # @hello_count += 1
      puts "Ready for a request"

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
        # binding.pry
      end
      parser = Parser.new(request_lines)
      puts "Got this request:"
      puts request_lines.inspect
      if parser.all_parses.include?(" / ")

      end
 # ["GET / HTTP/1.1",
 # "Host: 127.0.0.1:9292",
 # "Connection: keep-alive",
 # "Cache-Control: no-cache",
 # "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36",
 # "Postman-Token: 56a4de11-11ba-04b7-687f-495b6d0d9e71",
 # "Accept: */*",
 # "Accept-Encoding: gzip, deflate, sdch, br",
 # "Accept-Language: en-US,en;q=0.8"]

      puts "Sending response."
      response = "#{}"
      output = "#{response}"
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
end

if __FILE__ == $0
  server = Server.new
  server.loop_the_server
end
