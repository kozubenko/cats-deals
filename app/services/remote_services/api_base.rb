module RemoteServices
  class ApiBase
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
      elsif response.timed_out?
        Rails.logger.error("Got a time out for #{source.class}")
      elsif response.code == 0
        Rails.logger.error(<<-TEXT.squish)
          Could not get an http response, something's wrong for #{source.class},
          message: #{response.return_message}
        TEXT
      else
        Rails.logger.error("HTTP request failed with #{response.code} for #{source.class}")
      end
    end

    def add_to_storage(_response)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end
