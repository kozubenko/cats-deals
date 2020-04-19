module CatsDeals
  module Participants
    class BaseParticipant
      def fetch_url
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def handle_response
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end
    end
  end
end
