Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      # users and auth
      resources :users
      post 'auth/login', to: 'auth#login'

      # domain
      resources :teams do
        resources :students
      end
    end
  end
end
