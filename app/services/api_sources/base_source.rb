module ApiSources
  class BaseSource
    def fetch_url
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def options
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def handle_response(_response)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end
