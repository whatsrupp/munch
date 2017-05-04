Rails.application.routes.draw do
  root "restaurants#index"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants do
    resources :reviews
  end
end
