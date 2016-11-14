require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/router.rb'
require './lib/parser.rb'

class RouterTest < Minitest::Test

  attr_reader :router
  def setup
    @router = Router.new
  end

  def test_it_exists
    assert router
  end

  def test_it_initializes_with_hello_count_equal_to_zero
    assert_equal 0, router.hello_count
  end

  def test_it_counts_hellos
    router.hello
    assert_equal 1, router.hello_count
  end

  def test_it_can_post_the_time
    output = router.date_time
    assert_equal String, output.class
  end

  def test_it_recognizes_the_hello_path
    parser = Parser.new(["GET /hello HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection: keep-alive",
                         "Postman-Token: a2057f32-06b2-f67e-cd3a-619641ec785c",
                         "Cache-Control: no-cache",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
                         "Content-Type: application/x-www-form-urlencoded",
                         "Accept: */*",
                         "Accept-Encoding: gzip, deflate, sdch, br",
                         "Accept-Language: en-US,en;q=0.8"])
    output = router.determine_the_path(parser, 1, 'TCPSocket:fd 9')
    assert_equal ["Hello, world! 1", "200 Ok"], output
  end

  def test_it_can_recognize_the_start_game_path
    parser = Parser.new(["POST /start_game HTTP/1.1",
                          "Host: 127.0.0.1:9292",
                          "Connection: keep-alive",
                          "Content-Length: 7",
                          "Postman-Token: 41928838-bae1-ba63-58c3-b947918c1a07",
                          "Cache-Control: no-cache",
                          "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
                          "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
                          "Content-Type: application/x-www-form-urlencoded",
                          "Accept: */*",
                          "Accept-Encoding: gzip, deflate, br",
                          "Accept-Language: en-US,en;q=0.8"])
    output = router.determine_the_path(parser, 1, 'TCPSocket:fd 9')
    assert_equal ["Good luck!", "301 Moved Permanently"], output
  end

  def test_it_can_start_a_game
    parser = Parser.new(["POST /start_game HTTP/1.1",
                          "Host: 127.0.0.1:9292",
                          "Connection: keep-alive",
                          "Content-Length: 7",
                          "Postman-Token: 41928838-bae1-ba63-58c3-b947918c1a07",
                          "Cache-Control: no-cache",
                          "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
                          "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
                          "Content-Type: application/x-www-form-urlencoded",
                          "Accept: */*",
                          "Accept-Encoding: gzip, deflate, br",
                          "Accept-Language: en-US,en;q=0.8"])
    output = router.start_a_game(parser)
    assert_equal "Good luck!", output
  end

  def test_it_can_return_message_with_shutdown_path
    parser_sd = Parser.new(["POST /shutdown HTTP/1.1",
                            "Host: 127.0.0.1:9292",
                            "Connection: keep-alive",
                            "Content-Length: 7",
                            "Postman-Token: 84505e0d-9e66-f431-5077-b227c774652a",
                            "Cache-Control: no-cache",
                            "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
                            "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
                            "Content-Type: application/x-www-form-urlencoded",
                            "Accept: */*",
                            "Accept-Encoding: gzip, deflate, br",
                            "Accept-Language: en-US,en;q=0.8"])
    output = router.determine_the_path(parser_sd, 1, 'TCPSocket:fd 9')
    assert_equal ["Total requests: 1", "200 Ok"], output
  end

  def test_it_can_recognize_the_date_time_path
    parser_dt = Parser.new(["GET /datetime HTTP/1.1",
                            "Host: 127.0.0.1:9292",
                            "Connection: keep-alive",
                            "Postman-Token: 1a606d5c-40fe-a6bf-e49d-6fc3c5c79032",
                            "Cache-Control: no-cache",
                            "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
                            "Content-Type: application/x-www-form-urlencoded",
                            "Accept: */*",
                            "Accept-Encoding: gzip, deflate, sdch, br",
                            "Accept-Language: en-US,en;q=0.8"])
    output = router.determine_the_path(parser_dt, 1, 'TCPSocket:fd 9')
    assert_equal "200 Ok", output[1]
    assert_equal String, output[0].class
  end

  def test_it_can_read_the_word_search_path
    parser_ws = Parser.new(["GET /word_search?word=one HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection: keep-alive",
                         "Postman-Token: 41a0341b-6e44-dadf-4f65-f550bd571293",
                         "Cache-Control: no-cache",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
                         "Content-Type: application/x-www-form-urlencoded",
                         "Accept: */*",
                         "Accept-Encoding: gzip, deflate, sdch, br",
                         "Accept-Language: en-US,en;q=0.8"])
    output = router.determine_the_path(parser_ws, 1, 'TCPSocket:fd 9')
    assert_equal ["One is a known word.", "200 Ok"], output
  end

  def test_it_can_recognize_the_force_error_path
    parser = Parser.new(["GET /force_error HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection: keep-alive",
                         "Postman-Token: 2641a3b5-8cee-8b3b-344b-efc17c5937d9",
                         "Cache-Control: no-cache",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
                         "Content-Type: application/x-www-form-urlencoded",
                         "Accept: */*",
                         "Accept-Encoding: gzip, deflate, sdch, br",
                         "Accept-Language: en-US,en;q=0.8"])
    output = router.determine_the_path(parser, 1, 'TCPSocket:fd 9')
    assert_equal ["System Error", "500 Internal Server Error"], output
  end

  def test_it_recognizes_the_get_permission_path
    parser_perm = Parser.new(["GET /get_permissions HTTP/1.1",
                              "Host: 127.0.0.1:9292",
                              "Connection: keep-alive",
                              "Postman-Token: 7ec36484-a7b1-eb89-f85a-a8f92072d08a",
                              "Cache-Control: no-cache",
                              "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
                              "Content-Type: application/x-www-form-urlencoded",
                              "Accept: */*",
                              "Accept-Encoding: gzip, deflate, sdch, br",
                              "Accept-Language: en-US,en;q=0.8"])
   output = router.determine_the_path(parser_perm, 1, 'TCPSocket:fd 9')
   assert_equal ["You do not have permission.", "401 Unauthorized"], output
  end

  def test_it_recognizes_a_gibberish_path
    parser_gibb = Parser.new(["GET /kslflskdghsk HTTP/1.1",
              "Host: 127.0.0.1:9292",
              "Connection: keep-alive",
              "Postman-Token: 5b780efa-b2fa-b03e-1005-16c92d5961e6",
              "Cache-Control: no-cache",
              "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
              "Content-Type: application/x-www-form-urlencoded",
              "Accept: */*",
              "Accept-Encoding: gzip, deflate, sdch, br",
              "Accept-Language: en-US,en;q=0.8"])
    output = router.determine_the_path(parser_gibb, 1, 'TCPSocket:fd 9')
    assert_equal ["Sorry page not found", "404 Not Found"], output
  end

end
