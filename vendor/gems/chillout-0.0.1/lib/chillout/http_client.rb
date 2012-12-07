require 'net/http'
require 'json'

module Chillout
  class HttpClient

    MEDIA_TYPE = "application/vnd.chillout.v1+json"

    def initialize(config)
      @config = config
    end

    def post(path, data)
      request_spec = Net::HTTP::Post.new(path)
      request_spec.body = JSON.dump(data)
      request_spec.content_type = MEDIA_TYPE
      request_spec.basic_auth @config.authentication_user, @config.authentication_password
      Net::HTTP.start(@config.hostname, @config.port) do |http|
        http.request(request_spec)
      end
    end

  end
end
