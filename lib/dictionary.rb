require 'pry'

class Dictionary

  def get_word_from_dictionary(word)
    dictionary = File.readlines("/usr/share/dict/words")
    if dictionary.include?(word+"\n")
       return "#{word.capitalize} is a known word."
    else
      return "#{word.capitalize} is not a known word."
    end
  end
end

# dic = Dictionary.new
# dic.get_word_from_dictionary("a")
