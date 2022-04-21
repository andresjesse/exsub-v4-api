Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users,
            controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations'
            }
  get '/user-data', to: 'users#show'

  namespace :api do
    namespace :v1 do
      resources :teams do
        resources :students
      end
    end
  end
end
