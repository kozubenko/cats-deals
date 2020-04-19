require_relative "base_participant"

module CatsDeals
  module Participants
    class UnlimitedCats < BaseParticipant
      def fetch_url
        ENV["UNLIMITED_CATS_API_URL"]
      end

      def handle_response(response)
        ResponseHandler.new(response).parse
      end
    end
  end
end
