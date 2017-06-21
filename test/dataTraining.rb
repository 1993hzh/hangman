require 'set'
require "singleton"
require_relative 'mockWordProvider.rb'
require_relative '../guesser.rb'
require_relative '../game.rb'
require_relative '../log/logManager.rb'

class DataTraining

    @@logger = LogManager.instance.getLogger
    
    def testTrainingData
        gameResult = Hash.new
        DataTraining::WordSet.instance.trainingData.each_with_index do |w, i|
            @@logger.info("Game#{i} started.")
            game = Game.new(Guesser.new, MockWordProvider.new(w), 10)
            word, wrongCount = game.play
            
            if gameResult.has_key?(word) && !word.include?('*')
                raise StandardError, "Same word found: #{word}"
            end
            gameResult[word] = wrongCount
        end
        
        gameResult.keys.each do |key|
            if !key.include?('*')
                @@logger.info("Word: \"#{key}\", wrongCount: #{gameResult[key]}")
            end
        end
        
        failedSize = gameResult.keys.select{|key| key.include?('*')}.to_a.size
        guessedWords = gameResult.values.select{|v| v < 10}
        wrongCountAvg = guessedWords.inject(0.0) { |sum, el| sum + el } / guessedWords.size
        @@logger.info("Average wrongCount for guessed out words: #{wrongCountAvg}, total fail #{failedSize} in 1000 given words.")
    end
        
    class WordSet
        include Singleton
        
        @@trainingData = Set.new
        def initialize
            File.open(File.join(File.dirname(__FILE__), "../data/trainingData.txt"), "r") do |f|
                f.each_line do |word|
                    @@trainingData.add(word.strip)
                end
            end
            return @@trainingData.freeze
        end
        
        def trainingData
            @@trainingData
        end
    end
end