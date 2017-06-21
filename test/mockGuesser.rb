require 'set'
require_relative '../guesser.rb'

class MockGuesser < Guesser

    THRESHOLD = 3
    ALPHABET_LENGTH = 26

    def initialize(strategy, guessedLetters)
        @guessedLetters = Set.new
        @strategy = strategy
    end
    
    def decideStrategy(word)
        @strategy
    end
end
