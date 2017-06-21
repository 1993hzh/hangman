require 'test/unit'
require_relative '../dictionary.rb'

class DictionaryTest < Test::Unit::TestCase

    def testCollect
        dictionary = Dictionary.new
        assert_equal(dictionary.collect('diction*ry'), {"a" => 1})
    end
    
    def testWordSet
        dictionary = Dictionary.new
        
        superWordSet = dictionary.currentWordSet
        dictionary.collect('dicti***ry')
        assert(dictionary.currentWordSet.subset?(superWordSet))
        
        superWordSet = dictionary.currentWordSet
        dictionary.collect('dictio**ry')
        assert(dictionary.currentWordSet.subset?(superWordSet))
        
        superWordSet = dictionary.currentWordSet
        dictionary.collect('diction*ry')
        assert(dictionary.currentWordSet.subset?(superWordSet))
    end
end
