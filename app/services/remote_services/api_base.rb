module RemoteServices
  class ApiBase
    include InterfaceMethodConcern
    attr_reader :hydra, :factory, :storage

    def initialize(sources_factory)
      @hydra = Typhoeus::Hydra.new
      @factory = sources_factory
    end

    def run
      generate_requests
      hydra.run

      storage
    end

    private

    def generate_requests
      data_sources.each do |source|
        build_request(source)
      end
    end

    def build_request(source)
      request = Typhoeus::Request.new(source.fetch_url, source.options)
      hydra.queue(request)

      request.on_complete do |response|
        process_response(response, source)
      end
    end

    def data_sources
      sources_factory = factory.new
      factory
        .instance_methods(false)
        .map { |source| sources_factory.public_send(source) }
    end

    def process_response(response, source)
      if response.success?
        add_to_storage(source.handle_response(response))
      else
        handle_failed_response(response, source)
      end
    end

    def handle_failed_response(response, source)
      if response.timed_out?
        log_error("Got a time out for #{source.class}")
      elsif response.code.zero?
        log_error(<<-TEXT.squish)
          Could not get an http response, something's wrong for #{source.class},
          message: #{response.return_message}
        TEXT
      else
        log_error("HTTP request failed with #{response.code} for #{source.class}")
      end
    end

    def log_error(error)
      Rails.logger.error(error)
    end

    define_private_interface_method(:add_to_storage)
  end
end
