require 'time'

module Chillout
  class ServerSide

    def initialize(config, http_client)
      @config      = config
      @http_client = http_client
    end

    def send_error(error)
      send_event(build_error(error))
    end

    def send_event(data)
      @http_client.post('/events', data)
    end

    private
    def build_error(error)
      {
        event: "exception",
        timestamp: timestamp,
        content: {
          class: error.exception_class,
          message: error.message,
          backtrace: error.backtrace,
          file: error.file,
          environment: @config.environment,
          context: {
            platform: @config.platform,
            controller: error.controller_name,
            action: error.controller_action,
            current_user: {
              id: error.current_user_id,
              email: error.current_user_email,
              full_name: error.current_user_full_name
            }
          },
          rack_environment: build_rack_environment(error),
          shell_environment: @config.shell_environment
        },
        notifier: {
          name: @config.notifier_name,
          version: @config.version,
          url: @config.notifier_url
        }
      }
    end

    def build_rack_environment(error)
      Hash[error.environment.collect do |key, value|
        [key, value.to_s]
      end]
    end

    def timestamp
      Time.now.iso8601
    end

  end
end
