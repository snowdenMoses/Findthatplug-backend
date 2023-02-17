Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace "api" do
    namespace "v1" do
      resources :users
      resources :products
      resources :categories
      resources :images
    end
  end

  post 'authenticate', to: 'application#authenticate'
  get 'logout', to: 'application#logout'
end
