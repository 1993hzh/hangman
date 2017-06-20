require 'test/unit'
require_relative 'MockWordProvider'
require_relative '../Guesser'
require_relative '../Game'
require_relative '../InvalidGameError'

class GameTest < Test::Unit::TestCase

    def testSimpleWin
        game = Game.new(Guesser.new, MockWordProvider.new("WORD"), 10)
        word, wrongCount = game.play
        
        assert_equal(wrongCount, 7)
        assert_equal(word, 'WORD')
        assert(game.guesserWin)
    end

    def testMediumWin
        game = Game.new(Guesser.new, MockWordProvider.new("CORRECT"), 10)
        word, wrongCount = game.play
        
        assert_equal(wrongCount, 2)
        assert_equal(word, 'CORRECT')
        assert(game.guesserWin)
    end

    def testHardWin
        game = Game.new(Guesser.new, MockWordProvider.new("RHYTHM"), 10)
        word, wrongCount = game.play
        
        assert_equal(wrongCount, 5)
        assert_equal(word, 'RHYTHM')
        assert(game.guesserWin)
    end
    
    def testInvalidWord
        assert_raise(InvalidGameError) do
            Game.new(Guesser.new, MockWordProvider.new(""), 10).play
        end
    end
    
    def testInvalidGuessTimes
        assert_raise(InvalidGameError) do
            Game.new(Guesser.new, MockWordProvider.new("INVALID"), -1).play
        end
    end
end