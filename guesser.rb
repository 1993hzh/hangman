require 'set'
require_relative 'game.rb'
require_relative 'frequencyBasedGuessStrategy.rb'
require_relative 'totalFrequencyGuessStrategy.rb'
require_relative 'dictionary.rb'
require_relative 'wordProvider.rb'

class Guesser

    THRESHOLD = 1

    def initialize()
        @dictionary = Dictionary.new
        @guessedLetters = Set.new
        @lastWord = nil
        @strategy = TotalFrequencyGuessStrategy.new
    end
    
    def guess(game)
        letter = nil
        begin
            letter = decideStrategy(game.word).guess.downcase
        end while @guessedLetters.include? letter && letter != Game::GIVE_UP_FLAG
        @guessedLetters.add(letter)
        return letter.upcase
    end
    
    def decideStrategy(word)
        if word.chars.select{|c| c != WordProvider::ENCRYPTED_LETTER}.size < THRESHOLD
            return @strategy
        end
        
        if word != @lastWord
            @lastWord = word
            frequency = @dictionary.collectFrequency(word)
            @strategy = FrequencyBasedGuessStrategy.new(frequency)
        end
        
        return @strategy
    end
end
