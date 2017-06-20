class WordProvider

    ENCRYPTED_LETTER = "*"

    def giveWord
        raise NotImplementedError, 'You must implement the parse method'
    end
    
    def respond(letter)
        raise NotImplementedError, 'You must implement the parse method'
    end
    
end