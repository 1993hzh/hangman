require 'set'
require_relative 'game.rb'
require_relative 'frequencyBasedGuessStrategy.rb'
require_relative 'totalFrequencyGuessStrategy.rb'
require_relative 'dictionary.rb'
require_relative 'wordProvider.rb'

class Guesser

    THRESHOLD = 3
    
    @@ALPHABET_LENGTH = 26
    def initialize()
        @dictionary = Dictionary.new
        @guessedLetters = Set.new
        @lastWord = nil
        @totalFrequencyGuessStrategy = TotalFrequencyGuessStrategy.new
        @strategy = @totalFrequencyGuessStrategy
        @forceTotalFrequency = false
    end
    
    def guess(game)
        letter = nil
        begin
            letter = decideStrategy(game.word).guess.downcase
            if letter == Game::GIVE_UP_FLAG
                @forceTotalFrequency = true
            end
        end while @guessedLetters.include? letter || @guessedLetters.size > @@ALPHABET_LENGTH
        @guessedLetters.add(letter)
        return letter.upcase
    end
    
    def decideStrategy(word)
        if @forceTotalFrequency
            @strategy = @totalFrequencyGuessStrategy
            return @strategy
        end
    
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
