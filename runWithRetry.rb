module RunWithRetry
    @@logger = Logger.new(STDOUT)
    @@logger.level = Logger::INFO

    def self.execute(exceptions, retries: 10, delay: 3)
        try = 0
        begin
            yield try
        rescue *exceptions => e
            try += 1
            if try <= retries
                sleep delay
                @@logger.error("#{e.reason}, retrying..")
                retry
            else
                raise
            end
        end
  end

end