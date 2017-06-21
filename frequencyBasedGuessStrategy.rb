require_relative 'guessStrategy.rb'
require_relative 'game.rb'
require_relative 'log/logManager.rb'

class FrequencyBasedGuessStrategy < GuessStrategy

    @@logger = LogManager.instance.getLogger
    
    def initialize(frequency)
        @frequency = frequency
        @frequencyIndex = 0
    end

    def guess
        if @frequencyIndex >= @frequency.size
            @@logger.info("Give up since no letter found: #{@frequency.to_a.to_s}, index: #{@frequencyIndex}")
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
