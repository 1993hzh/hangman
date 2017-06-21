require 'test/unit'
require_relative '../game.rb'
require_relative '../dictionaryBasedGuessStrategy.rb'
require_relative '../frequencyBasedGuessStrategy.rb'

class StrategyTest < Test::Unit::TestCase

    def testFrequencyStrategy
        strategy = FrequencyBasedGuessStrategy.new
        
        for i in 1..26
            letter = strategy.guess
            assert_equal(letter, FrequencyBasedGuessStrategy::MOST_FREQUENT_LETTERS[i - 1].upcase)
        end
    end
    
    def testFrequencyStrategyWhenExceedLimit
        strategy = FrequencyBasedGuessStrategy.new
        
        for i in 1..26
            letter = strategy.guess
        end
        
        letter = strategy.guess
        assert_equal(letter, FrequencyBasedGuessStrategy::MOST_FREQUENT_LETTERS[0].upcase)
    end

    def testDictionaryStrategy
        dictionary = { :a => 10, :b => 9, :c => 8 }
        strategy = DictionaryBasedGuessStrategy.new(dictionary)
        
        dictionary.each do|key, value|
            #should assert getCurrent first since guess will let the index increase by 1
            assert_equal(strategy.getCurrent, value)
            letter = strategy.guess
            assert_equal(letter, key.upcase)
        end
    end

    def testDictionaryStrategyWhenExceedLimit
        dictionary = { :a => 10, :b => 9, :c => 8 }
        strategy = DictionaryBasedGuessStrategy.new(dictionary)
        
        dictionary.each do|entry|
            letter = strategy.guess
        end
        
        letter = strategy.guess
        assert_equal(letter, Game::GIVE_UP_FLAG)
    end
    
    def testDictionaryStrategyTotal
        dictionary = { :a => 10, :b => 9, :c => 8 }
        strategy = DictionaryBasedGuessStrategy.new(dictionary)
        assert_equal(strategy.getTotal, 27)
    end
end
