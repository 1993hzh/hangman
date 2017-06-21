require 'test/unit'
require_relative 'mockGuesser.rb'
require_relative '../guessStrategy.rb'
require_relative '../guesser.rb'
require_relative '../frequencyBasedGuessStrategy.rb'
require_relative '../dictionaryBasedGuessStrategy.rb'

class GuesserTest < Test::Unit::TestCase

    def testForceFrequencyStrategy
        guesser = Guesser.new
        strategy = guesser.decideStrategy('')
        assert(strategy.instance_of? FrequencyBasedGuessStrategy)
    end    
    
    def testDecideFrequencyStrategy
        guesser = Guesser.new
        strategy = guesser.decideStrategy('a***')
        assert(strategy.instance_of? FrequencyBasedGuessStrategy)
    end
    
    def testDecideDictionaryStrategy
        guesser = Guesser.new
        strategy = guesser.decideStrategy('abc*')
        assert(strategy.instance_of? DictionaryBasedGuessStrategy)
    end
    
    def testGuess
        guesser = MockGuesser.new(MockFixedLetterStrategy.new, Set.new)
        assert_equal(guesser.guess(''), 'F')
    end
    
    def testGuessGuessedLetter
        #TODO
    end
    
    def testGuessGiveUp
        #TODO
    end
    
        
    def testGuessFiniteLoop
        #TODO
    end
    
        
    class MockFixedLetterStrategy < GuessStrategy
        def guess
            return 'F'
        end
    end
    
    class MockGiveUpStrategy < GuessStrategy
        def guess
            return '!'
        end
    end
end
