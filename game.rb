require_relative 'WordProvider'
require_relative 'Guesser'
require_relative 'InvalidGameError'

class Game

    GIVE_UP_FLAG = '!'
    
    def initialize(guesser, wordProvider, numberOfGuessAllowedForEachWord)
        @guesser = guesser
        @wordProvider = wordProvider
        @numberOfGuessAllowedForEachWord = numberOfGuessAllowedForEachWord
        @wrongGuessCountOfCurrentWord = 0
        @word = wordProvider.giveWord
        @guesserGiveUp = false
    end
    
    def play
        if @word == nil || @word.length == 0
            raise InvalidGameError, "invalid word given by wordProvider"
        elsif @numberOfGuessAllowedForEachWord < 0
            raise InvalidGameError, "invalid guess times given by wordProvider"
        end
    
        while !isOver do
            letter = @guesser.guess(self)
            if letter == GIVE_UP_FLAG
                @guesserGiveUp = true
            else
                respondWord, wrongGuessCount = @wordProvider.respond(letter)
                @word = respondWord
                @wrongGuessCountOfCurrentWord = wrongGuessCount
            end
        end
        
        return @word, @wrongGuessCountOfCurrentWord
    end
    
    def isOver
        return guesserWin || wordProviderWin
    end
    
    def guesserWin
        return !(@word.include? WordProvider::ENCRYPTED_LETTER)
    end
    
    def wordProviderWin
        return @guesserGiveUp || @wrongGuessCountOfCurrentWord >= @numberOfGuessAllowedForEachWord
    end
    
    attr_reader :wrongGuessCountOfCurrentWord, :word, :numberOfGuessAllowedForEachWord
end