require 'test/unit'
require_relative 'mockWordProvider.rb'
require_relative '../guesser.rb'
require_relative '../game.rb'
require_relative '../invalidGameError.rb'

class GameTest < Test::Unit::TestCase

    def testSimpleWin
        game = Game.new(Guesser.new, MockWordProvider.new("word"), 10)
        word, wrongCount = game.play
        
        assert_equal(wrongCount, 9)
        assert_equal(word, 'word')
        assert(game.guesserWin)
    end

    def testMediumWin
        game = Game.new(Guesser.new, MockWordProvider.new("correct"), 10)
        word, wrongCount = game.play
        
        assert_equal(wrongCount, 1)
        assert_equal(word, 'correct')
        assert(game.guesserWin)
    end

    def testHardWin
        game = Game.new(Guesser.new, MockWordProvider.new("rhythm"), 10)
        word, wrongCount = game.play
        
        assert_equal(wrongCount, 10)
        assert_equal(word, 'r**t**')
        assert(game.wordProviderWin)
    end
    
    def testInvalidWord
        assert_raise(InvalidGameError) do
            Game.new(Guesser.new, MockWordProvider.new(""), 10).play
        end
    end
    
    def testInvalidGuessTimes
        assert_raise(InvalidGameError) do
            Game.new(Guesser.new, MockWordProvider.new("invalid"), -1).play
        end
    end

end
