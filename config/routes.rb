# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "requests#new"

  resource :request, only: %i[create new]
  resources :cats_deals, only: %i[index]
end
