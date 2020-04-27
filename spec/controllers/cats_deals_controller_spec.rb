# frozen_string_literal: true

require 'rails_helper'

describe CatsDealsController do
  describe 'GET #index' do
    subject { get :index }

    let(:result) { [1, 2, 3] }
    let(:remote_service_instance) { instance_double '::RemoteServices::FetchCollections' }
    let(:analytics_service_instance) { instance_double '::RemoteServices::FetchCollections' }

    it 'render index template' do # rubocop:disable RSpec/ExampleLength
      expect(::RemoteServices::FetchCollections)
        .to receive(:new)
        .with(::ApiSources::CatsDeals::SourcesFactory)
        .and_return(remote_service_instance)

      expect(remote_service_instance).to receive(:run).once.and_return(result)

      expect(::CatsDeals::BestPrice).to receive(:new).with(result, {}).and_return(analytics_service_instance)
      expect(analytics_service_instance).to receive(:run).once.and_return(result)

      expect(subject).to render_template(:index)
    end
  end
end
