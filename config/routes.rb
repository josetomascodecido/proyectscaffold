Rails.application.routes.draw do


  get 'geocoder/findaddress'
  devise_for :users, controllers: {
              registrations: 'users/registrations',
              :omniauth_callbacks => "users/omniauth_callbacks"
  }
  resources :stores do
    resources :products do
      resources :orders, only: [:index, :create, :destroy] do
                delete 'empty_cart', on: :collection
              end
      # buscar rutas custom to: as:
    end
  end

  root to: 'stores#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
