require_relative 'log/logManager.rb'

module RunWithRetry
    @@logger = LogManager.instance.getLogger

    def self.execute(exceptions, retries: 10, delay: 3)
        try = 0
        begin
            yield try
        rescue *exceptions => e
            try += 1
            if try <= retries
                @@logger.info("#{e.reason}, retrying..")
                sleep delay
                retry
            else
                raise
            end
        end
  end

end
