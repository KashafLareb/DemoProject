Rails.application.routes.draw do
  resources :articles
  root "categories#index"
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
