require 'net/http'
require 'json'
require "logger"
require_relative "HttpServerError"

class HttpClient

    @@logger = Logger.new(STDOUT)
    @@logger.level = Logger::INFO
    
    def initialize(uri)
        @uri = uri
    end
    
    def sendJson(data)
        #check data if it is JSON format, raise error if not
        JSON.parse(data)
        
        protocol = Net::HTTP.new(@uri.host, @uri.port)
        protocol.use_ssl = (@uri.scheme == "https")
        request = Net::HTTP::Post.new(@uri.request_uri, 'Content-Type' => 'application/json')
        request.body = data
        @@logger.info("Sending msg: #{data} to server..")
        response = protocol.request(request)
        
        case response
        when Net::HTTPSuccess then
            @@logger.info("Receive #{response.body} from server.")
            return response.body
        when Net::HTTPRedirection then
            raise HttpServerError, "Redirect occurred: #{response['location']}"
        else
            raise HttpServerError, "Error received from server: #{response.body}"
        end
    end
end