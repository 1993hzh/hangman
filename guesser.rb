require_relative 'Game'
require_relative 'FrequencyBasedGuessStrategy'
require_relative 'DictionaryBasedGuessStrategy'

class Guesser

    def initialize()
        @frequencyBasedGuessStrategy = FrequencyBasedGuessStrategy.new
        @dictionaryBasedGuessStrategy = nil
    end
    
    def guess(game)
        letter = decideStrategy(game.word).guess
        return letter.upcase
    end
    
    def decideStrategy(word)
        if @dictionaryBasedGuessStrategy == nil
            @dictionaryBasedGuessStrategy = DictionaryBasedGuessStrategy.new(word)
        end
        return @dictionaryBasedGuessStrategy
    end
end