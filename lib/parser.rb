require 'pry'

class Parser

  attr_reader :request_lines
  def initialize(request_lines)
    @request_lines = request_lines
  end

  def detect_header(header)
    request_lines.detect do |line|
      line.include?(header)
    end
  end

  def content_length
    request_lines.find do |line|
      line.include?("Content-Length")
    end.split[-1]
  end

  def verb
    detect_header("HTTP").split[0]
  end

  def path
    if detect_header("HTTP").include?("?")
      detect_header("HTTP").split[1].split("?")[0]
    else
      detect_header("HTTP").split[1]
    end
  end

  def parameter_value
    if detect_header("HTTP").include?("?")
      param = detect_header("HTTP").split
      param_1 = param[1].split("?")
      param_2 = param_1[1].split("=")
      word = param_2[1]
    end
  end

  def protocol
    detect_header("HTTP").split[2]
  end

  def host
    detect_header("Host").split[1].chars[0..8].join
  end

  def port
    detect_header("Host").split[1].chars[-4..-1].join
  end


  def origin
    detect_header("Host").split[1].chars[0..8].join
  end

  def accept
    detect_header("Accept: ").split(":")[1]
  end

  def all_parses
    diagnostic =
         "Verb: #{verb}\nPath: #{path}\nProtocol: #{protocol}\nHost: #{host}\nPort: #{port}\nOrigin: #{host}\nAccept: #{accept}"
  end


end
