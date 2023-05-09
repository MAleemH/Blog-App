Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    resources :posts do
      resources :comments
      resources :likes, only: [:create, :destroy]
    end
  end
end
