# frozen_string_literal: true

require 'rails_helper'

describe RequestsController do
  describe 'GET #new' do
    subject { get :new }

    it 'render new template' do
      expect(subject).to render_template(:new)
    end
  end

  describe 'GET #create' do
    subject { get :create, params: params }

    let(:params) { {location: FFaker::Lorem.word, cat_type: FFaker::Lorem.word} }

    it 'redirect to cats deals' do
      expect(subject).to redirect_to controller: 'cats_deals', action: :index, filters: params
    end
  end
end
