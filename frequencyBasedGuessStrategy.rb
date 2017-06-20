require_relative 'GuessStrategy'
require_relative 'Game'

class FrequencyBasedGuessStrategy < GuessStrategy

    @@ALPHABET_LENGTH = 26
    @@MOST_FREQUENT_FIRST_LETTERS = ['t','o','a','w','b','c','d','s','f','m','r','h','i','y','e','g','l','n','p','u','v','j','k','q','z','x'].freeze
    @@MOST_FREQUENT_LETTERS = ['E','A','R','I','O','T','N','S','L','C','U','D','P','M','H','G','B','F','Y','W','K','V','X','Z','J','Q'].freeze
    
    def initialize
        @frequentLetterIndex = 0
    end

    def guess
        if @frequentLetterIndex >= @@ALPHABET_LENGTH
            return Game::GIVE_UP_FLAG
        end
        
        #letter = @@MOST_FREQUENT_FIRST_LETTERS[@frequentLetterIndex]
        letter = @@MOST_FREQUENT_LETTERS[@frequentLetterIndex]
        @frequentLetterIndex = @frequentLetterIndex + 1
        return letter.upcase
    end
    
    def getGuessedLetters
        @@MOST_FREQUENT_LETTERS[0..(@frequentLetterIndex - 1)].map!(&:downcase)
    end
end