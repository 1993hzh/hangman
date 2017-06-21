require "singleton"
require "logger"

class LogManager
    include Singleton
    
    def initialize
        file = File.open(File.join(File.dirname(__FILE__), "hangman.log"), File::WRONLY | File::APPEND)
        @@logger = Logger.new(LogManager::MultiIO.new(STDOUT, file))
        @@logger.datetime_format = "%Y-%m-%d %H:%M:%S"
        @@logger.formatter = proc do |severity, datetime, progname, msg|
            "#{datetime} #{severity}: #{msg}\n"
        end
        @@logger.level = Logger::INFO
    end
    
    def getLogger
        @@logger
    end
    
    class MultiIO
        def initialize(*targets)
            @targets = targets
        end

        def write(*args)
            @targets.each {|t| t.write(*args)}
        end

        def close
            @targets.each(&:close)
        end
    end
end