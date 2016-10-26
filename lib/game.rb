# require './lib/server.rb'

class Game
  attr_reader :start, :correct_number
  def initialize
    @start = false
    @guess_counter = 0
  end

  def start_the_game
    @start = true
    @correct_number = rand(0..100)
  end

  def guess_your_number(guess_num)
    guess_count += 1
    if guess_num > @correct_number
      puts "Your guess of #{guess_num} was too high. You have guessed #{guess_count} times."
    elsif guess_num < @correct_number
      puts "Your guess of #{guess_num} was too low. You have guessed #{guess_count} times."
    else guess_num = @correct_number
      puts "Your guess of #{guess_num} was exactly right...finally! Only took you #{guess_count} times..."
    end
  end
end

# game = Game.new
# game.start_the_game
