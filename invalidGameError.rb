class InvalidGameError < StandardError
    attr_reader :reason
    
    def initialize(reason)
      @reason = reason
    end
end