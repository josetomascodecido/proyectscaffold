Rails.application.routes.draw do


  devise_for :users, controllers: {
              registrations: 'users/registrations'
  }
  resources :stores do
    resources :products do
      resources :orders, only: [:index, :create]
      # buscar rutas custom to: as:
    end
  end

  root to: 'stores#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
