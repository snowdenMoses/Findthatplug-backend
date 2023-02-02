Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace "api" do
    namespace "v1" do
      resources :users
      post 'authenticate', to: 'auth#authenticate'
      # resources :auth, only: [:show]
    end
  end
end
