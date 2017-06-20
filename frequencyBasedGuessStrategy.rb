require 'logger'
require_relative 'guessStrategy.rb'
require_relative 'game.rb'

class FrequencyBasedGuessStrategy < GuessStrategy

    @@logger = Logger.new(STDOUT)
    @@logger.level = Logger::INFO
    @@ALPHABET_LENGTH = 26
    @@MOST_FREQUENT_FIRST_LETTERS = ['t','o','a','w','b','c','d','s','f','m','r','h','i','y','e','g','l','n','p','u','v','j','k','q','z','x'].freeze
    @@MOST_FREQUENT_LETTERS = ['E','A','R','I','O','T','N','S','L','C','U','D','P','M','H','G','B','F','Y','W','K','V','X','Z','J','Q'].freeze
    
    def initialize(frequency)
        @frequency = frequency
        @frequencyIndex = 0
    end

    def guess
        if @frequencyIndex >= @frequency.size
            return Game::GIVE_UP_FLAG
        end
        
        letter = @frequency.keys[@frequencyIndex]
        @@logger.info("\'#{letter}\' occurred frequency: #{getCurrent}, total frequency: #{getTotal}, rate: #{getCurrent * 100 / getTotal}%")
        @frequencyIndex = @frequencyIndex + 1
        return letter.upcase
    end
    
    def getTotal
        value = @frequency.values.inject(0){|sum,x| sum + x }
        return value
    end
    
    def getCurrent
        value = @frequency.values[@frequencyIndex]
        return value
    end
end
