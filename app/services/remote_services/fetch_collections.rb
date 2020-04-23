require_relative "api_base"

module RemoteServices
  class FetchCollections < ApiBase
    def initialize(sources_factory)
      super(sources_factory)
      @storage = []
    end

    private

    def add_to_storage(response)
      storage.push(*response)
    end
  end
end
