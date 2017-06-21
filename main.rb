require_relative 'log/logManager.rb'
require_relative 'hangmanPlay.rb'
require_relative 'runWithRetry.rb'


SCORE_THRESHOLD = 1100
logger = LogManager.instance.getLogger

hangmanPlay = HangmanPlay.new
for i in 1..(HangmanPlay::TRY_TIMES)
    RunWithRetry.execute([HttpServerError]) do |try|
        sessionId = hangmanPlay.startGame
        score = hangmanPlay.getScore(sessionId)
        File.open(File.join(File.dirname(__FILE__), "result.txt"), 'a') { |file| file.write("#{sessionId}: get score: #{score}.\n") }
        
        if score > SCORE_THRESHOLD
        logger.info("Submit the score got: #{score} in session #{sessionId}")
            hangmanPlay.submitScore(sessionId)
        end
    end
end

