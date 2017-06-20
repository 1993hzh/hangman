require 'set'
require_relative 'game.rb'
require_relative 'frequencyBasedGuessStrategy.rb'
require_relative 'dictionary.rb'

class Guesser

    def initialize()
        @dictionary = Dictionary.new
        @guessedLetters = Set.new
        @lastWord = nil
        @strategy = nil
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
        if !(word == @lastWord)
            @lastWord = word
            frequency = @dictionary.collectFrequency(word)
            @strategy = FrequencyBasedGuessStrategy.new(frequency)
        end
        
        return @strategy
    end
end
