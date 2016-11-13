class Game
  attr_reader :start, :correct_number, :guesses, :guess_num
  def initialize
    @start = false
    @guesses = []
    @guess_num = 0
  end

  def start_the_game
    @start = true
    @correct_number = rand(0..100)
  end

  def get_guess_value(client, value)
    input = value.to_i
    number = client.read(input)
    @guess_num = number.split(/=/)[-1].to_i
    return "redirect"
  end

  def play_the_game
    case
    when guess_num > @correct_number
      answer = "Your guess of #{guess_num} was too high. You have guessed #{guess_count} times."
      @guesses << answer
      answer
    when guess_num < @correct_number
      answer = "Your guess of #{guess_num} was too low. You have guessed #{guess_count} times."
      @guesses << answer
      answer
    else
      answer = "Your guess of #{guess_num} was exactly right...finally! Only took you #{guess_count} times..."
      answer
      @start = false
    end
    answer
  end

  def guess_count
    guesses.count + 1
  end
end
