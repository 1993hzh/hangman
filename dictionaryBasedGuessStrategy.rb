require_relative 'guessStrategy.rb'
require_relative 'game.rb'
require_relative 'log/logManager.rb'

class DictionaryBasedGuessStrategy < GuessStrategy

    @@logger = LogManager.instance.getLogger
    
    def initialize(dictionary)
        @dictionary = dictionary
        @frequencyIndex = 0
    end

    def guess
        if @frequencyIndex >= @dictionary.size
            return Game::GIVE_UP_FLAG
        end
        
        letter = @dictionary.keys[@frequencyIndex]
        @@logger.info("\'#{letter}\' occurred frequency: #{getCurrent}, total frequency: #{getTotal}, rate: #{getCurrent * 100 / getTotal}%")
        @frequencyIndex = @frequencyIndex + 1
        return letter.upcase
    end
    
    def getTotal
        value = @dictionary.values.inject(0){|sum,x| sum + x }
        return value
    end
    
    def getCurrent
        value = @dictionary.values[@frequencyIndex]
        return value
    end
end
