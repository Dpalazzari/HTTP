class Game
  attr_reader :start, :correct_number, :guesses
  def initialize
    @start = false
    @guesses = []
  end

  def start_the_game
    @start = true
    @correct_number = rand(0..100)
  end

  def guess_your_number(guess_num)
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
    end
    answer
  end

  def guess_count
    guesses.count + 1
  end
end

# game = Game.new
# game.start_the_game
