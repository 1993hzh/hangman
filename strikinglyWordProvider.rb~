require_relative 'WordProvider'
require_relative 'HttpClient'

class StrikinglyWordProvider < WordProvider

    def initialize(sessionId, httpClient)
        @sessionId = sessionId
        @httpClient = httpClient
    end

    def giveWord
        res = nil
        RunWithRetry.execute([HttpServerError]) do |try|
            giveMeWord = '{"sessionId": "' + @sessionId + '","action" : "nextWord"}'
            res = @httpClient.sendJson(giveMeWord)
        end
        msg = JSON.parse(res)
        
        word = msg["data"]["word"]
        totalWordCount = msg["data"]["totalWordCount"]
        wrongGuessCountOfCurrentWord = msg["data"]["wrongGuessCountOfCurrentWord"]
        
        return word.dup
    end
    
    def respond(letter)
        res = nil
        RunWithRetry.execute([HttpServerError]) do |try|
            guessWord = '{"sessionId": "' + @sessionId + '","action" : "guessWord","guess" : "' + letter + '"}'
            res = @httpClient.sendJson(guessWord)
        end
        msg = JSON.parse(res)
        
        currentWord = msg["data"]["word"]
        totalWordCount = msg["data"]["totalWordCount"]
        wrongGuessCountOfCurrentWord = msg["data"]["wrongGuessCountOfCurrentWord"]
        
        return currentWord.dup, wrongGuessCountOfCurrentWord
    end
end