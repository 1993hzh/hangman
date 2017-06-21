require 'set'
require_relative 'game.rb'
require_relative 'frequencyBasedGuessStrategy.rb'
require_relative 'dictionaryBasedGuessStrategy.rb'
require_relative 'dictionary.rb'
require_relative 'wordProvider.rb'

class Guesser

    THRESHOLD = 3
    ALPHABET_LENGTH = 26
    
    def initialize()
        @dictionary = Dictionary.new
        @guessedLetters = Set.new
        @lastWord = nil
        @frequencyBasedGuessStrategy = FrequencyBasedGuessStrategy.new
        @strategy = @frequencyBasedGuessStrategy
        @forceFrequency = false
    end
    
    def guess(word)
        letter = nil
        begin
            letter = decideStrategy(word).guess.downcase
            if letter == Game::GIVE_UP_FLAG
                @forceFrequency = true
            end
        end while needMoreGuess(letter)
        @guessedLetters.add(letter)
        return letter.upcase
    end
    
    def needMoreGuess(letter)
        #TODO in case of infinite loop
        @guessedLetters.include? letter || letter == Game::GIVE_UP_FLAG
    end
    
    def decideStrategy(word)
        if @forceFrequency
            @strategy = @frequencyBasedGuessStrategy
            return @strategy
        end
    
        if word.chars.select{|c| c != WordProvider::ENCRYPTED_LETTER}.size < THRESHOLD
            @strategy = @frequencyBasedGuessStrategy
            return @strategy
        end
        
        if word != @lastWord
            @lastWord = word
            @strategy = DictionaryBasedGuessStrategy.new(@dictionary.collect(word))
        end
        
        return @strategy
    end
    
    def getThreshold(length)
        if length <= 5
            return 2
        elsif length <= 8
            return 1
        elsif length <= 12
            return 1
        else
            return 0
        end
    end
end
