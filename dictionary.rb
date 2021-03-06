require 'set'
require "singleton"
require_relative 'wordProvider.rb'

class Dictionary

    LETTER_PATTERN = '.'
    
    def initialize()
        @currentWordSet = Dictionary::WordSet.instance.all.dup
    end

    def collect(word)
        reg = Regexp.new("^#{word.dup.gsub!(WordProvider::ENCRYPTED_LETTER, LETTER_PATTERN).downcase}$").freeze
        @currentWordSet = @currentWordSet.select{|w| w.match?(reg)}.to_set

        wordFrequency = Hash.new
        index = word.index(WordProvider::ENCRYPTED_LETTER)
        @currentWordSet.each do |w|
            ch = w[index]
            count = wordFrequency.has_key?(ch) ? wordFrequency[ch] : 0
            count = count + 1
            wordFrequency[ch] = count
        end
        
        return wordFrequency.sort_by {|_key, value| value}.reverse.to_h
    end
    
    attr_reader :currentWordSet
    
    class WordSet
        include Singleton
        
        @@all = Set.new
        def initialize
            File.open(File.join(File.dirname(__FILE__), "data/dictionary.txt"), "r") do |f|
                f.each_line do |word|
                    @@all.add(word.strip)
                end
            end
            return @@all.freeze
        end
        
        def all
            @@all
        end
    end
end
