require_relative '../wordProvider.rb'

class MockWordProvider < WordProvider

    def initialize(word)
        @word = word
        @currentWord = WordProvider::ENCRYPTED_LETTER * @word.length
        @wrongGuessCount = 0
    end

    def giveWord
        return @currentWord.dup
    end
    
    def respond(letter)
        #TODO what if guesser guess a letter that already guessed, could be a infinite loop
        letter = letter.downcase
        if @word.include? letter
            @word.each_char.with_index do |char, index|
                if char == letter
                    @currentWord[index] = char
                end
            end
        else
            @wrongGuessCount = @wrongGuessCount + 1
        end
        
        return @currentWord.dup, @wrongGuessCount
    end
    
end
