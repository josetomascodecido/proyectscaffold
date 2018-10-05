Rails.application.routes.draw do

  get 'orders/create'
  devise_for :users, controllers: {
              registrations: 'users/registrations'
  }
  resources :stores do
    resources :products
  end
  root to: 'stores#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
