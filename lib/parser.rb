require 'pry'

class Parser

  attr_reader :request_lines
  def initialize(request_lines)
    @request_lines = request_lines
  end

  def verb
    verb = request_lines.detect do |line|
      line.include?("HTTP")
    end
    verb.split[0]
  end

  def path
    path = request_lines.detect do |line|
      line.include?("HTTP")
    end
    path.split[1]
  end

  def protocol
    protocol = request_lines.detect do |line|
      line.include?("HTTP")
    end
    protocol.split[2]
  end

  def host
    host = request_lines.detect do |line|
      line.include?("Host")
    end
    host.split[1].chars[0..8].join
  end

  def port
    port = request_lines.detect do |line|
      line.include?("Host")
    end
    port.split[1].chars[-4..-1].join
  end

  def origin
    origin = request_lines.detect do |line|
      line.include?("Host")
    end
    origin.split[1].chars[0..8].join
  end

  def accept
    accept = request_lines.detect do |line|
      line.include?("Accept: ")
    end
    accept.split(":")[1]
  end

  def all_parses
    diagnostic =
         "Verb: #{verb}\nPath: #{path}\nProtocol: #{protocol}\nHost: #{host}\nPort: #{port}\nOrigin: #{host}\nAccept: #{accept}"
  end


end
