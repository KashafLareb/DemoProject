Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :articles do
    resources :comments
  end
  root "categories#index"
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
