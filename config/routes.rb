Rails.application.routes.draw do
  resources :meals
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "meals#index"
  
  get '/stats', to: 'meals#stats'

  # Defines the root path route ("/")
  # root "articles#index"
end
