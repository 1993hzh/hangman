require_relative 'guessStrategy.rb'
require_relative 'game.rb'
require_relative 'log/logManager.rb'

class TotalFrequencyGuessStrategy < GuessStrategy

    @@logger = LogManager.instance.getLogger
    @@ALPHABET_LENGTH = 26
    @@MOST_FREQUENT_FIRST_LETTERS = ['t','o','a','w','b','c','d','s','f','m','r','h','i','y','e','g','l','n','p','u','v','j','k','q','z','x'].freeze
    @@MOST_FREQUENT_LETTERS = ['E','A','R','I','O','T','N','S','L','C','U','D','P','M','H','G','B','F','Y','W','K','V','X','Z','J','Q'].freeze
    
    def initialize()
        @frequency = @@MOST_FREQUENT_LETTERS
        @frequencyIndex = 0
    end

    def guess
        if @frequencyIndex >= @frequency.size
            @@logger.info("Give up since frequency table is already traversed.")
            return Game::GIVE_UP_FLAG
        end
        
        letter = @frequency[@frequencyIndex]
        @frequencyIndex = @frequencyIndex + 1
        return letter.upcase
    end
end
