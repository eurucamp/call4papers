require 'forwardable'
require 'chillout/server_side'
require 'chillout/http_client'
require 'chillout/error_filter'
require 'chillout/dispatcher'
require 'chillout/config'
require 'chillout/error'

module Chillout
  class Client
    extend Forwardable

    def_delegators :@dispatcher, :dispatch_error, :send_error

    attr_reader :config

    def initialize(config_or_api_key, options = {})
      build_config(config_or_api_key, options)

      yield @config if block_given?

      @http_client = HttpClient.new(@config)
      @server_side = ServerSide.new(@config, @http_client)
      @filter      = ErrorFilter.new
      @dispatcher  = Dispatcher.new(@filter, @server_side)
    end

    def send_exception(exception, environment = {})
      send_error(Error.new(exception, environment))
    end

    private
    def build_config(config_or_api_key, options)
      case config_or_api_key
      when Config
        @config = config_or_api_key
      when String
        @config = Config.new(config_or_api_key)
      else
        raise ArgumentError.new("Invalid config passed")
      end
      @config.update(options)
    end

  end
end
