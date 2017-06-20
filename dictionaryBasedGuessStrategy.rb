require 'Set'
require_relative 'Game'
require_relative 'WordProvider'
require_relative 'GuessStrategy'

class DictionaryBasedGuessStrategy < GuessStrategy

    @@dictionaryWordSet = Set.new
    
    def initialize(word)
        initializeSetWithFile
        
        @word = word
        @currentWord = nil
        @currentFrequencyTable = nil
        @currentIndex = 0
    end

    def guess(game, guessedLetters)
        if !(game.word == @currentWord)
            @currentWord = game.word
            @currentFrequencyTable = getFrequencyTable(game.word)
            @currentIndex = 0
        end
        
        letter = nil
        begin
            if @currentIndex >= @currentFrequencyTable.size
                return Game::GIVE_UP_FLAG
            end
            
            letter = @currentFrequencyTable.keys[@currentIndex]
            @currentIndex = @currentIndex + 1
        end while guessedLetters.include? letter.downcase
        
        return letter
    end
    
    def getFrequencyTable(word)
        tempWordSet = nil
        if word.length <= 5
            tempWordSet =  @@lessFiveWordSet
        elsif word.length <= 8
            tempWordSet =  @@fiveToEightWordSet
        elsif word.length <= 12
            tempWordSet =  @@eightToTwelveWordSet
        else
            tempWordSet =  @@overTwelveWordSet
        end
        
        targetWordSet = Set.new
        reg = getRegExp(word)
        tempWordSet.each do |w|
            if w.match?(reg)
                targetWordSet.add(w)
            end
        end
        
        index = word.index(WordProvider::ENCRYPTED_LETTER)
        wordFrequency = Hash.new
        targetWordSet.each do |w|
            ch = w[index]
            count = wordFrequency.has_key?(ch) ? wordFrequency[ch] : 0
            count = count + 1
            wordFrequency[ch] = count
        end
        
        return wordFrequency.sort_by {|_key, value| value}.reverse.to_h
    end
    
    def getRegExp(word)
        word = word.dup
        word.each_char.with_index do |char, index|
            if char === WordProvider::ENCRYPTED_LETTER
                word[index] = '.'
            end
        end
        return Regexp.new("^#{word.downcase}$").freeze
    end
    
    def initializeSetWithFile
        File.open(File.join(File.dirname(__FILE__), "data/dictionary.txt"), "r") do |f|
            f.each_line do |word|
                @@dictionaryWordSet.add(word.strip)
            end
        end
        return @@dictionaryWordSet.freeze
    end
end