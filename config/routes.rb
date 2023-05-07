# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable/:token'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :videos, only: %i[index create]
    end
  end
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  root 'homepage#index'
  get '/*path' => 'homepage#index'
end
