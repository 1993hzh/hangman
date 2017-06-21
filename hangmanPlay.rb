require_relative 'log/logManager.rb'
require_relative 'httpClient.rb'
require_relative 'game.rb'
require_relative 'runWithRetry.rb'
require_relative 'strikinglyWordProvider.rb'
require_relative 'guesser.rb'

class HangmanPlay
    TRY_TIMES = 20
    SERVER_URI = URI.parse('https://strikingly-hangman.herokuapp.com/game/on')
    
    @@logger = LogManager.instance.getLogger
    
    def initialize()
        @httpClient = HttpClient.new(HangmanPlay::SERVER_URI)
    end
    
    def startGame
        startGame = '{"playerId": "mail@nleo.me", "action" : "startGame"}'
        res = @httpClient.sendJson(startGame)
        msg = JSON.parse(res)
        
        sessionId = msg["sessionId"]
        numberOfWordsToGuess = msg["data"]["numberOfWordsToGuess"]
        numberOfGuessAllowedForEachWord = msg["data"]["numberOfGuessAllowedForEachWord"]
        
        for i in 1..numberOfWordsToGuess
            RunWithRetry.execute([HttpServerError]) do |try|
                playGameInternal(i, sessionId, @httpClient, numberOfGuessAllowedForEachWord)
            end
        end
        return sessionId
    end
    
    def playGameInternal(index, sessionId, httpClient, allowedTimes)
        word, wrongGuessCount = Game.new(Guesser.new, StrikinglyWordProvider.new(sessionId, httpClient), allowedTimes).play
        @@logger.info("Game #{index}: guessed word: #{word}, wrong times: #{wrongGuessCount}, allowed wrong times: #{allowedTimes}")
    end

    def getScore(sessionId)
        getScore = '{"sessionId": "' + sessionId + '","action" : "getResult"}'
        res = @httpClient.sendJson(getScore)
        msg = JSON.parse(res)
        
        totalWordCount = msg["data"]["totalWordCount"]
        correctWordCount = msg["data"]["correctWordCount"]
        totalWrongGuessCount = msg["data"]["totalWrongGuessCount"]
        score = msg["data"]["score"]
        return score
    end
    
    def submitScore(sessionId)
        submitScore = '{"sessionId": "' + sessionId + '","action" : "submitResult"}'
        res = @httpClient.sendJson(getScore)
        msg = JSON.parse(res)
    end
end
