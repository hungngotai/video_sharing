Rails.application.routes.draw do
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
