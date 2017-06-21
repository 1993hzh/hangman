require_relative 'log/logManager.rb'
require_relative 'hangmanPlay.rb'
require_relative 'runWithRetry.rb'


logger = LogManager.instance.getLogger
bestScore = 0
bestSessionId = nil
hangmanPlay = HangmanPlay.new

for i in 1..(HangmanPlay::TRY_TIMES)
    score = 0
    sessionId = nil

    RunWithRetry.execute([HttpServerError]) do |try|
        sessionId = hangmanPlay.startGame
        score = hangmanPlay.getScore(sessionId)
        File.open(File.join(File.dirname(__FILE__), "result.txt"), 'a') { |file| file.write("#{sessionId}: get score: #{score}.\n") }
    end
    
    if score > bestScore
        logger.info("Got a better score: #{score} in session #{sessionId}")
        bestScore = score
        bestSessionId = sessionId
    end
end
    
logger.info("Submit the best score ever got: #{bestScore} in session #{bestSessionId}")

#RunWithRetry.execute([HttpServerError]) do |try|
#    hangmanPlay.submitScore(bestSessionId)
#end
